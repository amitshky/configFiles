#!/usr/bin/env bash

upower -m | while read -r _; do
    pkill -RTMIN+5 dwmblocks
done
