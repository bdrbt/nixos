{
  inputs,
  pkgs,
  ...
}: {

#  programs.sway = {
#    enable = true;
#    xwayland.enable = true;
#  };
#
#  xdg.portal = {
#    enable = true;
#    xdgOpenUsePortal = true;
#    extraPortals = with pkgs; [
#      xdg-desktop-portal-wlr
#    ];
#  };
#
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    kitty
    wofi
    foot
    wl-clipboard
    swaybg
    swayimg
    waybar
    telegram-desktop
    brave
  ];
}
