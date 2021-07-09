#!/bin/zsh
# AUTHOR: Evan Platzer
# DATE: 2021-07-09
# DESC: Install the cargo binaries recorded by record-cargo-binaries.sh
# 	If a binary is already installed, cargo will update if available or skip

filepath=${XDG_HOME_CONFIG:-$HOME/.config}/myconf/cargo/cargo-binaries.cfg

echo Installing cargo binaries listed at $filepath

for line in "${(@f)"$(<$filepath)"}"
{
  echo Installing $line
  cargo install $line
}