{ inputs, lib,config, pkgs, ... }:

{
  home = {
    username = "sam";
    homeDirectory = "/home/sam";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.bash.enable = true;
  programs.git = {
    userName = "md-y";
    userEmail = "15069105+md-y@users.noreply.github.com";
    extraConfig = {
      credential.helper = [
        "store --file ~/.git-credentials"
        "oauth"
      ];
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
