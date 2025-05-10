{ inputs, ... }:

{
  # imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  # nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # services.minecraft-servers = {
  #   enable = true;
  #   eula = true;
  #   openFirewall = true;
  #   servers.forever = {
  #     enable = true;
  #     package = inputs.nixpkgs-unstable.fabricServers.fabric-1_21_5;
  #   };
  # };
}
