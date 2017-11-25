#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

# Set caps to escape
[ -x "$(command -v xcape)" ] && xcape -e 'Caps_Lock=Escape' &

# Start dunst
if ! [ -x "$(command -v getcolor.sh)" ]; then
	dunst &
else
	dunst \
		-lb "#$(getcolor.sh bg)" \
		-lf "#$(getcolor.sh fg)" \
		-nb "#$(getcolor.sh bg)" \
		-nf "#$(getcolor.sh 4)" \
		-cb "#$(getcolor.sh bg)" \
		-cf "#$(getcolor.sh 1)" \
		-frame_width 0 \
		-sep_height 0 \
		&
fi
# Start compton
compton &

[ -x "$HOME/bin/battery.sh" ] && $HOME/bin/battery.sh -d

xsetroot -cursor_name left_ptr
sxhkd -m 1 &
exec bspwm
