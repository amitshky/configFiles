#! /usr/bin/env bash

udevadm monitor --subsystem-match=backlight --property |
while read -r line; do
    pkill -RTMIN+9 dwmblocks
done
