def config_path [] {
}

def backup_file [] { 
  let config_path = ($env.XDG_CONFIG_HOME | default $"($nu.home-path)/.config")
  $"($config_path)/nix/nix-packages.cfg" 
}

def packages [] {
  nix profile list 
  | lines 
  | split column ' ' 
  | reject column3
  | rename number name version
  | update name {|pkg|
    $pkg.name 
    | parse -r '.+\.(?<package>[\w\-]+)' 
    | get 0.package 
  } 
  | update version {|pkg
    | $pkg.version 
    | parse -r ($".*-($pkg.name)" + '-(?<version>.*)') 
    | get 0.version 
  } 
}

export def pkgs [] {
  packages
  | select number name version
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
