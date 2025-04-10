# Nushell Environment Config File
#
# version = 0.78.0

# Set XDG Dirs
$env.XDG_CONFIG_HOME = $"($nu.home-path)/.config"
$env.XDG_CACHE_HOME = $"($nu.home-path)/.cache"
$env.XDG_DATA_HOME = $"($nu.home-path)/.local/share"
$env.XDG_STATE_HOME = $"($nu.home-path)/.local/state"

# Set npm config path
$env.NODE_REPL_HISTORY = $"($env.XDG_DATA_HOME)/node_repl_history"
$env.NPM_CONFIG_USERCONFIG = $"($env.XDG_CONFIG_HOME)/npm/npmrc"

# Set python startup script
$env.PYTHONSTARTUP = $"($env.XDG_CONFIG_HOME)/python/startup.py"

# Configure Rust
$env.CARGO_HOME = $"($env.XDG_DATA_HOME)/cargo"
$env.RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"

# Set PATH
$env.PATH = [
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /nix/var/nix/profiles/default/bin
  $"($env.HOME)/.nix-profile/bin"
  $"($nu.home-path)/.local/bin"
  $"($env.CARGO_HOME)/bin"
]

# "bat" as manpager
$env.MANPAGER = "nvim +Man!"

# Set Less history file
$env.LESSHISTFILE = $"($env.XDG_CONFIG_HOME)/less/history"
$env.LESSKEY = $"($env.XDG_CONFIG_HOME)/less/keys"

# Starship prompt
# starship init nu | save $"($nu.home-path)/.cache/starship/init.nu" -f
source /home/evan/.cache/starship/init.nu

# Carapace completions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
# mkdir ~/.cache/carapace
# carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# Configure fnm for Node version management
fnm env --json | from json | load-env
$env.PATH = ($env.PATH | append $"($env.FNM_MULTISHELL_PATH)/bin")

# Editor
$env.EDITOR = 'hx'
$env.VISUAL = $env.EDITOR

#######################################
#   /_\ | |  |_ _| /_\ / __| __/ __| #
#  / _ \| |__ | | / _ \\__ \ _|\__ \ #
# /_/ \_\____|___/_/ \_\___/___|___/ #
#######################################                                 

# Set dotfiles repo alias
alias cfg = git --work-tree $nu.home-path --git-dir $'($nu.home-path)/.dotfiles'
