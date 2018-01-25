zathurarc=~/.config/zathura/zathurarc
sub=""

mkregex() {
	attr=$1
	col=$2
	echo 's/('"$attr"'\s+)("|\\)#([0-9a-f]{6})"?/\1\\#'"$col"'/i;'
}

addregex() {
	sub+=$(mkregex $1 $2)
}

addregex default-bg                  $(getcolor.sh 0)	# black
addregex default-fg                  $(getcolor.sh 15)	# grey light

addregex statusbar-bg                $(getcolor.sh 0)	# black
addregex statusbar-fg                $(getcolor.sh 15)	# grey light

addregex inputbar-bg                 $(getcolor.sh 0)	# black
addregex inputbar-fg                 $(getcolor.sh 15)	# grey light

addregex notification-error-bg       $(getcolor.sh 0)	# black
addregex notification-error-fg       $(getcolor.sh 1)	# red

addregex notification-warning-bg     $(getcolor.sh 0)	# black
addregex notification-warning-fg     $(getcolor.sh 3)	# yellow

addregex highlight-active-color      $(getcolor.sh 15)	# grey light
addregex highlight-color             $(getcolor.sh 0)	# black

addregex completion-highlight-bg     $(getcolor.sh 0)	# black
addregex completion-highlight-fg     $(getcolor.sh 7)	# grey

addregex completion-bg               $(getcolor.sh 7)	# grey
addregex completion-fg               $(getcolor.sh 15)	# grey light

addregex notification-bg             $(getcolor.sh 0)	# black
addregex notification-fg             $(getcolor.sh 4)	# blue

addregex recolor-darkcolor           $(getcolor.sh 15)	# grey light
addregex recolor-lightcolor          $(getcolor.sh 0)	# black

sed -i -E "$sub" $zathurarc
