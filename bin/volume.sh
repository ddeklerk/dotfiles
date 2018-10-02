#!/bin/bash

# Take the first argument
command=$1
# Shift the arguments so we can process the rest
shift

# Use the Master channel
m=Master
# Interval is either 1 or whatever is supplied as the second argument
i=${1:-1}

level() {
	echo ${1:-$(amixer get ${m})} | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p' | uniq
}

state() {
	echo ${1:-$(amixer get ${m})} | sed -n 's/^.*\[\(o[nf]\+\)]$/\1/p' | uniq
}

case $command in
	-|down) status=$(amixer set $m ${i}%-);;
	+|up) status=$(amixer set $m ${i}%+);;
	!|toggle) status=$(amixer set $m toggle);;
	*) status=$(amixer set $m $command);;
esac

level=$(level "$status")
state=$(state "$status" | awk '{print toupper($0)}')

notify-send "Volume" "${state} " -h int:value:${level} -t 500 -u low
