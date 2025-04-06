{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./xdg.nix
    ./dev.nix
    ./git.nix
    ./gtk.nix
    ./lf.nix
    ./zsh.nix
    ./fonts.nix
  ];

    home = {
    username = "dmitry";
    homeDirectory = "/home/dmitry";
  };

  home.packages = with pkgs; [
    pkgs.transmission_4-gtk
    pkgs.telegram-desktop
    pkgs.zoom-us
    pkgs.obsidian
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}

