#!/bin/bash
# Get xrdb color

case "$1" in
	"fg") color="foreground";;
	"bg") color="background";;
	*) color="color${1:-0}";;
esac

echo "$(xrdb -query | grep "$color" | awk '{printf $2}' | cut -z -c 2-7 | tr -d '\000')"
