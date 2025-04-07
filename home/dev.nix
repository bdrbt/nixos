{pkgs, ...}: {

  # helix
  programs.helix = {
    enable = true;
  };

  # vscode
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  home.packages = with pkgs; [
    gnumake
    clang
    llvm
    gdb
    lldb
    delve

    pkgs.go
    pkgs.gopls
    pkgs.gotools
  ];
}
