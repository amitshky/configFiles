#! /usr/bin/env bash

feh --bg-fill ~/pictures/\(@chinfongart\)\ charging.jpg
picom -b

# to help dolphin automatically detect drives
# /usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 &
# udiskie -t &

flameshot &
copyq &
dwmblocks &
syncthing --no-browser &
dunst &

~/dev/config/scripts/linux/homeSecondMonitorSetupI3.sh &
~/dev/config/scripts/linux/volumeListener.sh &
~/dev/config/scripts/linux/batterySignal.sh &
~/dev/config/scripts/linux/hideCursor.sh &

pactl set-sink-volume @DEFAULT_SINK@ 25%

export QT_QPA_PLATFORMTHEME=qt6ct
exec dwm
