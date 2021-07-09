# dotfiles

A repo to manage my cross-system dotfiles and configurations. This serves three core purposes:
1. Preserving some core configurations in case of emergency.
2. Synchronizing configurations/environments across machines to minimze the cost of context-switching
3. Streamlining the process of configuring new/reset machines in the future

# Currently Synced

- `.gitconfig`
- `.zshrc` including:
    - `starship`
    - `zoxide`
- `alacritty`
- `bat`
- `.vimrc`

# To Sync

Applications/configurations that still require syncing:
- Joplin
- VSCode
- dotnet?

Ideally, I would be able to install the programs these configurations apply to (as well as my other preferred defaults) by the simple execution of a shell script or similar.

One good starting point might be to automate the process of installing my `cargo` binaries (`zoxide`, `bat`, `ripgrep`, `fd`, etc.). This would require verifying/installing `rustup`, as well as maintaining a cross-system list of `cargo` packages. This would be especially helpful since many of my configurations assume/depend on these already being installed (e.g. `git-delta` in my `.gitconfig`). 

I might look into setting my `ZDOTDIR` for `zsh` to `$HOME/.config/zsh` in `zshenv`, to minimize the dotfiles present in my home directory. This ought to be trivial.

It would be convenient to have some profiles that could be optionally included, such as an `nvm`/`npm` profile that would take care of that installation process for me but only if I desire it for the current machine.

# Inspiration and Help

This approach was inspired by many helpful devs online, but is taken most directly from [an Atlassian Git tutorial](https://www.atlassian.com/git/tutorials/dotfiles) on managing dotfiles.
