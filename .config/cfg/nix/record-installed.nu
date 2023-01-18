#!/usr/bin/env nu
# AUTHOR: Evan Platzer
# DATE: 2022-04-14
# DESC: Save the list of installed nix packages to a config file

let config_path = if ('XDG_CONFIG_HOME' in (env).name) {$env.XDG_CONFIG_HOME} else {$"($nu.home-path)/.config"}
let filepath = $"($config_path)/cfg/nix/nix-packages.cfg"

if ($filepath | path exists) {
    echo "Backing up previous nix packages record"
    mv $filepath $"($filepath).bak" -f
} else {
    echo "No previous nix packages record found"
}

echo $"Saving list of nix packages installed to ($filepath)"
nix-env -q | parse -r '(?P<package>[\w-]+)-(?P<version>\d+.\d+.\d+)' | get package | save $filepath -f
