#!/bin/bash
font="\"scientifica:pixelsize=11\""

command=""

case $(basename $0) in
	dmenu_run*)
		command="dmenu_run"
		;;
	dmenu*)
		command="dmenu"
		;;
esac

if [ -x "$(command -v getcolor.sh)" ]; then
	options="-nb \\#$(getcolor.sh bg) -nf \\#$(getcolor.sh fg) -sb \\#$(getcolor.sh 4) -sf \\#$(getcolor.sh 0)"
fi

# Escape $@
[ ${#} -ne 0 ] && printf -v args "%q " "${@}"

eval "${command} ${options}" "$args"
