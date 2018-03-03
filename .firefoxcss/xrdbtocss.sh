#!/bin/bash

newline=$'\n'

css_colors+="	--foreground: #$(getcolor.sh fg);${newline}"
css_colors+="	--background: #$(getcolor.sh bg);${newline}"

for i in {0..15}
do
	css_colors+="	--color${i}: #$(getcolor.sh ${i});${newline}"
done

printf "%s\n" ":root {${newline}${css_colors}}"
