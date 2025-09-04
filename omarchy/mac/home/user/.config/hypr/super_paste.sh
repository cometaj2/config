#!/bin/sh

class=$(hyprctl activewindow -j | jq -r .class)

if [ "$class" = "Alacritty" ]; then
    hyprctl dispatch sendshortcut "CTRL SHIFT, V,"
else
    hyprctl dispatch sendshortcut "CTRL, V,"
fi
