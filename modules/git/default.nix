{ pkgs, ... }: {

  packages = with pkgs; [
    git
  ];

  files = {
    ".gitconfig" = {
      source = ./gitconfig;
    };
  };
}
