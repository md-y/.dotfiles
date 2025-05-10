{
  description = "NixOS on WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-compat.url = "github:edolstra/flake-compat";

    #### For Modules

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.flake-compat.follows = "flake-compat";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nix-minecraft.inputs.flake-compat.follows = "flake-compat";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
  let 
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    unstable = import nixpkgs-unstable {
      inherit system;
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
          ./nixos/wsl.nix
          ./minecraft/minecraft.nix
        ];
      };
    };

    devShells.${system} = import ./shells/shells.nix { inherit pkgs unstable; };
  };
}
