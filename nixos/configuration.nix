{ inputs, config, outputs, lib, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./packages.nix
  ];

  # General Settings
  system.stateVersion = "24.05";
  networking.hostName = "nixos";
  nix.settings = {
    experimental-features = "nix-command flakes";
    nix-path = config.nix.nixPath;
  };

  # WSL Settings
  wsl.enable = true;
  wsl.defaultUser = "sam";
  programs.nix-ld = {
    enable = true;
    # Setup package for VS Code Remote: https://nix-community.github.io/NixOS-WSL/how-to/vscode.html
    package = pkgs.nix-ld-rs;
  };

  # Init Home Manager
  users.defaultUserShell = pkgs.zsh;
  home-manager.useGlobalPkgs = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      sam = import ../home-manager/home.nix;
    };
  };
}
