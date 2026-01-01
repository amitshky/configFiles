#! /usr/bin/env bash

feh --bg-fill ~/pictures/DSC06863_no_watermark.jpg
picom -b

mkdir -p $HOME/.local/err

flameshot >/dev/null 2>$HOME/.local/err/flameshot.log &
copyq >/dev/null 2>$HOME/.local/err/copyq.log &
dwmblocks >/dev/null 2>$HOME/.local/err/dwmblocks.log &
syncthing --no-browser >/dev/null 2>$HOME/.local/err/syncthing.log &
dunst >/dev/null 2>$HOME/.local/err/dunst.log &

$HOME/dev/config/scripts/linux/homeSecondMonitorSetupI3.sh &
$HOME/dev/config/scripts/linux/volumeListener.sh &
$HOME/dev/config/scripts/linux/batterySignal.sh &
$HOME/dev/config/scripts/linux/hideCursor.sh &

pactl set-sink-volume @DEFAULT_SINK@ 30%
xset -dpms # disable display power management signal

exec dwm
