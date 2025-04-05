{pkgs,...}: {
  time = {
    timeZone = "Asia/Tashkent";
    hardwareClockInLocalTime = false;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i18n.psf.gz";
    packages = with pkgs; [terminus_font];
    keyMap = "us";
    colors = [
      "242424"
      "484848"
      "859900"
      "b58900"
      "268bd2"
      "d33682"
      "2aa198"
      "eee8d5"
      "002b36"
      "cb4b16"
      "586e75"
      "657b83"
      "839496"
      "6c71c4"
      "93a1a1"
      "fdf6e3"
    ];
  };
}
