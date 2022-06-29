# dotfiles

A repo to manage my cross-platform dotfiles and configurations. This serves three core purposes:

1. Preserving some core configurations in case of emergency.
2. Synchronizing configurations/environments across machines to minimze the cost of context-switching
3. Streamlining the process of configuring new/reset machines in the future

The scripts in this repo are primarily intended for Unix-like environments, although the `windows` branch has minor adjustments to make some things work in Windows.

## Installation

1. Clone the git repo
    ```sh
    git clone --bare git@github.com:EjPlatzer/dotfiles.git ~/.cfg
    ```

2. Add cfg alias for managing bare repo
    ```nu
    alias cfg = git $'--work-tree=($nu.home-path)' $'--git-dir=($nu.home-path)/.cfg'
    ```
2. Disable untracked files
    ```sh
    cfg config --local status.showUntrackedFiles no
    ```
2. Restore missing files
    ```sh
    cfg restore --staged .
    cfg restore .
    ```

You may need to restart the shell for the configurations to take effect.

# Currently Synced

-   `git`	configuration file
-   `nushell`:
    -   configuration
    -   environment
    -   scripts
-   `nix` package list automation
-   `starship` prompt
-   `neovim` editor:
    -	`init.vim` configuration file	
    -	using `vim-plug` to manage plugins

# Inspiration and Help

This approach was inspired by many helpful devs online, but is taken most directly from [an Atlassian Git tutorial](https://www.atlassian.com/git/tutorials/dotfiles) on managing dotfiles.
