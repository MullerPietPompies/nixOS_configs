{
  description = "NixOS config flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    # Define your system architecture
    system = "x86_64-linux";

    # Get the package set for this system
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowAliases = true;
        };
    };
  in {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = system;

      modules = [
        # Your main NixOS config
        ./hosts/default/configuration.nix

        # Enable Home Manager as a NixOS module
        home-manager.nixosModules.home-manager

        # Configure Home Manager integration
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.muller = import ./hosts/default/home.nix;

          nixpkgs.pkgs = pkgs;
#           nixpkgs.config.allowUnfree = true;
        }
      ];
    };

    # Optionally, standalone Home Manager config (if needed)
    # homeConfigurations.muller = home-manager.lib.homeManagerConfiguration {
    #   pkgs = pkgs;
    #   modules = [ ./hosts/default/home.nix ];
    # };
  };
}
