#!/bin/sh
# AUTHOR:   Evan Platzer
# DATE:     2021-07-10
# DESC:     Setup my environment automatically, including:
#               - Install zsh, if needed
#               - Install starship prompt
#               - Install Rust binaries

echo Setting up my CLI environment

echo Checking for zsh
which zsh

if [ $? = 0 ]; then
        echo
else
        echo Installing zsh
        sudo apt install zsh
        echo Installed zsh
        echo Setting zsh as login shell
        chsh --shell /bin/zsh $USER
        echo Set zsh as login shell
        echo
fi

echo Checking for starship prompt
which starship

if [ $? = 0 ]; then
        echo
else
        echo Installing starship prompt
        sh -c "$(curl -fsSL https://starship.rs/install.sh)"
        echo Installed starship prompt
        echo
fi

echo Configuring Rust and Cargo
/bin/zsh ${XDG_HOME_CONFIG:-$HOME/.config}/myconf/rust/configure-rust.sh
echo Configured Rust and Cargo
echo Done with setup