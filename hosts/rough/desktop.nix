{
  inputs,
  pkgs,
  ...
}: {
  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  environment.systemPackages = with pkgs; [
    foot
    wl-clipboard
    swaybg
    waybar
    telegram-desktop
    brave
  ];
}
