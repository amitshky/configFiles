#! /usr/bin/env bash

rm -r $HOME/.cache/thumbnails/* 2>/dev/null
rm $HOME/.local/share/recently-used.xbel 2>/dev/null
rm $HOME/.local/share/qBittorrent/logs/qbittorrent.log 2>/dev/null
rm /tmp/yazi* -r 2>/dev/null
pkill copyq 2>/dev/null && copyq &
