#!/bin/bash

icon=\\ue1c3

# Take the first argument
command=$1
# Shift the arguments so we can process the rest
shift

# Use the Master channel
m=Master
# Interval is either 1 or whatever is supplied as the second argument
i=${1:-5}

level() {
	xbacklight | awk '{print int(($1 + 2.5) / 5) * 5}'
}

case $command in
	-|down) xbacklight -steps 1 -time 0 -dec ${i} >/dev/null;;
	+|up) xbacklight -steps 1 -time 0 -inc ${i} >/dev/null;;
	*) xbacklight -steps 1 -time 0 -set $1 >/dev/null;;
esac

notify-send "Brightness" "$(echo -e ${icon})" -h int:value:`level` -t 500 -u low
