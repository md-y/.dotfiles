# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib,config, pkgs, ... }:

{
  home = {
    username = "sam";
    homeDirectory = "/home/sam";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  # User Settings
  home-manager.useGlobalPkgs = true;
  home-manager.users.sam = { pkgs, ... }: {
    programs.bash.enable = true;
    home.stateVersion = "24.05";
    programs.git = {
      userName = "md-y";
      userEmail = "15069105+md-y@users.noreply.github.com";
      extraConfig = {
        credentia.helper = "oauth";
      };
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
