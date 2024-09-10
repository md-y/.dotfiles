{ inputs, lib,config, pkgs, ... }:

{
  home = {
    stateVersion = "24.05";
    username = "sam";
    homeDirectory = "/home/sam";
  };

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "md-y";
    userEmail = "15069105+md-y@users.noreply.github.com";
    extraConfig = {
      credential.helper = [
        "store --file ~/.git-credentials"
        "oauth"
      ];
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
    };
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };
}
