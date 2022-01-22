# A custom git alias to manage my dotfiles repo
def myconf [
  ...rest	# The arguments to pass to git; Note that, due to nushell limitations, flags must be quoted, e.g. myconf checkout '-b' new_branch
] {
  if (($rest | length) > 0 ) {
    let subcommands = ($rest | reduce { build-string $acc " " $it })
    nu -c $"git --work-tree=($nu.env.HOME) --git-dir=($nu.env.HOME)/.myconf ($subcommands)"
  } {
    nu -c $"git --work-tree=($nu.env.HOME) --git-dir=($nu.env.HOME)/.myconf"
  }
}
