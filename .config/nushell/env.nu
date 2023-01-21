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

# Set npm config path
let-env NPM_CONFIG_USERCONFIG = $"($env.XDG_CONFIG_HOME)/npm/npmrc"

# Set python startup script
let-env PYTHONSTARTUP = $"($env.XDG_CONFIG_HOME)/python/startup.py"

# Configure Dotnet tools
let-env DOTNET_ROOT = $"($env.XDG_DATA_HOME)/dotnet"

# Configure ruby gems
let-env GEM_HOME = $"($env.XDG_DATA_HOME)/gem"

# Configure Rust
let-env CARGO_HOME = $"($env.XDG_DATA_HOME)/cargo"
let-env RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"

# Set PATH
let-env PATH = [
  /usr/local/bin
  /usr/local/share/dotnet
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /nix/var/nix/profiles/default/bin
  $"($env.HOME)/.nix-profile/bin"
  $"($env.XDG_DATA_HOME)/cargo/bin"
  $"($env.XDG_DATA_HOME)/npm/bin"
  $"($nu.home-path)/.local/bin"
  $env.DOTNET_ROOT
  $"($env.HOME)/.dotnet/tools"
  $"($env.GEM_HOME)/bin"
]

# Set Less history file
let-env LESSHISTFILE = $"($env.XDG_CONFIG_HOME)/less/history"
let-env LESSKEY = $"($env.XDG_CONFIG_HOME)/less/keys"

# Starship prompt
# starship init nu | save $"($nu.home-path)/.cache/starship/init.nu"
source /Users/evan.platzer/.cache/starship/init.nu

# Configure fnm for Node version management
fnm env --json | from json | load-env
let-env PATH = ($env.PATH | append $"($env.FNM_MULTISHELL_PATH)/bin")

# Editor
let-env EDITOR = 'lvim'
let-env VISUAL = 'lvim'

#######################################
#   /_\ | |  |_ _| /_\ / __| __/ __| #
#  / _ \| |__ | | / _ \\__ \ _|\__ \ #
# /_/ \_\____|___/_/ \_\___/___|___/ #
#######################################                                 

# Nix management aliases
alias nixu = (nix-channel --update; nix-env -u;)
alias nixg = (nix-collect-garbage -d)

# Set dotfiles repo alias
alias cfg = git $'--work-tree=($nu.home-path)' $'--git-dir=($nu.home-path)/.cfg'

