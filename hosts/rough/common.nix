{pkgs,...}: {
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
  ];
}
