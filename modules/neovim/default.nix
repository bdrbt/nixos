{ pkgs, ...}:{
  packages = with pkgs;[
    tree-sitter
    wl-clipboard
    ripgrep

    # Required langservers.
    # lua
    emmylua-ls
    stylua
    # nix 
    nil
    nixfmt
  ];
}
