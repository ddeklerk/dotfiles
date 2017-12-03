#!/bin/bash
#
# Edit /etc/systemd/logind.conf and uncomment HandlePowerKey and set it to ignore

res=$(echo "logout|suspend|hibernate|reboot|shutdown" | $HOME/bin/rofi.sh -sep "|" -dmenu -i -p '' -width 8 -lines 5)

logout() {
	# Close all windows
	for window_id in $(bspc query -W); do
		bspc window $window_id -c
	done
	bspc quit
}

case $res in
	halt|poweroff|shutdown)
		systemctl poweroff
		;;
	hibernate)
		systemctl hibernate
		;;
	logout)
		logout
		;;
	restart|reboot)
		systemctl reboot
		;;
	suspend)
		systemctl suspend
		;;
	*)
esac
