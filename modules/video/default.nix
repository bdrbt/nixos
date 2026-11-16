{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    mpv
    shotcut
  ];

  programs.obs-studio = {
    enable = true;
    plugins = [
      pkgs.obs-studio-plugins.wlrobs
    ];
  };
}
