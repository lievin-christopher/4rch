#!/bin/bash
killall polybar
export MONITOR=$(polybar --list-monitors | cut -f1 -d':'| tail -n 1)
export WIRELESS=$(ip link | cut -f2 -d':' | grep wl | tr -d ' ' | head -n 1)
export WIRELESS2=$(ip link | cut -f2 -d':' | grep wl | tr -d ' ' | tail -n 1)
export WIRED=$(ip link | cut -f2 -d':' | grep en | tr -d ' ' | head -n 1)
export WIRED2=$(ip link | cut -f2 -d':' | grep en | tr -d ' ' | tail -n 1)
polybar top -r