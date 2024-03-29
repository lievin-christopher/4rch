#!/bin/bash
killall polybar
export MONITOR=$(xrandr --listmonitors 2> /dev/null | grep "*" | cut -f6 -d' ')
if [[ ! $MONITOR ]]; then export MONITOR=$(xrandr --listmonitors 2> /dev/null | tail -n +2 | head -n 1 | cut -f6 -d' ');fi
export WIRELESS=$(ip link | cut -f2 -d':' | grep wl | grep -v 'altname' | tr -d ' ' | head -n 1)
export WIRELESS2=$(ip link | cut -f2 -d':' | grep wl | grep -v 'altname' | tr -d ' ' | head -n 2 | tail -n 1 | grep -vE ^$WIRELESS$)
export WIRED=$(ip link | cut -f2 -d':' | grep -E 'en|eth' | grep -v 'altname' | tr -d ' ' | head -n 1)
export WIRED2=$(ip link | cut -f2 -d':' | grep -E 'en|eth' | grep -v 'altname' | tr -d ' ' | head -n 2 | tail -n 1 | grep -vE ^$WIRED$)
export BAT=$(ls -1 /sys/class/power_supply/ | grep -E 'BAT*' 2> /dev/null)
export TEMP=$(echo -n $(grep -E 'coretemp|cpu_thermal' /sys/class/hwmon/hwmon*/name | cut -d'/' -f1-5)'/temp1_input' 2> /dev/null)
export ALSA_MASTER=$(amixer scontrols 2> /dev/null | sed -nr "s/.*'([[:alnum:]]+)'.*/\1/p" | head -1)
export I3_TERM=$(i3-sensible-terminal -h 2>&1| head -1 | awk '{print $1}')
polybar top -r