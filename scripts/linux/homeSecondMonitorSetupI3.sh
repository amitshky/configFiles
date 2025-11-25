#! /usr/bin/env bash

if type "xrandr"; then
  # Get the list of connected displays
  connected_displays=$(xrandr --listactivemonitors | grep -oP '^\S+')

  # Check if only eDP-1 is connected
  if [[ "$connected_displays" == "eDP-1" ]]; then
    # If only eDP-1 is connected, turn off HDMI-1-0
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-0 --off
  else
    # Otherwise, set up both displays
    # this has been commented out because my laptop's display is acting weird
    # xrandr --output eDP-1 --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-1-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal

    # only displays the second monitor
    xrandr --output eDP-1 --off --output HDMI-1-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal
  fi
fi
