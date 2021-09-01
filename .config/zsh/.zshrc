# Use vim keybindings
bindkey -v

# History: Remove duplicates and share between sessions
setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Add zsh_functions to path (for alacritty completions?)
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Use modern completion system
autoload -Uz compinit
compinit

# Add config alias to manage config files
alias config='/usr/bin/git  --git-dir=$HOME/.myconf --work-tree=$HOME'
alias mysql='/usr/local/mysql/bin/mysql'
alias cd='echo "This is not the command you are looking for."; false'
alias ls='echo "This is not the command you are looking for."; false'
alias rm='echo "This is not the command you are looking for."; false'

# Load nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Start zoxide
eval "$(zoxide init zsh)"

# Start starship prompt
eval "$(starship init zsh)"

macchina
