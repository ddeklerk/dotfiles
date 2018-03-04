#!/bin/sh
#
# ~/.xinitrc

# TODO: move wm-specific stuff to bspwmrc?

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

# Font stuff
xset +fp $HOME/.fonts
xset fp rehash

# Set caps to escape
[ -x "$(command -v xcape)" ] && xcape -e 'Caps_Lock=Escape' &

# Start compton
compton &

# Start redshift
redshift &

# Start dropbox
dropbox &> /dev/null &

unclutter &

[ -x "$HOME/.fehbg" ] && $HOME/.fehbg > /dev/null
[ -x "$HOME/bin/battery.sh" ] && $HOME/bin/battery.sh -d > /dev/null
[ -x "$HOME/bin/dunst.sh" ] && $HOME/bin/dunst.sh > /dev/null
[ -x "$HOME/bin/wm.sh" ] && $HOME/bin/wm.sh & > /dev/null

xsetroot -cursor_name left_ptr
sxhkd -m 1 &
exec bspwm
