{ inputs, config, outputs, lib, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  networking.hostName = "nixos";
  system.stateVersion = "24.05";

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    nix-path = config.nix.nixPath;
  };

  wsl.enable = true;
  wsl.defaultUser = "sam";

  # Packages
  environment.systemPackages = with pkgs; [
    gh
    git
    neovim
    curl
    wslu
    git-credential-oauth
  ];

  # Global Settings
  programs = {
    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
      };
    };
  };

  # User Settings
  home-manager.useGlobalPkgs = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      sam = import ../home-manager/home.nix;
    };
  };
}
