#!/bin/bash

usage() {
	cat <<EOF
usage: $(basename $0) [-hlsb]
	-h : print this help
	-l : print battery percentage (default)
	-s : print battery state
	-b : beep under critical level (see BAT_BELL)

environment:
	CRITICAL : the critical state level
	BAT_BELL : the command to run with -b flag under CRITICAL level
EOF
}

# If battery level is under critical level, $BAT_BELL will be run
bell() {
	# Don't do anything if we're over the critical level, or the battery is
	# charging
	test ${BATC} -gt ${CRITICAL} && return 0
	test ${BATS} != "Discharging" && return 0

	$BAT_BELL
}

# Output the current battery level
level() {
	echo "${BATC}%"
}

# Print the current battery state
state() {
	echo "${BATS}"
}

# Get battery name
BATN=$(ls /sys/class/power_supply/ | grep BAT)

# Exit if no battery available
test -z "$BATN" && exit 1

# Get battery level and status (charging or not)
BATC=$(cat /sys/class/power_supply/${BATN}/capacity)
BATS=$(cat /sys/class/power_supply/${BATN}/status)

CRITICAL=${CRITICAL:-7}
BAT_BELL=${BAT_BELL:-notify-send -urgency critical "Battery low"}

case $1 in
	-h) usage ;;
	-s) state ;;
	-b) bell ;;
	*) level ;;
esac
