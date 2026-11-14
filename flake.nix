{

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.preservation.url = "github:bdrbt/preservation";
  inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.hjem = {
    url = "github:feel-co/hjem";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.devflakes = {
    url = "github:bdrbt/devflakes";
    flake = false;
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      devflakes,
      ...
    }:
    {
      nixosConfigurations.area51 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          modulesDir = ./modules;
          inherit self;
        };

        modules = [
          inputs.disko.nixosModules.disko
          inputs.preservation.nixosModules.default
          inputs.hjem.nixosModules.default
          {
            config._module.args.inputs = inputs;
          }
          ./hosts/area51/configuration.nix
          ./hosts/area51/preservation.nix
          ./hosts/area51/disko.nix
        ];
      };
    };
}
