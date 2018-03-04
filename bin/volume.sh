#!/bin/bash

on=\\ue04e
off=\\ue04f

# Take the first argument
command=$1
# Shift the arguments so we can process the rest
shift

# Use the Master channel
m=Master
# Interval is either 1 or whatever is supplied as the second argument
i=${1:-1}

level() {
	amixer get $m | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p' | uniq
}

state() {
	amixer get $m | sed -n 's/^.*\[\(o[nf]\+\)]$/\1/p' | uniq
}

case $command in
	-|down) amixer set $m ${i}%- >/dev/null;;
	+|up) amixer set $m ${i}%+ >/dev/null;;
	!|toggle) amixer set $m toggle >/dev/null;;
	*) amixer set $m $1 >/dev/null;;
esac

if [ `state` = "on" ]; then
	icon=$on
else
	icon=$off
fi

notify-send "Volume" "$(echo -e ${icon})" -h int:value:`level` -t 500 -u low
