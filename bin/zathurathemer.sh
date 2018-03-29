#!/bin/bash

# A script for theming my zathura config to use the colours defined in my
# Xresources.
#
# Depends on getcolor.sh

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

addregex completion-bg            $( getcolor.sh 18 ) #232323
addregex completion-fg            $( getcolor.sh fg ) #DDDDDD
addregex completion-group-bg      $( getcolor.sh 0  ) #000000
addregex completion-group-fg      $( getcolor.sh 7  ) #DEDEDE
addregex completion-highlight-bg  $( getcolor.sh 2  ) #9FBC00
addregex completion-highlight-fg  $( getcolor.sh 18 ) #232323
addregex default-bg               $( getcolor.sh 0  ) #000000
addregex default-fg               $( getcolor.sh fg ) #DDDDDD
addregex highlight-active-color   $( getcolor.sh 2  ) #00BC00
addregex highlight-color          $( getcolor.sh 2  ) #9FBC00
addregex index-active-bg          $( getcolor.sh 2  ) #9FBC00
addregex index-active-fg          $( getcolor.sh 18 ) #232323
addregex index-bg                 $( getcolor.sh 18 ) #232323
addregex index-fg                 $( getcolor.sh fg ) #DDDDDD
addregex inputbar-bg              $( getcolor.sh 0  ) #131313
addregex inputbar-fg              $( getcolor.sh 2  ) #9FBC00
addregex notification-bg          $( getcolor.sh 15 ) #FFFFFF
addregex notification-error-bg    $( getcolor.sh 15 ) #FFFFFF
addregex notification-error-fg    $( getcolor.sh 1  ) #FF1212
addregex notification-fg          $( getcolor.sh 0  ) #000000
addregex notification-warning-bg  $( getcolor.sh 15 ) #FFFFFF
addregex notification-warning-fg  $( getcolor.sh 3  ) #FFF712
addregex recolor-darkcolor        $( getcolor.sh 15 ) #FFFFFF
addregex recolor-lightcolor       $( getcolor.sh 0  ) #000000
addregex render-loading-bg        $( getcolor.sh 15 ) #FFFFFF
addregex render-loading-fg        $( getcolor.sh 0  ) #000000
addregex statusbar-bg             $( getcolor.sh 0  ) #000000
addregex statusbar-fg             $( getcolor.sh 15 ) #FFFFFF
addregex tabbar-bg                $( getcolor.sh 0  ) #000000
addregex tabbar-fg                $( getcolor.sh 15 ) #FFFFFF
addregex tabbar-focus-bg          $( getcolor.sh 0  ) #000000
addregex tabbar-focus-fg          $( getcolor.sh 2  ) #9FBC00

sed -i -E "$sub" $zathurarc
