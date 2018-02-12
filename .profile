#!/bin/bash
#
# ~/.profile
#
# Add the following snippet to /etc/profile
#
#	# If used ID is greater than or equal to 1000 & if ~/.profile exists and is a file, then
#	# execute the file
#	if [[ $UID -ge 1000 && -f $HOME/.profile ]]; then
#		. $HOME/.profile
#	fi


# If user ID is greater than or equal to 1000 & if ~/bin exists and is a directory & if ~/bin is not already in your $PATH
# then export ~/bin to your $PATH.
if [[ $UID -ge 1000 && -d $HOME/bin && -z $(echo $PATH | grep -o $HOME=bin) ]]; then
	export PATH="${PATH}:$HOME/bin"
fi

export _JAVA_AWT_WM_NONREPARENTING=1

export EDITOR="vim"
export VISUAL="vim"

export PANEL_FIFO=/tmp/panel-fifo
export PANEL_FONT="-*-gohufont-medium-r-normal-*-11-*-*-*-*-*-*-*"
export PANEL_HEIGHT=13
export PANEL_ICON_FONT="-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"
export PANEL_WM_NAME=bspwm_panel
