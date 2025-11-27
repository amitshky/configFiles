#! /usr/bin/env bash

pactl subscribe | grep --line-buffered sink | while read -r _; do
    pkill -RTMIN+10 dwmblocks
done
