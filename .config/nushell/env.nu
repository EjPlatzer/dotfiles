# Nushell Environment Config File
#
# version = 0.78.0

# Set XDG Dirs
$env.XDG_CONFIG_HOME = $"($nu.home-path)/.config"
$env.XDG_CACHE_HOME = $"($nu.home-path)/.cache"
$env.XDG_DATA_HOME = $"($nu.home-path)/.local/share"
$env.XDG_STATE_HOME = $"($nu.home-path)/.local/state"

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIR = ($nu.config-path | path dirname | path join 'scripts')
$env.NU_SCRIPTS_DIR = ($env.XDG_CONFIG_HOME | path join 'nushell' 'scripts')

$env.NU_LIB_DIRS = [
    $env.NU_LIB_DIR
    $env.NU_SCRIPTS_DIR
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# Set npm config path
$env.NODE_REPL_HISTORY = $"($env.XDG_DATA_HOME)/node_repl_history"
$env.NPM_CONFIG_USERCONFIG = $"($env.XDG_CONFIG_HOME)/npm/npmrc"

# Set python startup script
$env.PYTHONSTARTUP = $"($env.XDG_CONFIG_HOME)/python/startup.py"

# Configure Dotnet tools
$env.DOTNET_ROOT = $"($env.XDG_DATA_HOME)/dotnet"

# Configure ruby gems
$env.GEM_HOME = $"($env.XDG_DATA_HOME)/gem"

# Configure Rust
$env.CARGO_HOME = $"($env.XDG_DATA_HOME)/cargo"
$env.RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"

# Set PATH
$env.PATH = [
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

# "bat" as manpager
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"

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
$env.EDITOR = 'nvim'
$env.VISUAL = $env.EDITOR

$env.DEFAULT_CONFIG_FILE = $"($env.NU_LIB_DIR)/default_config.nu"
$env.DEFAULT_CONFIG_REMOTE = "https://raw.githubusercontent.com/nushell/nushell/main/crates/nu-utils/src/sample_config"


export def "config update default" [ --help (-h) ] {
  print "Starting to update default config"
  let name = ($env.DEFAULT_CONFIG_FILE | path basename)
  let default_url = ($env.DEFAULT_CONFIG_REMOTE | path join $name)

  if ($env.DEFAULT_CONFIG_FILE| path expand | path exists) {
  print "Default config exists, updating"
    let new = (http get $default_url)
    let old = (open $env.DEFAULT_CONFIG_FILE)

    if $old != $new {
      $new | save --force --raw $env.DEFAULT_CONFIG_FILE
      print $'Updated ($name)'
    } else {
      print $'($name): No change'
    }
  } else {
  print "Default config doesn't exist, fetching"
    http get $default_url | save --raw $env.DEFAULT_CONFIG_FILE
    print $'Downloaded new ($name)'
  }
}

if not ($env.DEFAULT_CONFIG_FILE | path exists) {
  print $"(ansi red_bold)error(ansi reset): ($env.DEFAULT_CONFIG_FILE) does not exist..."
  print $"(ansi cyan)info(ansi reset): pulling default config file..."
  config update default
}

#######################################
#   /_\ | |  |_ _| /_\ / __| __/ __| #
#  / _ \| |__ | | / _ \\__ \ _|\__ \ #
# /_/ \_\____|___/_/ \_\___/___|___/ #
#######################################                                 

# Set dotfiles repo alias
alias cfg = git --work-tree $nu.home-path --git-dir $'($nu.home-path)/.dotfiles'
