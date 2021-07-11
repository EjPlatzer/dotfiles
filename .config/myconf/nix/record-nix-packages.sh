#!/bin/zsh
# AUTHOR: Evan Platzer
# DATE: 2021-07-09
# DESC: Save the list of installed nix packages to a config file

filepath=${XDG_HOME_CONFIG:-$HOME/.config}/myconf/nix/nix-packages.cfg

if [ -f $filepath ]; then
	echo backing up previous nix packages
	mv $filepath $filepath.bak
fi

echo Saving list of nix packages installed to $filepath
# nix-env -qa --installed | sd '([\w-])-([\d0.]+){1,3}$' '$1' >> $filepath
nix-env -q >> $filepath