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
    ./neovim.nix
    ./gtk.nix
    ./lf.nix
    ./zsh.nix
    ./fonts.nix
    ./mpd.nix
    ./android.nix
  ];

    home = {
    username = "dmitry";
    homeDirectory = "/home/dmitry";
  };

  home.packages = with pkgs; [
    tree
    
    transmission_4-gtk
    telegram-desktop
    zoom-us
    obsidian
  ];

  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT="wayland";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}

