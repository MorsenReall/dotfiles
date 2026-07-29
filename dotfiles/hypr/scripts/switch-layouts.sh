#!/usr/bin/env bash
layouts=("dwindle" "scrolling" "master" "monocle")

selection=$(printf "%s\n" "${layouts[@]}" | rofi -dmenu -p "Layout" -matching fuzzy -i -config ~/.config/rofi/config-keybinds.rasi)
[[ -z "$selection" ]] && exit 0

id=$(hyprctl activeworkspace -j | tr ',' '\n' | sed -n 's/.*"id": *\([0-9]*\).*/\1/p')
hyprctl eval "hl.workspace_rule({ workspace = tostring($id), layout = '$selection' })" && notify-send -u low "Layout" "Switched to $selection"
