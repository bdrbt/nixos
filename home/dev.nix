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
 
    nodejs_22
    yarn
    ansible
   
    go
    gopls
    gotools
    golangci-lint
    golangci-lint-langserver
  ];
}
