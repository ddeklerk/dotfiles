#!/bin/bash

res=$(echo "logout|reboot|shutdown" | rofi -sep "|" -dmenu -i -p '' -width 8 -lines 3)

out() {
	for window_id in $(bspc query -W); do
		bspc window $window_id -c
	done
	bspc quit
}

case $res in
	"logout") out && exit;;
	"reboot") systemctl reboot && exit;;
	"shutdown") systemctl poweroff && exit;;
	*)exit;;
esac
