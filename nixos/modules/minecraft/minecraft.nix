{ inputs, pkgs, lib, ... }:

let
  defaultModpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/md-y/.dotfiles/5ed51c250a71965adf62e4492b4081107ae11a3c/nixos/modules/minecraft/modpacks/default/pack.toml";
    packHash = "sha256-xnSsGDRpf5KJcbv5JXdWxuap6LppeEwmJiFBxUsl6p0=";
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

  lazymcServer = pkgs.writeShellApplication {
    name = "start-lazymc";
    runtimeInputs = [ newLazymc ];
    text = ''
      lazymc
    '';
  };
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
    restart = "no";
    package = lazymcServer;
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
      white-list = true;
      enforce-whitelist = true;
      difficulty = "hard";
      level-seed = 3368699220760197849;
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
