#!/bin/bash
VPN_SCRIPT="~/.config/polybar/vpn.sh"
ip link show up type wireguard 2> /dev/null | grep '.' &> /dev/null && echo "%{A:i3-sensible-terminal --title '__calendar__' -e ${VPN_SCRIPT}:}%{F#02b9eb}%{A}" && exit 0 
ip link show up type tun       2> /dev/null | grep '.' &> /dev/null && echo "%{A:i3-sensible-terminal --title '__calendar__' -e ${VPN_SCRIPT}:}%{F#60b48a}%{A}" && exit 0
echo "%{A:i3-sensible-terminal --title '__calendar__' -e ${VPN_SCRIPT}:}%{F#bf616a}%{A}"
