#!/bin/bash

# Read first argument if it's not a flag or empty, otherwise read input
if [[ "$@" = \-* ]] || [[ $# -eq 0 ]]; then
	read -t .1 text
else
	text=$1
	shift
fi

# Exit if there is no text set
if [[ -z $text ]]; then
	echo "$basename: No text provided" >&2
	exit 1
fi

background=\#$(getcolor.sh bg)
basename=$(basename $0)
duration=3
font=$PANEL_FONT
foreground=\#$(getcolor.sh fg)
height=28
icon=$PANEL_ICON_FONT
width=140
xpos=20
ypos=20

# Parse any optional arguments
while getopts "a:c:d:h:n:w:x:y:" opt; do
	case $opt in
		a) alignment=$OPTARG;;
		c) center=$OPTARG;;
		d) duration=$OPTARG;;
		h) height=$OPTARG;;
		n) name="$basename--$OPTARG";;
		w) width=$OPTARG;;
		x) xpos=$OPTARG;;
		y) ypos=$OPTARG;;
	esac
done

if [ -n "$center" ]; then
	resolution=$(xrandr --current | grep \* | awk '{print $1}')
	monitor_width=$(echo $resolution | cut -d 'x' -f 1)
	monitor_height=$(echo $resolution | cut -d 'x' -f 2)
	case $center in
		h*)
			xpos=$(( $monitor_width / 2 - $width / 2 ))
			;;
		v*)
			ypos=$(( $monitor_height / 2 - $height / 2 ))
			;;
		b*)
			xpos=$(( $monitor_width / 2 - $width / 2 ))
			ypos=$(( $monitor_height / 2 - $height / 2 ))
			;;
	esac
fi

# Shift out all getopts arguments
shift $((OPTIND -1))

# If a name is provided, kill any previous popups with the same name
if [[ "$name" != "" ]]; then
	pgrep -fl $name | while read -r pid; do
		# Make sure the PID is not of this current script, and it's an instance of lemonbar
		if [[ $pid != $$* ]] && [[ $pid = *lemonbar* ]]; then
			kill $(echo $pid | awk '{print $1}')
		fi
	done
fi

# Echo the text for $duration seconds and pipe into lemonbar to display the popup
(echo "%{${alignment}}$text"; sleep $duration) | lemonbar \
	-B "$background" \
	-F "$foreground" \
	-d \
	-b \
	-f "$font" \
	-f "$icon" \
	-g "${width}x${height}+${xpos}+${ypos}" \
	-n "$name" \
	"$@" &
