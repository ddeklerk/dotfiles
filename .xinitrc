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

# Start dunst
if ! [ -x "$(command -v getcolor.sh)" ]; then
	dunst &
else
	hsetroot -solid \#$(getcolor.sh 7)

	dunst \
		-lb "#$(getcolor.sh bg)" \
		-lf "#$(getcolor.sh fg)" \
		-lfr "#$(getcolor.sh fg)" \
		-nb "#$(getcolor.sh bg)" \
		-nf "#$(getcolor.sh fg)" \
		-nfr "#$(getcolor.sh 4)" \
		-cb "#$(getcolor.sh bg)" \
		-cf "#$(getcolor.sh fg)" \
		-cfr "#$(getcolor.sh 1)" \
		&
fi
# Start compton
compton &

# Start redshift
redshift &

# Start dropbox
dropbox-cli start &

unclutter &

[ -x "$HOME/bin/battery.sh" ] && $HOME/bin/battery.sh -d > /dev/null
[ -x "$HOME/bin/wm.sh" ] && $HOME/bin/wm.sh & > /dev/null

xsetroot -cursor_name left_ptr
sxhkd -m 1 &
exec bspwm
