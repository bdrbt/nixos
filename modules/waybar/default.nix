{ pkgs, ... }:{

  files = {
    ".config/waybar" = {
      source = ./waybar;
    };
  };

  packages = with pkgs;[
    waybar
    brightnessctl
  ];
}
