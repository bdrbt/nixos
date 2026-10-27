{pkgs, ...}: {

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      font-awesome
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Liberation Serif"];
      };
    };
  };
}
