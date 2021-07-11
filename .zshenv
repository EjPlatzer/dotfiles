# Export XDG directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# rustup shell setup
source "$HOME/.cargo/env"
if [ -e /Users/evan.platzer/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/evan.platzer/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
if [ -e /home/evan/.nix-profile/etc/profile.d/nix.sh ]; then . /home/evan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
