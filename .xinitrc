#!/bin/sh

# Set caps to escape
[ -x "$(command -v xcape)" ] && xcape -e 'Caps_Lock=Escape' &

[ -x "$HOME/bin/battery" ] && "$HOME/bin/battery" -d > /dev/null
[ -x "$HOME/bin/dunst" ] && "$HOME/bin/dunst" > /dev/null

xsetroot -cursor_name left_ptr

sxhkd -m 1 &
exec bspwm
