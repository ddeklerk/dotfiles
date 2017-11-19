#!/bin/bash

# 3 happens to be the "desktop" chassis type. It'll probably be better if I did
# a more thorough check, but for now this is fine.
if [ "$(cat /sys/class/dmi/id/chassis_type)" -eq 3 ]; then
	# Do stuff for desktop
	xkblayout="us"
	ckblayout="us"
else
	# Do stuff for laptop
	xkblayout="dvorak,us"
	ckblayout="dvorak"
fi

# Set my X keymap
localectl set-x11-keymap ${xkblayout} '' '' 'grp:ctrls_toggle,caps:ctrl_modifier,compose:ralt'
# Also set the console keymap
echo "KEYMAP=${ckblayout}" | sudo tee -a /etc/vconsole.conf

# Install the base packages to get bspwm running
sudo pacman --quiet --noconfirm --needed -Syu bspwm sxhkd rxvt-unicode-patched dmenu
echo "sxhkd -m 1 &" >> .xinitrc
echo "exec bspwm" >> .xinitrc

# Create the config dirs for bspwm and sxhkd and copy the defaults into it
mkdir -p ~/.config/bspwm && cp /usr/share/doc/bspwm/examples/bspwmrc "$_"
mkdir -p ~/.config/sxhkd && cp /usr/share/doc/bspwm/examples/sxhkdrc "$_"

# Remove the sxhkd call from bspwmrc
sed -i '/sxhkd &/d' ~/.config/bspwm/bspwmrc
