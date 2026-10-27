{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    preservation.url = "github:bdrbt/preservation";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.area51 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.default
    	inputs.hjem.nixosModules.default
        ./hosts/area51/configuration.nix 
        ./hosts/area51/preservation.nix
        ./hosts/area51/disko.nix
      ];
    };
  };
}

