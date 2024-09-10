{
  description = "NixOS on WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... } @ inputs:
  let 
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = {inherit inputs outputs;};
        modules = [
          nixos-wsl.nixosModules.default
	  ./nixos/configuration.nix
        ];
      };
    };
  };
}
