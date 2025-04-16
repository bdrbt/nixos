{pkgs,...}: {

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ vaapiIntel intel-media-driver ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableLsColors = true;
  };

  # usb pen-drives automount
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.devmon.enable = true;
 
  # power profiles
  services.power-profiles-daemon.enable = true;


  environment.systemPackages = with pkgs; [
    vim
    eza
    bat
    lf
    ripgrep
    fd
    git
    p7zip
    unrar
    btop
  ];
}
