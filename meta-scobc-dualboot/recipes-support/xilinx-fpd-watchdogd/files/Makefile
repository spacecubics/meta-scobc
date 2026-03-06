APP  := xilinx-fpd-watchdogd
SRCS := xilinx-fpd-watchdogd.c
OBJS := $(SRCS:.c=.o)
DEPS := $(SRCS:.c=.d)

SYSTEMD_CFLAGS := $(shell pkg-config --cflags libsystemd)
SYSTEMD_LIBS   := $(shell pkg-config --libs libsystemd)

CPPFLAGS += $(SYSTEMD_CFLAGS)
LDLIBS   += $(SYSTEMD_LIBS)

.PHONY: all clean install

all: $(APP)

$(APP): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

%.o: %.c
	$(CC) -MMD -MP -c $< -o $@ $(CFLAGS) $(CPPFLAGS)

install: $(APP)
	install -d $(DESTDIR)$(BINDIR)
	install -m 0755 $(APP) $(DESTDIR)$(BINDIR)

clean:
	rm -f $(APP) $(OBJS) $(DEPS)

-include $(DEPS)
