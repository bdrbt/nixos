{pkgs,...}: {

  services.mpd = {
    enable = true;
  };

  home.packages = with pkgs; [
    ncmpcpp
  ];

}
