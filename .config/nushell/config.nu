# Nushell Config File

# Completions with carapace
let carapace_completer = {|spans| 
  carapace $spans.0 nushell $spans | from json
}

use nix.nu
use nvim.nu *
use themes

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
