if ! [ -x "$(command -v getcolor.sh)" ]; then
	rofi $@
else
	rofi \
		-color-normal "#$(getcolor.sh bg), #$(getcolor.sh fg), #$(getcolor.sh bg), #$(getcolor.sh fg), #$(getcolor.sh bg)" \
		-color-urgent "#$(getcolor.sh bg), #$(getcolor.sh 1), #$(getcolor.sh bg), #$(getcolor.sh 1), #$(getcolor.sh bg)" \
		-color-active "#$(getcolor.sh bg), #$(getcolor.sh 4), #$(getcolor.sh bg), #$(getcolor.sh 4), #$(getcolor.sh bg)" \
		-color-window "#$(getcolor.sh bg), #$(getcolor.sh fg)" \
		"$@"
fi
