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
- `rustup`
- `cargo`

# To Sync

Applications/configurations that still require syncing:
- Joplin
- VSCode
- dotnet?

Ideally, I would be able to install the programs these configurations apply to (as well as my other preferred defaults) by the simple execution of a shell script or similar.

It would be convenient to have some profiles that could be optionally included, such as an `nvm`/`npm` profile that would take care of that installation process for me but only if I desire it for the current machine.

# Inspiration and Help

This approach was inspired by many helpful devs online, but is taken most directly from [an Atlassian Git tutorial](https://www.atlassian.com/git/tutorials/dotfiles) on managing dotfiles.
