#!/bin/bash
#
# Edit /etc/systemd/logind.conf and uncomment HandlePowerKey and set it to ignore

res=$(echo -e "logout\nreboot\nshutdown" | $HOME/bin/dmenu.sh -b -i -p "Power:")

logout() {
	# Close all windows
	for node_id in $(bspc query -N); do
		bspc node $node_id -c
	done
	bspc quit
}

case $res in
	halt|poweroff|shutdown)
		exec systemctl poweroff
		;;
	hibernate)
		exec systemctl hibernate
		;;
	logout)
		logout
		;;
	restart|reboot)
		exec systemctl reboot
		;;
	suspend)
		exec systemctl suspend
		;;
	*)
esac
