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
$HOME/dev/config/scripts/linux/volumeLevel.sh &

xset -dpms # disable display power management signal

exec dwm
