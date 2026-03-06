#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <time.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/ioctl.h>
#include <linux/watchdog.h>
#include <systemd/sd-journal.h>

#ifndef XILINX_FPD_WWDT_TIMEOUT
#define XILINX_FPD_WWDT_TIMEOUT 30
#endif

#ifndef XILINX_FPD_WWDT_CLOSED_WINDOW_PERCENT
#define XILINX_FPD_WWDT_CLOSED_WINDOW_PERCENT 50
#endif

// ref. linux-xlnx/drivers/watchdog/xilinx_wwdt.c
#define DEFAULT_CLOSED_WINDOW_PERCENT 50

/*
 * Fraction of the open window used to schedule the watchdog kick.
 * The kick is sent at:
 *
 *     closed_window + open_window * (NUM / DEN)
 *
 * Using 3/8 places the kick safely inside the open window (slightly
 * after it begins) while keeping enough margin before the timeout.
 */
#define OPEN_WINDOW_FRACTION_NUM 3
#define OPEN_WINDOW_FRACTION_DEN 8

#ifndef WATCHDOG_DEVICE
#define WATCHDOG_DEVICE "/dev/watchdog0"
#endif

static volatile sig_atomic_t running = 1;

static int verbose = 0;

static void handle_signal(int sig)
{
	(void)sig;
	running = 0;
}

static int sleep_ms_interruptible(unsigned long ms)
{
	struct timespec req, rem;

	req.tv_sec = ms / 1000;
	req.tv_nsec = (ms % 1000) * 1000000UL;

	while (nanosleep(&req, &rem) < 0) {
		if (errno == EINTR) {
			/*
			 * SIGINT/SIGTERM requests shutdown and sets running = 0.
			 * Other signals may also interrupt nanosleep(), in which case
			 * we continue sleeping for the remaining time.
			 */
			if (!running) {
				return 0;
			}
			req = rem;
			continue;
		}
		sd_journal_print(LOG_ERR, "nanosleep failed: %m");
		return -1;
	}

	return 0;
}

int main(int argc, char *argv[])
{
	const char *dev = WATCHDOG_DEVICE;
	int fd;
	int ret;
	int timeout = 0;
	int closed_window_percent = XILINX_FPD_WWDT_CLOSED_WINDOW_PERCENT;

	unsigned long total_ms;
	unsigned long closed_ms;
	unsigned long open_ms;
	unsigned long kick_delay_ms;

	for (int i = 1; i < argc; i++) {
		if (strcmp(argv[i], "--verbose") == 0 || strcmp(argv[i], "-v") == 0) {
			verbose = 1;
		} else {
			sd_journal_print(LOG_ERR, "Unknown argument: %s", argv[i]);
			return 1;
		}
	}

	struct sigaction sa;
	memset(&sa, 0, sizeof(sa));
	sa.sa_handler = handle_signal;
	sigemptyset(&sa.sa_mask);

	if (sigaction(SIGINT, &sa, NULL) < 0) {
		sd_journal_print(LOG_ERR, "sigaction(SIGINT) failed: %m");
		return 1;
	}

	if (sigaction(SIGTERM, &sa, NULL) < 0) {
		sd_journal_print(LOG_ERR, "sigaction(SIGTERM) failed: %m");
		return 1;
	}

	fd = open(dev, O_WRONLY | O_CLOEXEC);
	if (fd < 0) {
		sd_journal_print(LOG_ERR, "Failed to open %s: %m", dev);
		return 1;
	}

	ret = ioctl(fd, WDIOC_GETTIMEOUT, &timeout);
	if (ret < 0 || timeout <= 0) {
		sd_journal_print(LOG_WARNING,
				 "WDIOC_GETTIMEOUT failed, fallback to default timeout %d sec: %m",
				 XILINX_FPD_WWDT_TIMEOUT);
		timeout = XILINX_FPD_WWDT_TIMEOUT;
	}

	/*
	 * xilinx_wwdt does not expose the effective closed window percentage
	 * to userland.
	 *
	 * In our system, this value is configured together with the kernel
	 * driver from the same build-time setting, so they normally match.
	 * If an invalid value is given, the driver falls back to its internal
	 * default, so we mirror the same fallback here.
	 */
	if (closed_window_percent <= 0 || closed_window_percent >= 100) {
		closed_window_percent = DEFAULT_CLOSED_WINDOW_PERCENT;
	}

	total_ms = (unsigned long)timeout * 1000UL;
	closed_ms = total_ms * (unsigned long)closed_window_percent / 100UL;
	open_ms = total_ms - closed_ms;

	kick_delay_ms = closed_ms + (open_ms * OPEN_WINDOW_FRACTION_NUM) / OPEN_WINDOW_FRACTION_DEN;

	/*
	 * Avoid kick timings too close to the window boundaries.
	 * Scheduling jitter or timing inaccuracies could otherwise cause
	 * the kick to fall into the closed window.
	 */
	if (kick_delay_ms <= closed_ms) {
		kick_delay_ms = closed_ms + 100;
	}
	if (kick_delay_ms >= total_ms) {
		kick_delay_ms = total_ms - 100;
	}

	if (verbose) {
		sd_journal_print(LOG_INFO, "Watchdog timeout           : %d sec", timeout);
		sd_journal_print(LOG_INFO, "Closed window percent      : %d %%",
				 closed_window_percent);
		sd_journal_print(LOG_INFO, "Closed window              : %lu ms", closed_ms);
		sd_journal_print(LOG_INFO, "Open window                : %lu ms", open_ms);
		sd_journal_print(LOG_INFO, "Kick delay from (re)start  : %lu ms", kick_delay_ms);
	}

	sd_journal_print(LOG_INFO, "Watchdog keepalive loop started.");

	/*
	 * Main keepalive loop.
	 * Do not exit on transient errors; keep trying to service the watchdog.
	 */
	while (running) {
		ret = sleep_ms_interruptible(kick_delay_ms);
		if (ret < 0) {
			sd_journal_print(LOG_WARNING, "sleep failed, continuing: %m");
			continue;
		}

		if (!running) {
			break;
		}

		ret = ioctl(fd, WDIOC_KEEPALIVE, 0);
		if (ret < 0) {
			sd_journal_print(LOG_ERR, "WDIOC_KEEPALIVE failed: %m");
			continue;
		}

		if (verbose) {
			sd_journal_print(LOG_INFO, "Sent keepalive to watchdog.");
		}
	}

	sd_journal_print(LOG_INFO, "Stopping keepalive loop.");

	/*
	 * xilinx_wwdt is nowayout and has no stop op.
	 * close(fd) does not stop the watchdog hardware; it only ends this
	 * userspace keepalive loop.
	 */
	close(fd);
	return 0;
}
