# Nushell Config File

# Completions with carapace
source ~/.cache/carapace/init.nu

# nix aliases
source nix.nu

use pkgs.nu
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

# Print message on startup
print $"(ansi cyan_italic)-> Love God, Love Others (ansi reset)"

