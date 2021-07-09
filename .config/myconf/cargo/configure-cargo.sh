#!/bin/zsh
# AUTHOR: Evan Platzer
# DATE: 2021-07-09
# DESC: Configure rust and install cargo binaries

echo checking rustup installation
echo ----------------------------

rustup -V
echo

if [ "$?" = "0" ] ; then
	echo rustup found
else
	echo rustup not found
	echo installing rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo
echo installing cargo binaries
echo ----------------------------
/bin/zsh ${XDG_HOME_CONFIG:-$HOME/.config}/myconf/cargo/install-cargo-binaries.sh

