export def upgrade [] {
  nix profile upgrade '.*'
}

export def clean [] {
  nix-collect-garbage -d
}

export def history [] {
  nix profile history
}
