{ inputs, pkgs, lib, ... }:

let
  defaultModpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/md-y/.dotfiles/refs/heads/master/nixos/modules/minecraft/modpacks/default/index.toml";
    packHash = "sha256-daRAKyoALeHF+vd7Y2Mzb7sog7EyZoIwaYwR9KKolgU=";
  };

  lazymcConfig = cfg: pkgs.writeTextFile {
    name = "lazymc.toml";
    text = lib.generators.toINI {} {
      public = {
        address = "\"127.0.0.1:${cfg.publicPort or "25565"}\"";
        version = "\"${cfg.mcVersion}\"";
        protocol = cfg.protocolVersion;
      };
      server = {
        address = "\"127.0.0.1:${cfg.privatePort or "25566"}\"";
        directory = "\"${cfg.dataDir}\"";
        command = "\"${lib.getExe cfg.package} ${cfg.jvmOpts}\"";
      };
      join = {
        methods = "[ \"hold\", \"kick\" ]";
      };
      config = {
        version = "\"0.2.11\"";
      };
    };
  };
  
  # Fork with stdin
  newLazymc = pkgs.lazymc.overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner = "Ceddicedced";
      repo = "lazymc";
      rev = "v0.2.11";
      hash = "sha256-uMjM3w78qWnB/sNXRcxl30KJRm0I3BPEOr5IRU8FI0s=";
    };
  });
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
  };

  services.minecraft-servers.servers.default = {
    enable = true;
    autoStart = false;
    restart = "no";
    package = pkgs.writeShellApplication {
      name = "start-lazymc";
      runtimeInputs = [ newLazymc ];
      text = ''
        lazymc
      '';
    };
    symlinks = {
      "mods" = "${defaultModpack}/mods";
      "lazymc.toml" = lazymcConfig {
        dataDir = "/srv/minecraft/default";
        mcVersion = "1.20.5";
        protocolVersion = 770;
        package = pkgs.fabricServers.fabric-1_21_5;
        jvmOpts = "-Xmx2G -Xms1G";
      };
    };
    serverProperties = {
      motd = "Sam's Minecraft Server";
      server-port = 25566;
    };
  };

  services.rathole.settings = {
    client = {
      services = {
        minecraft = {
          local_addr = "127.0.0.1:25565";
        };
      };
    };
  };
}
