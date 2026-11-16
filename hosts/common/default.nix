{ pkgs, ... }: {

  imports = [
    ./fonts.nix
    ./bluetooth.nix
  ];

  environment."systemPackages" = with pkgs; [
    telegram-desktop
  ];
}
