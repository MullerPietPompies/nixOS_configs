{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations.nixos = pkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./hosts/default/configuration.nix
        home-manager.nixosModules.default
      ];
    };

    homeConfigurations.muller = home-manager.lib.homeManagerConfiguration {
      inherit system;
      pkgs = pkgs;
      configuration = import ./hosts/default/home.nix { inherit pkgs; };
    };
  };
}
