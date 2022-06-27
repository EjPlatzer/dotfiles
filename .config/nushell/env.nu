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

# Add nix binaries to path
let-env PATH = ($env.PATH | append $'($nu.home-path)/.nix-profile/bin')

# Set Less history file
let-env LESSHISTFILE = $"($env.XDG_CONFIG_HOME)/less/history"
let-env LESSKEY = $"($env.XDG_CONFIG_HOME)/less/keys"

# Set default editor
let-env EDITOR = 'nvim'
let-env VISUAL = 'nvim'

# init starship prompt
starship init nu | save $"($env.XDG_CACHE_HOME)/starship/init.nu"
source /home/evan/.cache/starship/init.nu

# Load fnm vars and path
fnm env --shell bash | lines | last 6 | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | reduce -f {} { |it, acc| $acc | upsert $it.name $it.value }  | load-env
let-env PATH = ($env.PATH | append $"($env.FNM_MULTISHELL_PATH)/bin")

#######################################
#   /_\ | |  |_ _| /_\ / __| __/ __| #
#  / _ \| |__ | | / _ \\__ \ _|\__ \ #
# /_/ \_\____|___/_/ \_\___/___|___/ #
#######################################                                 

# Nix management aliases
alias nixu = (nix-channel --update; nix-env -u)
alias nixg = (nix-collect-garbage -d)

# Set dotfiles repo alias
alias cfg = git $'--work-tree=($nu.home-path)' $'--git-dir=($nu.home-path)/.cfg'

