def backup_file [] { 
  let config_path = ($env.XDG_CONFIG_HOME | default $"($nu.home-path)/.config")
  $"($config_path)/nix/nix-packages.cfg" 
}

export def packages [] {
  nix profile list --json
  | from json
  | get elements.storePaths
  | each { first }
  | parse -r '/nix/store/[\w\d]+-(?<name>[\w-]+)-(?<version>.+)'
  | enumerate
  | flatten
}

export def backup [] {
  print "beginning backup"
  let backup_file = (backup_file)

  print $"backup_file is ($backup_file)"

  if ($backup_file | path exists) {
      print "Backing up previous nix packages record"
      mv $backup_file $"($backup_file).bak" -f
  } else {
      print "No previous nix packages record found"
  }

  let installed = (packages | get name)

  print $"Saving list of nix packages installed to ($backup_file)"
 
  $installed | save $backup_file -f
}

export def install-saved [] {
  let backup_file = backup_file

  print $"backup_file is ($backup_file)"

  if (not ($backup_file | path exists)) {
    print "No previous nix packages record found"
    return
  }

  print "Installing recorded nix packages"

  let saved_pkgs = (open $backup_file | lines)

  let installed_pkgs = (packages | get name)

  let pkgs_to_install = ($saved_pkgs | filter {|$pkg| $pkg not-in $installed_pkgs})
	
  
  if ($pkgs_to_install | is-empty) {
    print "All recorded packages are already installed."
  } else {
    print $"Installing packages ($pkgs_to_install)"
    let pkg_references = ($pkgs_to_install | each {|$pkg| $'nixpkgs#($pkg)'})
    nix profile install $pkg_references
  }
}

export def upgrade [] {
  nix profile upgrade '.*'
}

export def clean [] {
  nix-collect-garbage -d
}

export def history [] {
  nix profile history
}
