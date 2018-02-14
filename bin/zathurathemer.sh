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

#000000
addregex default-bg                  $(getcolor.sh bg)	# black
#DDDDDD
addregex default-fg                  $(getcolor.sh fg)	# grey light

#000000
addregex statusbar-bg                $(getcolor.sh 0)	# black
#FFFFFF
addregex statusbar-fg                $(getcolor.sh 15)	# grey light

#131313
addregex inputbar-bg                 $(getcolor.sh 0)	# black
#9FBC00
addregex inputbar-fg                 $(getcolor.sh 15)	# grey light

#FF1212
addregex notification-error-bg       $(getcolor.sh 0)	# black
#FFFFFF
addregex notification-error-fg       $(getcolor.sh 1)	# red

#F3F000
addregex notification-warning-bg     $(getcolor.sh 0)	# black
#000000
addregex notification-warning-fg     $(getcolor.sh 3)	# yellow

#00BC00
addregex highlight-active-color      $(getcolor.sh 15)	# grey light
#9FBC00
addregex highlight-color             $(getcolor.sh 0)	# black

#9FBC00
addregex completion-highlight-bg     $(getcolor.sh 0)	# black
#232323
addregex completion-highlight-fg     $(getcolor.sh 7)	# grey

#232323
addregex completion-bg               $(getcolor.sh 7)	# grey
#DDDDDD
addregex completion-fg               $(getcolor.sh 15)	# grey light

#FFFFFF
addregex notification-bg             $(getcolor.sh 0)	# black
#000000
addregex notification-fg             $(getcolor.sh 4)	# blue

#FFFFFF
addregex recolor-darkcolor           $(getcolor.sh 15)	# grey light
#000000
addregex recolor-lightcolor          $(getcolor.sh 0)	# black

sed -i -E "$sub" $zathurarc
