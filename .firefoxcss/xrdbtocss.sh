#!/bin/bash

newline=$'\n'

css_colors+="	--xrdb-fg: #$(getcolor.sh fg);${newline}"
css_colors+="	--xrdb-bg: #$(getcolor.sh bg);${newline}"

for i in {0..15}
do
	css_colors+="	--xrdb-${i}: #$(getcolor.sh ${i});${newline}"
done

printf "%s\n" ":root {${newline}${css_colors}}"
