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

  environment.systemPackages = with pkgs; [
    vim
    eza
    bat
    lf
    ripgrep
    fd
    git
    curl
    wget
    p7zip
    unrar

    lutris
  ];
}
