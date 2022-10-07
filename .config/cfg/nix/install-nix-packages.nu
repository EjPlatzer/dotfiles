#!/usr/bin/env nu
# AUTHOR: Evan Platzer
# DATE: 2022-06-24
# DESC: Install the recorded list on nix packages

let config_path = if ('XDG_CONFIG_HOME' in (env).name) {$env.XDG_CONFIG_HOME} else {$"($nu.home-path)/.config"}
let filepath = $"($config_path)/cfg/nix/nix-packages.cfg"

if ($filepath | path exists) {
    echo "Installing recorded nix packages"
    let pkgs = (open $filepath
        | lines
	| where { |$pkg| nix-env -q $pkg | is-empty }
    )
    if ($pkgs | is-empty) {
        echo "All recorded packages are already installed."
    } else {
        echo $"Installing packages ($pkgs)"
        nix-env -i $pkgs
    }
} else {
    echo "No previous nix packages record found"
}

