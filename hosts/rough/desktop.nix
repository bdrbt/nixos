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
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
  };
 
  programs.niri.eanble = true;

  environment.systemPackages = with pkgs; [
    gnome-keyring
    alacritty
    fuzzel
    wofi
    foot
    wl-clipboard
    waybar
    brave
    chromium
    vlc
    feh
    wineWowPackages.waylandFull
  ];
}
