{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = "sam";
  programs.nix-ld = {
    enable = true;
    # Setup package for VS Code Remote: https://nix-community.github.io/NixOS-WSL/how-to/vscode.html
    package = pkgs.nix-ld-rs;
  };
}