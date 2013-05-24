#!/bin/sh
### BEGIN INIT INFO
# Provides:          aptitude-robot
# Required-Start:    $network $local_fs $remote_fs
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: performs upgrades/installs/removes of software packages
# Description:       calls `aptitude install ~U` with additional
#                    parameters indicating software packages to be
#                    installed/removed/purged on top of the regular
#                    upgrade
### END INIT INFO

# Author: Elmar S. Heeb <elmar@heebs.ch>

PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC=aptitude-robot
NAME=aptitude-robot
SCRIPT=/usr/sbin/aptitude-robot-session
SCRIPTNAME=/etc/init.d/$NAME

# Exit if the package is not installed
[ -x $SCRIPT ] || exit 0

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

case "$1" in
  start)
    [ "$RUN_ON_BOOT" = "no" ] && exit 0
    sleep 5  # wait for network to fully come up (Required-Start: $network seems not to be enough)
    [ "$VERBOSE" != no ] && log_daemon_msg "Running $DESC " "$NAME"
    if fuser -s /var/lib/dpkg/lock ; then
        if [ "$VERBOSE" != no ]; then
            log_progress_msg "INFO: aptitude-robot init.d preventing recursive call while updating"
            log_end_msg 0
        fi
        exit 0
    fi
    $SCRIPT
    case "$?" in
        0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
        2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
    esac
  ;;
  stop|restart|force-reload)
    [ "$VERBOSE" != no ] && log_daemon_msg "$1 $DESC (does nothing)" "$NAME"
  ;;
  *)
    echo "Usage: $SCRIPTNAME start" >&2
    exit 3
    ;;
esac

:
