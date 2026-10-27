{ pkgs, ... }: {

  packages = with pkgs;[
    gnumake
    gcc
  ];
}
