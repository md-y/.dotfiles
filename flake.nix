{
  description = "Sam's NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat.url = "github:edolstra/flake-compat";

    rust-overlay.url = "github:oxalica/rust-overlay";

    agenix.url = "github:ryantm/agenix";

    #### For Modules

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.flake-compat.follows = "flake-compat";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nix-minecraft.inputs.flake-compat.follows = "flake-compat";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, agenix, ... } @ inputs:
  let 
    inherit (self) outputs;
    system = "x86_64-linux";
    overlays = import ./nixos/overlays.nix {
      inherit inputs;
    };
    pkgs = import nixpkgs {
      config = {
        allowUnfree = true;
      };
      inherit system overlays;
    };
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
          configName = "desktop";
        };
        modules = [
          ./nixos/configuration.nix
          ./nixos/modules/desktop.nix
          ./nixos/modules/wsl.nix
          ./nixos/modules/docker.nix
          ./nixos/modules/minecraft/minecraft.nix
          ./nixos/modules/nvidia.nix
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
          configName = "laptop";
        };
        modules = [
          ./nixos/configuration.nix
          ./nixos/modules/laptop.nix
          ./nixos/modules/wsl.nix
        ];
      };
      homeserver = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
          configName = "homeserver";
        };
        modules = [
          ./nixos/configuration.nix
          ./nixos/modules/homeserver/configuration.nix
	  ./nixos/modules/ssh-server.nix
        ];
      };
    };

    devShells.${system} = import ./nixos/shells/shells.nix { inherit pkgs; };
  };
}
