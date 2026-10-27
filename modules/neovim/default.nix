{ pkgs, ...}:{
  packages = with pkgs;[
    tree-sitter
    wl-clipboard
    ripgrep

    # Required langservers.
    # Lua
    # lua-language-server
    emmylua-ls
    stylua
  ];
}
