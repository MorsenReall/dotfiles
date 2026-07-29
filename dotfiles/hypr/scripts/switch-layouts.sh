#!/usr/bin/env bash
declare -A menu
menu=(
  ["Dwindle"]="dwindle"
  ["Scrolling"]="scrolling"
  ["Master"]="master"
  ["Monocle"]="monocle"
  ["Fair Grid"]="lua:fair"
  ["Deck Stack"]="lua:deck"
)

selection=$(printf "%s\n" "${!menu[@]}" | rofi -dmenu -p "Layout" -matching fuzzy -i -config ~/.config/rofi/config-keybinds.rasi)
[[ -z "$selection" ]] && exit 0

id=$(hyprctl activeworkspace -j | tr ',' '\n' | sed -n 's/.*"id": *\([0-9]*\).*/\1/p')
hyprctl eval "hl.workspace_rule({ workspace = tostring($id), layout = '${menu[$selection]}' })" && notify-send -u low "Layout" "Switched to $selection"
