# Nushell Environment Config File

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# Set XDG Dirs
let-env XDG_CONFIG_HOME = $"($nu.home-path)/.config"
let-env XDG_CACHE_HOME = $"($nu.home-path)/.cache"
let-env XDG_DATA_HOME = $"($nu.home-path)/.local/share"
let-env XDG_STATE_HOME = $"($nu.home-path)/.local/state"

# Set PATH
let-env PATH = [/usr/local/bin, /usr/bin, /bin, /usr/sbin, /sbin, /nix/var/nix/profiles/default/bin, $"($env.HOME)/.nix-profile/bin"]

# Set NIX_PATH
let-env NIX_PATH = [~/.nix-defexpr/channels, /nix/var/nix/profiles/per-user/root/channels]

# Set Less history file
let-env LESSHISTFILE = $"($env.XDG_CONFIG_HOME)/less/history"
let-env LESSKEY = $"($env.XDG_CONFIG_HOME)/less/keys"

# Starship prompt
starship init nu | save $"($nu.home-path)/.cache/starship/init.nu"
source /Users/evan/.cache/starship/init.nu

#######################################
#   /_\ | |  |_ _| /_\ / __| __/ __| #
#  / _ \| |__ | | / _ \\__ \ _|\__ \ #
# /_/ \_\____|___/_/ \_\___/___|___/ #
#######################################                                 

# Nix management aliases
alias nixu = (nix-channel --update; home-manager switch;)
alias nixg = (nix-collect-garbage -d)

# Set dotfiles repo alias
alias cfg = git $'--work-tree=($nu.home-path)' $'--git-dir=($nu.home-path)/.cfg'

