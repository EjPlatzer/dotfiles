# Time startup with zprof
zmodload zsh/zprof

# Use vim keybindings
bindkey -v

# History: Remove duplicates and share between sessions
setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=${ZDOTDIR:-~}/.zsh_history

# Add zsh_functions to path (for alacritty completions?)
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Use modern completion system
autoload -Uz compinit
compinit

# less - use XDG Directories
export LESSHISTFILE="${XDG_CONFIG_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"

# Macchina config file
export MACCHINA_CONF="${XDG_CONFIG_HOME}/macchina/macchina.toml"

# python startup configuration
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/startup.py"

# rustup shell setup
export CARGO_HOME="$XDG_DATA_HOME/cargo"
if [ -e $CARGO_HOME/env ]; then source "$CARGO_HOME/env"; fi

# Add aliases for convenience
alias config='/usr/bin/git  --git-dir=$HOME/.myconf --work-tree=$HOME'
alias vim='nvim'
alias mysql='/usr/local/mysql/bin/mysql'
alias vz='vim $ZDOTDIR/.zshrc'
alias cl='clear; macchina'

# dotnet
export DOTNET_ROOT=$XDG_DATA_HOME/dotnet
if [ -e $DOTNET_ROOT/dotnet ]; then
	export PATH=$PATH:$DOTNET_ROOT:$HOME/.dotnet/tools;
fi

# flutter
export PATH=$PATH:$XDG_DATA_HOME/flutter/bin

# RubyGems
export GEM_HOME=$XDG_DATA_HOME/gem
export PATH=$PATH:$GEM_HOME/bin

# Load nvm
export NVM_DIR="$([ -z "${XDG_DATA_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_DATA_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Start zoxide
eval "$(zoxide init zsh)"

# Start starship prompt
eval "$(starship init zsh)"

macchina
