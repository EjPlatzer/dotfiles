def config_path [] {
  if ('XDG_CONFIG_HOME' in (env).name) {
    $env.XDG_CONFIG_HOME
  } else {
    $"($nu.home-path)/.config"
  }
}

def backup_file [] { $"(config_path)/nix/nix-packages.cfg" }

def packages [] {
  nix profile list 
  | lines
  | parse -r '(?<number>\d+) (?<reference>\S+\.(?<package>[\w-]+)) (?<revision>\S+) (?<path>\S+-(?<version>[\d.]+))' 
}

export def pkgs [] {
  packages
  | select number package version
}

export def backup [] {
  let backup_file = backup_file

  if ($backup_file | path exists) {
      echo "Backing up previous nix packages record"
      mv $backup_file $"($backup_file).bak" -f
  } else {
      echo "No previous nix packages record found"
  }

  let installed = (packages | get package)

  echo $"Saving list of nix packages installed to ($backup_file)"
 
  $installed | save $backup_file -f
}

export def install-saved [] {
  let backup_file = backup_file

  echo $"backup_file is ($backup_file)"

  if (not ($backup_file | path exists)) {
    echo "No previous nix packages record found"
    return
  }

  echo "Installing recorded nix packages"

  let saved_pkgs = (open $backup_file | lines)

  let installed_pkgs = (packages | get package)

  let pkgs_to_install = ($saved_pkgs | filter {|$pkg| $pkg not-in $installed_pkgs})
	
  
  if ($pkgs_to_install | is-empty) {
    echo "All recorded packages are already installed."
  } else {
    echo $"Installing packages ($pkgs_to_install)"
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
