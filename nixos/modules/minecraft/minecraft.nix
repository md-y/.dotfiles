{ inputs, pkgs, lib, ... }:

let
  defaultModpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/md-y/.dotfiles/refs/heads/master/nixos/modules/minecraft/modpacks/default/pack.toml";
    packHash = "sha256-b+4EfcjNc+c9ktjSO/vIXgXjGM2IAP6/wKsERPQfz/Y=";
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

  systemd.services."minecraft-server-default" = {
    serviceConfig = {
      RestrictAddressFamilies = lib.mkForce [ "AF_UNIX" "AF_INET" "AF_INET6" "AF_NETLINK" ];
    };
  };

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
        mcVersion = "1.20.10";
        protocolVersion = 770;
        package = pkgs.fabricServers.fabric-1_21_10;
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
}
