#!/bin/bash

hostname="$(hostname)"
os="Arch Linux"
kernel="$(uname -sr)"
uptime="$(uptime -p | sed 's/up //')"
packages="$(pacman -Q | wc -l)"
shell="$(basename ${SHELL})"
if [ -z "${WM}" ]; then
	WM="$(tail -n 1 "${HOME}/.xinitrc" | cut -d " " -f 2)"
fi

cat <<EOF

${USER}@${hostname}
OS: ${os}
KERNEL: ${kernel}
UPTIME: ${uptime}
PACKAGES: ${packages}
SHELL: ${shell}
WM: ${WM}

EOF
