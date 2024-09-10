{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
  ];

  networking.hostName = "nixos";
  system.stateVersion = "24.05";

  nixpkgs = {
    config = {
      allowUnfree = true;
    }
  }

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
  };

  channel.enable = false;
  registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
  nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

  # Packages
  environment.systemPackages = with pkgs; [
    gh
    git
    neovim
    curl
    wslu
  ];

  # Global Settings
  programs = {
    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [
          "gh:"
          "github:"
        ];
      };
    };
  };

  # User Settings
  home-manager.useGlobalPkgs = true;
  home-manager.users.sam = { pkgs, ... }: {
    programs.bash.enable = true;
    home.stateVersion = stateVersion;
    programs.git = {
      userName = "md-y";
      userEmail = "15069105+md-y@users.noreply.github.com";
      extraConfig = {
        credentia.helper = "oauth"; 
      };
    };
  };
}
