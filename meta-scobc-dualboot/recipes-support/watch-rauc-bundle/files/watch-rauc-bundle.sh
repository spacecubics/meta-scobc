#!/bin/sh
set -eu

WATCH_DIR="/srv/data/artifacts"
BUNDLE_NAME="bundle.raucb"
BUNDLE_PATH="$WATCH_DIR/$BUNDLE_NAME"

SCRIPT="/usr/sbin/boot-to-golden"

[ -d "$WATCH_DIR" ] || exit 0

while :; do
	fname=$(/usr/bin/inotifywait -e close_write --format '%f' "$WATCH_DIR")
	[ "$fname" = "$BUNDLE_NAME" ] || continue

	if [ "$fname" = "$BUNDLE_NAME" ] && [ -f "$BUNDLE_PATH" ]; then
		logger -t watch-rauc-bundle "Detected $BUNDLE_PATH; running boot-to-golden"

		if /usr/bin/rauc info "$BUNDLE_PATH" > /dev/null 2>&1; then
			logger -t watch-rauc-bundle "RAUC bundle verification succeeded"
			exec "$SCRIPT"
		else
			logger -t watch-rauc-bundle "RAUC bundle verification failed"
		fi
	fi
done
