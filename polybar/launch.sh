#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar
echo "---" | tee -a /tmp/polybar_mybar.log

BAR_NAME=mybar
BAR_CONFIG=/home/$USER/.config/polybar/config.ini
# polybar $BAR_NAME 2>&1 | tee -a /tmp/polybar_mybar.log & disown

# another polybar for the second monitor
if type "xrandr"; then
  PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
  OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

  # Launch on primary monitor
  MONITOR=$PRIMARY polybar --reload -c $BAR_CONFIG $BAR_NAME 2>&1 | tee -a /tmp/polybar_mybar.log & disown &
  sleep 1

  # Launch on all other monitors
  for m in $OTHERS; do
    MONITOR=$m polybar --reload -c $BAR_CONFIG $BAR_NAME 2>&1 | tee -a /tmp/polybar_mybar.log & disown &
  done
else
  polybar --reload mybar &
fi

echo "Bars launched..."
