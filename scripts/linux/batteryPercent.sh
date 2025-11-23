#! /usr/bin/env bash

BAT="/org/freedesktop/UPower/devices/battery_BAT1"

PERCENTAGE=$(upower -i "$BAT" | awk '/percentage/ {print $2}')
STATE=$(upower -i "$BAT" | awk '/state/ {print $2}')

case "$STATE" in
    charging)      ICON=" ";;
    discharging)   ICON="🔋 ";;
    fully-charged) ICON="✔ ";;
    *)             ICON="";;
esac

echo $ICON$PERCENTAGE
