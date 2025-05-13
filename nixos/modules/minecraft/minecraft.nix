{ inputs, pkgs, lib, ... }:

let
  defaultModpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/md-y/.dotfiles/refs/heads/master/minecraft/modpacks/default/pack.toml";
    packHash = "sha256-daRAKyoALeHF+vd7Y2Mzb7sog7EyZoIwaYwR9KKolgU=";
  };
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.default = {
      enable = true;
      autoStart = false;
      package = pkgs.fabricServers.fabric-1_21_5;
      symlinks = {
        "mods" = "${defaultModpack}/mods";
      };
      serverProperties = {
        motd = "Sam's Minecraft Server";
      };
    };
  };
}
