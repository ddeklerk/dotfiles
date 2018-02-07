#!/bin/bash

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

dot="·"
dash="-"
mult="×"
plus="+"

# Create the fifo, if it doesn't already exist
[ -p "$PANEL_FIFO" ] || mkfifo "$PANEL_FIFO";


# ========================================
# Output to th efifo
# ========================================

# BSPWM workspaces
bspc subscribe report > "$PANEL_FIFO" &

# Time
while true
do
	date "+C%H:%M"
	sleep 1
done > "$PANEL_FIFO" &

# Battery status

# Get battery name
BATN=$(ls /sys/class/power_supply/ | grep BAT)
if [ -n "$BATN" ] && [ -x "$(command -v getcolor.sh)" ]
then
	while true
	do
		echo "B$(battery.sh)"
		sleep 30
	done > "$PANEL_FIFO" &
fi

# ========================================
# Parse the output of the fifo
# ========================================

num_mon=$(bspc query -M | wc -l)

BG="#$(getcolor.sh bg)"
FG="#$(getcolor.sh fg)"

monwidth=$(xrandr | grep \* | awk '{print $1}' | cut -d 'x' -f 1)
xoff=6
yoff=0
width=$((monwidth - 2 * xoff))
geometry="${width}x${PANEL_HEIGHT}+${xoff}+${yoff}"

while read -r line
do
	case $line in
		B*)
			bat="%{F${FG}}%{B${BG}} ${line#?} %{F-}%{B-}"
			;;
		C*)
			clock="%{F${FG}}%{B${BG}} ${line#?} %{F-}%{B-}"
			;;
		W*)
			# focused=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5)
			# name=$(xprop -id ${focused} WM_NAME 2>/dev/null | sed -nr 's/.*= "(.*)"$/\1/p')
			# class=$(xprop -id ${focused} WM_CLASS 2>/dev/null | awk -F '"' '{print $4}')
			# title="%{F${FG}}%{B${BG}} ${class} %{F#$(getcolor.sh 8)}${name} %{F-}%{B-}"

			# bspwm's state
			wm=
			IFS=':'
			set -- ${line#?}
			while [ $# -gt 0 ]
			do
				item=$1
				case $item in
					[mM]*)
						# Monitors
						case $item in
							m*)
								# Monitor
								FG="#$(getcolor.sh 7)"
								;;
							M*)
								# Focused monitor
								FG="#$(getcolor.sh 15)"
								;;
						esac
						[ $num_mon -lt 2 ] && shift && continue
						wm="${wm}%{A:bspc monitor -f ${name}:} ${name} %{A}"
						;;
					[fFoOuU]*)
						# Desktops
						case $item in
							[FOU]*)
								icon="+"
								;;
							f*)
								# free desktop
								icon=${dot}
								;;
							F*)
								# free active/focused desktop
								icon=${dot}
								;;
							o*)
								# occupied desktop
								icon=${dash}
								;;
							O*)
								# occupied active/focused desktop
								icon=${dash}
								;;
							u*)
								# urgent desktop
								FG="#$(getcolor.sh 4)"
								;;
							U*)
								# urgent active/focused desktop
								FG="#$(getcolor.sh 4)"
								;;
						esac
						wm="${wm}%{F${FG}}%{B${BG}} ${icon} %{F-}%{B-}"
						;;
					[LTG]*)
						# Layout, state, and flags
						;;
				esac
				shift
			done
			;;
	esac
	printf "%s\n" "%{c}${wm}%{r}${bat} ${clock}"
done < "$PANEL_FIFO" | lemonbar -n "$PANEL_WM_NAME" -g "$geometry" -f "$PANEL_FONT"
