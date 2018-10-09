#!/bin/sh
#
# ~/.xinitrc

# TODO: move wm-specific stuff to bspwmrc?

# Set caps to escape
[ -x "$(command -v xcape)" ] && xcape -e 'Caps_Lock=Escape' &

# Start redshift
redshift &

# Start dropbox
dropbox &> /dev/null &

[ -x "$HOME/bin/battery.sh" ] && $HOME/bin/battery.sh -d > /dev/null
[ -x "$HOME/bin/dunst.sh" ] && $HOME/bin/dunst.sh > /dev/null

xsetroot -cursor_name left_ptr
sxhkd -m 1 &
exec bspwm
