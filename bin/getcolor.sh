#!/bin/bash
# Get xrdb color

case "$1" in
	"fg") color="foreground";;
	"bg") color="background";;
	*) color="color${1:-0}";;
esac

xrdb -query | awk -v var="$color" -F '#' '$0 ~ var {print $2; exit}'
