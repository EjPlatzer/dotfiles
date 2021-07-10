# dotfiles

A repo to manage my cross-system dotfiles and configurations. This serves three core purposes:

1. Preserving some core configurations in case of emergency.
2. Synchronizing configurations/environments across machines to minimze the cost of context-switching
3. Streamlining the process of configuring new/reset machines in the future

The scripts in this repo only work in \*nix environments. The configuration files may be useful in Windows, but will likely have a different path.

# Currently Synced

-   `.gitconfig`
-   `zsh` shell, including:
    -   appropriate dotfiles (`.zshenv`, `.zshrc`, `.zprofile`)
    -   `starship` prompt
-   `alacritty` terminal emulator
    -   Presently, only configuration files are synced. It may be worth automating installation in the future
-   `.vimrc`
-   Rust, including:
    -   `rustup` toolchain manager
    -   `cargo`, the Rust package manager
    -   Rust binaries as found in `.config/myconf/rust/rust-binaries.cfg`

# To Sync

Applications/configurations that still require syncing:

-   Joplin
-   VSCode
-   dotnet?

It would be convenient to have some profiles that could be optionally included, such as an `nvm`/`npm` profile that would take care of that installation process for me but only if I desire it for the current machine.

# Inspiration and Help

This approach was inspired by many helpful devs online, but is taken most directly from [an Atlassian Git tutorial](https://www.atlassian.com/git/tutorials/dotfiles) on managing dotfiles.
