{ inputs, pkgs, ... }:

let
  foreverModpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/md-y/.dotfiles/914911610a631cccebb3c04141c519f2b9d38453/minecraft/modpacks/forever/pack.toml";
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
    servers.forever = {
      enable = true;
      autoStart = false;
      package = pkgs.fabricServers.fabric-1_21_5;
      symlinks = {
        "mods" = "${foreverModpack}/mods";
      };
      serverProperties = {
        motd = "Sam's Minecraft Server";
      };
    };
  };
}
