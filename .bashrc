#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -e "/etc/DIR_COLORS" ] && DIR_COLORS="/etc/DIR_COLORS"
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""
eval "$(dircolors -b $DIR_COLORS)"

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.prompt" ] && source "$HOME/.prompt"

# So as not to be disturbed by the Ctrl-S Ctrl-Q in terminal:
stty -ixon
