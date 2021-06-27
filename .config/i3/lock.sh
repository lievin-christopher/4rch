#!/bin/bash
dunstctl set-paused true
i3lock -t -i .config/i3/lock.jpg --timepos="150:h-190" --datepos="150:h-150" --clock --datestr "$(date "+%A %d %b %Y")" --insidecolor=00000000 --ringcolor=00000000 --line-uses-inside --keyhlcolor=00000000 --bshlcolor=00000000 --separatorcolor=00000000 --insidevercolor=00000000 --insidewrongcolor=00000000 --ringvercolor=00000000 --ringwrongcolor=00000000 --indpos="x+280:h-70" --radius=20 --ring-width=4 --veriftext="" --wrongtext="" --verifcolor="00000000" --timecolor="ffffffff" --datecolor="ffffffff" --date-font=Hack --time-font=Hack --timesize=40 --datesize=30 --date-align 1 --time-align 1
while pgrep -c i3lock &> /dev/null
do
    sleep 5
done
dunstctl set-paused false