{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "evan";
  home.homeDirectory = "/Users/evan";

  home.packages = [
    pkgs.bat
    pkgs.bottom
    pkgs.delta
    pkgs.du-dust
    pkgs.fd
    pkgs.fzf
    pkgs.helix
    pkgs.hexyl
    pkgs.neovim
    pkgs.ripgrep
    pkgs.sd
    pkgs.starship
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Shell config
  programs.nushell = {
    enable = true;
    # envFile = {
    #   source = ~/.config/nushell/env.nu;
    # };
  };
}
