#!/usr/bin/env nu
# AUTHOR: Evan Platzer
# DATE: 2022-06-24
# DESC: Install the recorded list on nix packages

let filepath = $"(if ($env.XDG_CONFIG_HOME != null) {$env.XDG_CONFIG_HOME} else {$"($nu.home-path)/.config"})/cfg/nix/nix-packages.cfg"

if ($filepath | path exists) {
    echo "Installing recorded nix packages"
    open $filepath 
    | lines 
    | where { |$pkg| 
        nix-env -q $pkg | empty? 
    } 
    | reduce { |$pkgs, $pkg| 
        echo $"($pkg) will be installed"
	$"(pkgs) ($pkg)"
    } 
    | nix-env -i $in
    }
} else {
    echo "No previous nix packages record found"
}

