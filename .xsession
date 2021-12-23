#!/bin/bash
i3-msg "workspace 3, move workspace to output primary"
i3-msg "workspace 2, move workspace to output primary"
i3-msg "workspace 1, move workspace to output primary"
if xrandr | grep 'primary' | grep -qv '1920x1080'
then
    [[ ! -f ~/.config/i3/config.bak ]] || grep -q 'Display 1920x1080'  ~/.config/i3/config && cp  ~/.config/i3/config ~/.config/i3/config.bak
    primary_resolution=$(xrandr | grep 'primary' | grep -Eo '[0-9][0-9]*x[0-9][0-9]*')
    change=1 && grep -q "Display $primary_resolution"  ~/.config/i3/config && change=0
    if [[ $change -ne 0 ]]
    then
        old_resolution=$(grep -Eo 'Display [0-9][0-9]*x[0-9][0-9]*'  ~/.config/i3/config | grep -Eo '[0-9][0-9]*x[0-9][0-9]*')
        old_up_landscape=$(grep "__calendar__" ~/.config/i3/config | grep -Eo "up [0-9][0-9]* px")
        old_up_portrait=$(grep "__weather__" ~/.config/i3/config | grep -Eo "up [0-9][0-9]* px")
        old_right_landscape=$(grep "__monitor__" ~/.config/i3/config | grep -Eo "right [0-9][0-9]* px")
        old_right_portrait=$(grep "__weather__" ~/.config/i3/config | grep -Eo "right [0-9][0-9]* px")
        if [[ "$primary_resolution" == "2560x1440" ]]
        then
            grep -q "font = Hack Nerd Font 9" ~/.config/dunst/dunstrc || (killall dunst && sed -i "s/font = Hack Nerd Font [0-9]*/font = Hack Nerd Font 9/g" ~/.config/dunst/dunstrc; dunst &)
            sed -ie "s/${old_up_landscape}/up 490 px/g;s/${old_up_portrait}/up 320 px/g;s/${old_right_landscape}/right 840 px/g;s/${old_right_portrait}/right 880 px/g;s/${old_resolution}/2560x1440/g;s/--dmenu='dmenu -x [0-9][0-9]* -y [0-9][0-9]* -i -l [0-9][0-9]* -w [0-9][0-9]*'/--dmenu='dmenu -x 1080 -y 550 -i -l 20 -w 400'/g" ~/.config/i3/config
            sed -ie 's/size: [0-9][0-9]*.[0-9][0-9]*/size: 9.5/' .config/alacritty/alacritty.yml
        fi
        i3-msg "restart"
    fi
else
    change=0 && (grep -Eo 'Display [0-9][0-9]*x[0-9][0-9]*' ~/.config/i3/config | grep -vq '1920x1080') && [[ -f ~/.config/i3/config.bak ]] && change=1
    if [[ $change -ne 0 ]]
    then
        old_resolution=$(grep -Eo 'Display [0-9][0-9]*x[0-9][0-9]*'  ~/.config/i3/config | grep -Eo '[0-9][0-9]*x[0-9][0-9]*')
        old_up_landscape=$(grep "__calendar__" ~/.config/i3/config | grep -Eo "up [0-9][0-9]* px")
        old_up_portrait=$(grep "__weather__" ~/.config/i3/config | grep -Eo "up [0-9][0-9]* px")
        old_right_landscape=$(grep "__monitor__" ~/.config/i3/config | grep -Eo "right [0-9][0-9]* px")
        old_right_portrait=$(grep "__weather__" ~/.config/i3/config | grep -Eo "right [0-9][0-9]* px")
        new_up_landscape=$(grep "__calendar__" ~/.config/i3/config.bak | grep -Eo "up [0-9][0-9]* px")
        new_up_portrait=$(grep "__weather__" ~/.config/i3/config.bak | grep -Eo "up [0-9][0-9]* px")
        new_right_landscape=$(grep "__monitor__" ~/.config/i3/config.bak | grep -Eo "right [0-9][0-9]* px")
        new_right_portrait=$(grep "__weather__" ~/.config/i3/config.bak | grep -Eo "right [0-9][0-9]* px")
        new_dmenu=$(grep -Eo -- "--dmenu='dmenu -x [0-9][0-9]* -y [0-9][0-9]* -i -l [0-9][0-9]* -w [0-9][0-9]*'" ~/.config/i3/config.bak)
        grep -q "font = Hack Nerd Font 8" ~/.config/dunst/dunstrc || (killall dunst && sed -i "s/font = Hack Nerd Font [0-9]*/font = Hack Nerd Font 8/g" ~/.config/dunst/dunstrc; dunst &)
        sed -ie "s/${old_up_landscape}/${new_up_landscape}/g;s/${old_up_portrait}/${new_up_portrait}/g;s/${old_right_landscape}/${new_right_landscape}/g;s/${old_right_portrait}/${new_right_portrait}/g;s/${old_resolution}/1920x1080/g;s/--dmenu='dmenu -x [0-9][0-9]* -y [0-9][0-9]* -i -l [0-9][0-9]* -w [0-9][0-9]*'/${new_dmenu}/g" ~/.config/i3/config
        sed -ie 's/size: [0-9][0-9]*.[0-9][0-9]*/size: 7.0/' .config/alacritty/alacritty.yml
        i3-msg "restart"
    fi
fi
if [[ "$(xrandr --listactivemonitors | wc -l)" -ne $ACTIVE_MONITOR ]]
then
    i3-msg "restart"
fi
