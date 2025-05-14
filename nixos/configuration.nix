{ inputs, config, outputs, lib, pkgs, configName ? "nixos", ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./packages.nix
    ./env.nix
  ];

  # General Settings
  system.stateVersion = "24.11";
  networking.hostName = configName;
  nix.settings = {
    experimental-features = "nix-command flakes";
    nix-path = config.nix.nixPath;
  };

  # Init Home Manager
  users.defaultUserShell = pkgs.zsh;
  home-manager.useGlobalPkgs = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      sam = import ./home-manager/home.nix;
    };
  };
}
