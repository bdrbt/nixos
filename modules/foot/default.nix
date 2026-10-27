{ config, pkgs, ... }: {
  
  packages = with pkgs;[
    foot
  ];

  files = {
    ".config/foot" = {
      source = ./foot; 
    };
  };
}
