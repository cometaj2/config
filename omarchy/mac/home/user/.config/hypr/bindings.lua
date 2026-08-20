-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + T")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + C")
hl.unbind("SUPER + V")
hl.unbind("SUPER + P")
hl.unbind("SUPER + O")
hl.unbind("SUPER + G")
--hl.unbind("SUPER + F")
hl.unbind("SUPER + CTRL + Q")
hl.unbind("SUPER + RETURN")
hl.unbind("SUPER + SLASH")

o.bind("SUPER + RETURN", "Terminal", "alacritty")
o.bind("SUPER + E", "File manager", "nautilus")
o.bind("SUPER + N", "Browser", "brave")
o.bind("SUPER + SLASH", "Passwords", "keeperpasswordmanager")
o.bind("SUPER + M", "Email", "brave https://mail.proton.me/u/0/inbox")
o.bind("SUPER + Y", "YouTube", "brave https://youtube.com/")

-- Mac-style keys remap
o.bind("F1", nil, "brightnessctl set 10%-")
o.bind("F2", nil, "brightnessctl set 10%+")
o.bind("F10", nil, "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
o.bind("F11", nil, "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
o.bind("F12", nil, "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")

-- Tiling control; move focus with SUPER + arrow keys (vim motion-like)
o.bind("SUPER + T", "Toggle Split", hl.dsp.layout("togglesplit"))
--o.bind("SUPER + F", "Full Screen Toggle", hl.dsp.window.fullscreen({ action = "toggle" }))
o.bind("SUPER + H", "Move focus left", hl.dsp.focus({ direction = "left" }))
o.bind("SUPER + J", "Move focus down", hl.dsp.focus({ direction = "down" }))
o.bind("SUPER + K", "Move focus up", hl.dsp.focus({ direction = "up" }))
o.bind("SUPER + L", "Move focus right", hl.dsp.focus({ direction = "right" }))

-- Mac-style screen lock/suspend and browser url bar focus
o.bind("SUPER + CTRL + Q", "Suspend", "systemctl suspend")
--o.bind("SUPER + L", nil, "sendshortcut, CTRL, L, brave")

--# Mac-style copy pasting, cut, undo (common binding for SUPER C and SUPER V but differentiated handling for the terminal vs everything else)
--# suc and sup are super copy and super paster to accomodate seamless copy pasting between apps
o.bind("SUPER + A", nil, hl.dsp.send_shortcut({ mods = "CTRL", key = "A", window = "activewindow" }))
o.bind("SUPER + X", nil, hl.dsp.send_shortcut({ mods = "CTRL", key = "X", window = "activewindow" }))
o.bind("SUPER + Z", nil, hl.dsp.send_shortcut({ mods = "CTRL", key = "Z", window = "activewindow" }))
--o.bind("SUPER + F", nil, hl.dsp.send_shortcut({ mods = "CTRL", key = "F", window = "activewindow" }))
o.bind("SUPER + C", "Copy", "/usr/bin/suc")
o.bind("SUPER + V", "Paste", "/usr/bin/sup")

-- Swap active window with the one next to it with SUPER + SHIFT + arrow keys
--bindd = SUPER SHIFT, H, Swap window to the left, swapwindow, l
--bindd = SUPER SHIFT, L, Swap window to the right, swapwindow, r
--bindd = SUPER SHIFT, K, Swap window up, swapwindow, u
--bindd = SUPER SHIFT, J, Swap window down, swapwindow, d
