#!/usr/bin/env bash

BAT="/org/freedesktop/UPower/devices/battery_BAT1"

INFO="$(upower -i "$BAT")"

PERCENTAGE=$(awk '/percentage/ {print $2}' <<< "$INFO")
STATE=$(awk '/state/ {print $2}' <<< "$INFO")

case "$STATE" in
    charging)      ICON=" ";;
    discharging)   ICON="🔋 ";;
    fully-charged) ICON="✔ ";;
    *)             ICON="";;
esac

echo "$ICON$PERCENTAGE"
