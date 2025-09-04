#!/bin/sh

class=$(hyprctl activewindow -j | jq -r .class)

if [ "$class" = "Alacritty" ]; then
    hyprctl dispatch sendshortcut "CTRL SHIFT, C,"
else
    hyprctl dispatch sendshortcut "CTRL, C,"
fi
