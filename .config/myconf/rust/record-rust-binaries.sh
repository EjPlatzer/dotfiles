#!/bin/sh
# AUTHOR: Evan Platzer
# DATE: 2021-07-09
# DESC: Save the list of installed Rust binaries to a config file

filepath=${XDG_HOME_CONFIG:-$HOME/.config}/myconf/rust/rust-binaries.cfg

if [ -f $filepath ]; then
	echo backing up previous Rust binaries
	mv $filepath $filepath.bak
fi

echo Saving list of Rust binaries installed to $filepath

cargo install --list | sd '([\w-]) v.+\n    [\w-]+' '$1' >> $filepath
