#!/bin/sh
# AUTHOR: Evan Platzer
# DATE: 2021-07-09
# DESC: Save the list of installed cargo binaries to a config file

filepath=${XDG_HOME_CONFIG:-$HOME/.config}/myconf/cargo/cargo-binaries.cfg

if [ -f $filepath ]; then
	echo backing up previous cargo binaries
	mv $filepath $filepath.bak
fi

echo "Saving list of cargo binaries installed to $filepath"

cargo install --list | sd '([\w-]) v.+\n    [\w-]+' '$1' >> $filepath
