#!/bin/bash
killall polybar
export MONITOR=$(xrandr --listmonitors 2> /dev/null | grep "*" | cut -f6 -d' ')
export WIRELESS=$(ip link | cut -f2 -d':' | grep wl | tr -d ' ' | head -n 1)
export WIRELESS2=$(ip link | cut -f2 -d':' | grep wl | tr -d ' ' | head -n 2 | tail -n 1 | grep -vE ^$WIRELESS$)
export WIRED=$(ip link | cut -f2 -d':' | grep en | tr -d ' ' | head -n 1)
export WIRED2=$(ip link | cut -f2 -d':' | grep en | tr -d ' ' | head -n 2 | tail -n 1 | grep -vE ^$WIRED$)
polybar top -r