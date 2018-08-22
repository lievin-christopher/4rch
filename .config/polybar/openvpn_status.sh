#!/bin/bash
echo "%{A:urxvt -T 'calendar' -e zsh -c '~/.config/polybar/openvpn.sh':}%{F#bf616a}%{A}"
running=$(pgrep openvpn |& wc -l)
test $running -eq 3 &&  echo "%{A:urxvt -T 'calendar' -e zsh -c '~/.config/polybar/openvpn.sh':}%{F#60b48a}%{A}"