{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./nix.nix
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ./virtualization.nix
    ./users.nix
    ./localization.nix
    ./sound.nix
    ./desktop.nix
    ./common.nix
  ];

  environment.defaultPackages = lib.mkForce [];
  system.stateVersion = "25.05";
}
