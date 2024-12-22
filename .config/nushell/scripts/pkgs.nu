def backup_file [] { 
  let config_path = ($env.XDG_CONFIG_HOME | default $"($nu.home-path)/.config")
  $"($config_path)/me/packages-nix.cfg" 
}

# List packages installed via the specified package manager
export def list [
  --manager (-m): string # the package manager to reference
] {
  match $manager {
    "nix" => {
      nix profile list --json
      | from json
      | get elements
      | items { |name, pkg| $pkg.storePaths | first }
      | parse -r '/nix/store/[\w\d]+-(?<name>[\w-]+)-(?<version>.+)'
    },
    "dnf" => {
      dnf list --installed 
      | detect columns --skip 1 --no-headers 
      | rename name version source
    },
    _ => {error make {msg: 'invalid package manager'}}
  }
}

# Save a list of packages installed via the specified package manager
export def backup [
  --manager (-m): string # the package manager to reference
] {
  let installed = (list -m $manager | get name)

  print "beginning backup"

  let backup_file = (
    backup_file 
    | path parse
    | update stem { |path| $"($path.stem)-($manager)" }
    | path join)

  print $"backup_file is ($backup_file)"

  if ($backup_file | path exists) {
      print "Backing up previous packages record"
      mv $backup_file $"($backup_file).bak" -f
  } else {
      print "No previous packages record found"
  }

  print $"Saving list of packages installed to ($backup_file)"
 
  $installed | save $backup_file -f
}

# Install the saved list of packages
export def install-saved [
  --manager (-m): string # The package manager to reference
] {
  let backup_file = backup_file

  print $"backup_file is ($backup_file)"

  if (not ($backup_file | path exists)) {
    print "No previous packages record found"
    return
  }

  print "Installing recorded packages"

  let saved_pkgs = (open $backup_file | lines)

  let installed_pkgs = (list -m $manager | get name)

  let pkgs_to_install = ($saved_pkgs | filter {|$pkg| $pkg not-in $installed_pkgs})
	
	$pkgs_to_install | debug
  
  if ($pkgs_to_install | is-empty) {
    print "All recorded packages are already installed."
  } else {
    print $"Installing packages ($pkgs_to_install)"
    let pkg_references = ($pkgs_to_install | each {|$pkg| match $manager {
      'nix' => $'nixpkgs#($pkg)',
      'dnf' => $pkg,
      _ => { error make {msg: 'invalid package manager'}},
    }})
    match $manager {
      'nix' => { nix profile install ...$pkg_references},
      'dnf' => { sudo dnf install ...$pkg_references},
      _ => { error make {msg: 'invalid package manager'}},
    }
  }
}
