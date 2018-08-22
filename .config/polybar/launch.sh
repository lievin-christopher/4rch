#!/bin/bash
killall polybar
export MONITOR=$(polybar --list-monitors | cut -f1 -d':')
export WIRELESS=$(ip link | cut -f2 -d':' | grep wl | tr -d ' ')
export WIRED=$(ip link | cut -f2 -d':' | grep en | tr -d ' ')
polybar top -r