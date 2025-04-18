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

$env.config.rm.always_trash = true
$env.config.table.index_mode = 'auto'
$env.config.completions.external.completer = $carapace_completer
$env.config.show_banner = false

# Print message on startup
print $"(ansi cyan_italic)-> Love God, Love Others (ansi reset)"

