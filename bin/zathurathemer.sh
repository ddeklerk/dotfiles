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
addregex default-bg                  $(getcolor.sh bg)
#DDDDDD
addregex default-fg                  $(getcolor.sh fg)

#000000
addregex statusbar-bg                $(getcolor.sh bg)
#FFFFFF
addregex statusbar-fg                $(getcolor.sh 15)

#131313
addregex inputbar-bg                 $(getcolor.sh 0) 
#9FBC00
addregex inputbar-fg                 $(getcolor.sh 15)

#FF1212
addregex notification-error-bg       $(getcolor.sh 0) 
#FFFFFF
addregex notification-error-fg       $(getcolor.sh 1) 

#F3F000
addregex notification-warning-bg     $(getcolor.sh 0) 
#000000
addregex notification-warning-fg     $(getcolor.sh bg)

#00BC00
addregex highlight-active-color      $(getcolor.sh 15)
#9FBC00
addregex highlight-color             $(getcolor.sh 0) 

#9FBC00
addregex completion-highlight-bg     $(getcolor.sh 0) 
#232323
addregex completion-highlight-fg     $(getcolor.sh 7) 

#232323
addregex completion-bg               $(getcolor.sh 8) 
#DDDDDD
addregex completion-fg               $(getcolor.sh fg)

#FFFFFF
addregex notification-bg             $(getcolor.sh 0) 
#000000
addregex notification-fg             $(getcolor.sh bg)

#FFFFFF
addregex recolor-darkcolor           $(getcolor.sh fg)
#000000
addregex recolor-lightcolor          $(getcolor.sh bg)

sed -i -E "$sub" $zathurarc
