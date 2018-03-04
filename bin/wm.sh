#!/bin/bash
focused="\ue000" # Filled square
occupied="\ue001" # Thick border square
free="\ue130" # Regular square

WM_FIFO=/tmp/wm-fifo

# Create teh fifo, if it doesn't already exist
[ -p "$WM_FIFO" ] || mkfifo "$WM_FIFO"

bspc subscribe desktop > "$WM_FIFO" &

while read -r line
do
	case $line in
		desktop*)
			wm=""
			num_mon=$(bspc query -M | wc -l)

			wmstatus=$(bspc wm --get-status)
			IFS=":"
			set -- ${wmstatus#?}
			while [ $# -gt 0 ]
			do
				item=$1
				name=${item#?}
				case $item in
					[mM]*)
						# Monitors
						case $item in
							m*)
								# Monitor
								# FG=${col7}
								;;
							M*)
								# Focused monitor
								# FG=${col15}
								;;
						esac
						[ $num_mon -lt 2 ] && shift && continue
						wm="${wm} ${name} "
						;;
					[fFoOuU]*)
						# Desktops
						case $item in
							[FOU]*)
								icon=${focused}
								;;
							[Ff]*)
								icon=${free}
								;;
							[Oo]*)
								icon=${occupied}
								;;
							[Uu]*)
								# urgent desktop
								;;
						esac
						wm="${wm}${icon}"
						;;
					[LTG]*)
						# Layout, state, and flags
						# TODO: display these
						;;
				esac
				shift
			done
			notify-send -t 500 "Workspace" "$(echo -e ${wm})" -u low
			;;
	esac
done < "$WM_FIFO"
