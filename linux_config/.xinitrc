#! /usr/bin/env bash

feh --bg-fill ~/pictures/wallpaper.png
picom -b

flameshot &
copyq &
dwmblocks &
syncthing --no-browser &
dunst &

# for dolphin
/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 &

$HOME/dev/config/scripts/linux/use_external_monitor.sh &
$HOME/dev/config/scripts/linux/volumeSignal.sh &
$HOME/dev/config/scripts/linux/brightnessSignal.sh &
$HOME/dev/config/scripts/linux/batterySignal.sh &
$HOME/dev/config/scripts/linux/hideCursor.sh &
$HOME/dev/config/scripts/linux/volumeLevel.sh &

xset -dpms # disable display power management signal

xrdb ~/.Xresources

exec dwm
