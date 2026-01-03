#! /usr/bin/env bash

feh --bg-fill ~/pictures/sushi.jpg
picom -b

flameshot &
copyq &
dwmblocks &
syncthing --no-browser &
dunst &

$HOME/dev/config/scripts/linux/homeSecondMonitorSetupI3.sh &
$HOME/dev/config/scripts/linux/volumeListener.sh &
$HOME/dev/config/scripts/linux/batterySignal.sh &
$HOME/dev/config/scripts/linux/hideCursor.sh &

pactl set-sink-volume @DEFAULT_SINK@ 30%
xset -dpms # disable display power management signal

exec dwm
