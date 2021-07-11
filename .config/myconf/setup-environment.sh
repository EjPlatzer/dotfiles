#!/bin/zsh
# AUTHOR:   Evan Platzer
# DATE:     2021-07-10
# DESC:     Setup my environment automatically, including:
#               - Install zsh, if needed
#               - Install starship prompt
#               - Install Rust binaries

# Set default options
nix=true
rust=false
nvm=false

# Handle optional flags
while :
do
    case "$1" in
        -r | --rust)
            rust=true
            shift
            ;;
        -n | --nvm)
            echo TODO: Add support for installing and configuring nvm/Node/npm
            nvm=true
            shift 
            ;;
        -h | --help)
            echo TODO: Add help
            exit 0
            ;;
        --) # End of all options
            shift
            break;;
        -*)
            echo "Error: Unknown option: $1" >&2
            exit 1
            ;;
        *)  # No more options
            break
            ;;
    esac
done

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
    zsh -c "$(curl -fsSL https://starship.rs/install.sh)"
    echo Installed starship prompt
    echo
fi

echo Checking for nix
which nix

if [ $? = 0 ]; then
    echo
else
    echo Installing nix
    case $OSTYPE in
        linux-gnu*)
            zsh -c "$(curl -fsSL https://nixos.org/nix/install)"
            ;;
        darwin*)
            zsh -c "$(curl -fsSL https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume"
            ;;
        *)
            echo Unrecognized OS - skipping nix installation
            nix=false
            ;;
    esac
fi

echo
if [ $nix = true ]; then
    echo Installing nix packages
    /bin/zsh ${XDG_HOME_CONFIG:-$HOME/.config}/myconf/nix/install-nix-packages.sh
else
    echo Skipping nix packages
fi


if [ $rust = true ]; then
    echo Configuring Rust
    /bin/zsh ${XDG_HOME_CONFIG:-$HOME/.config}/myconf/rust/configure-rust.sh
    echo Configured Rust
    echo Done with setup
else
    echo Skipping Rust configuration
fi

echo

if [ $nvm = true ]; then
    echo TODO: Support installing and configuring nvm, Node.js, and npm
    echo Consider accepting a version value with the nvm flag to specify which Node.js version to install
fi
