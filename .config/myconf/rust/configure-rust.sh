#!/bin/zsh
# AUTHOR: Evan Platzer
# DATE: 2021-07-09
# DESC: Configure Rust and install Rust binaries

echo Checking rustup installation
which rustup

if [ "$?" = "0" ] ; then
	echo
else
	echo Installing rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	source $HOME/.cargo/env
	echo
fi

echo Installing Rust binaries
/bin/zsh ${XDG_HOME_CONFIG:-$HOME/.config}/myconf/rust/install-rust-binaries.sh

