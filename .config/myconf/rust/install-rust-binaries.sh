#!/bin/zsh
# AUTHOR: Evan Platzer
# DATE: 2021-07-09
# DESC: Install the Rust binaries recorded by record-rust-binaries.sh
# 	If a binary is already installed, cargo will update if available or skip

filepath=${XDG_HOME_CONFIG:-$HOME/.config}/myconf/rust/rust-binaries.cfg

echo Installing Rust binaries listed at $filepath

for line in "${(@f)"$(<$filepath)"}"
{
  echo Installing $line
  cargo install $line
}