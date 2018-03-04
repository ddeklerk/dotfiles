#!/bin/sh
resolution=$(xrandr --current | grep \* | awk '{print $1}')
monitor_width=$(echo $resolution | cut -d 'x' -f 1)
width=300
height=5

x=$(( $monitor_width / 2 - $width / 2 ))
y=18
geom="${width}x${height}+${x}+${y}"

if ! [ -x "$(command -v getcolor.sh)" ]; then
	dunst &
else
	dunst \
		-lb "#$(getcolor.sh bg)" \
		-lf "#$(getcolor.sh fg)" \
		-lfr "#$(getcolor.sh fg)" \
		\
		-nb "#$(getcolor.sh bg)" \
		-nf "#$(getcolor.sh fg)" \
		-nfr "#$(getcolor.sh 4)" \
		\
		-cb "#$(getcolor.sh bg)" \
		-cf "#$(getcolor.sh fg)" \
		-cfr "#$(getcolor.sh 1)" \
		\
		-geometry "${geom}" \
		&
fi
