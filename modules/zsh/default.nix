{ pkgs, ... }: {
  packages = with pkgs; [
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf
    zoxide
  ];
}
