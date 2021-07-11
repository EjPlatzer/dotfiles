#!/bin/zsh
# AUTHOR: Evan Platzer
# DATE:   2021-07-09
# DESC:   Install the nix packages recorded nix-packages.cfg

filepath=${XDG_HOME_CONFIG:-$HOME/.config}/myconf/nix/nix-packages.cfg

echo Installing nix binaries listed at $filepath

for line in "${(@f)"$(<$filepath)"}"
{
    echo Checking status of package $line
    nix-env -q "^$line$" 2> /dev/null
    if [ $? = 0 ]; then
        echo Installing $line
        nix-env -i $line
    else
        echo $line is already installed
    fi
}
