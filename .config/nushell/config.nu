# Nushell Config File

# Completions with carapace
let carapace_completer = {|spans| 
  carapace $spans.0 nushell $spans | from json
}

use nix.nu
use themes.nu

def 'find files' [ 
    --exclude (-e): list # A list of (string) patterns to exclude from match
] {
  if ($exclude != $nothing) {
    fd --prune -u $in /System/Volumes -E $exclude | lines
  } else {
    fd --prune -u $in /System/Volumes | lines
  }
}

let custom_config = {
  rm: {
    always_trash: true
  },
  cd: {
    abbreviations: true
  },
  table: {
    index_mode: 'auto'
  },
  completions: {
    external: {
      completer: $carapace_completer
    }
  },
  color_config: (themes default),
  show_banner: false
}

# Use default config with custom overrides
source default_config.nu
let-env config = ($env.config | merge $custom_config)
