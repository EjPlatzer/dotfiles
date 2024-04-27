# Nushell Config File

# Print message on startup
print $"(ansi cyan_italic)-> Love God, Love Others (ansi reset)"

# Completions with carapace
source ~/.cache/carapace/init.nu

use pkgs.nu
use nix.nu
use nvim.nu *

def 'find files' [ 
    --exclude (-e): list # A list of (string) patterns to exclude from match
] {
  if ($exclude != null) {
    fd --prune -u $in /System/Volumes -E $exclude | lines
  } else {
    fd --prune -u $in /System/Volumes | lines
  }
}

let custom_config = {
  rm: {
    always_trash: true
  },
  table: {
    index_mode: 'auto'
  },
  completions: {
    external: {
      completer: $carapace_completer
    }
  },
  show_banner: false
}

# Use default config with custom overrides
source default_config.nu
$env.config = ($env.config | merge $custom_config)

