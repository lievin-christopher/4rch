#!/bin/bash
dunstctl set-paused true
i3lock -t -i .config/i3/lock.jpg --time-pos="150:h-190" --date-pos="150:h-150" --clock --date-str "$(date "+%A %d %b %Y")" --inside-color=00000000 --ring-color=00000000 --line-uses-inside --keyhl-color=00000000 --bshl-color=00000000 --separator-color=00000000 --insidever-color=00000000 --insidewrong-color=00000000 --ringver-color=00000000 --ringwrong-color=00000000 --ind-pos="x+280:h-70" --radius=20 --ring-width=4 --verif-text="" --wrong-text="" --verif-color="00000000" --time-color="ffffffff" --date-color="ffffffff" --date-font=Hack --time-font=Hack --time-size=40 --date-size=30 --date-align 1 --time-align 1
while pgrep -c i3lock &> /dev/null
do
    sleep 5
done
dunstctl set-paused false