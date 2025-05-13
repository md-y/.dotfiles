{ pkgs, unstable }:

{
  python = import ./python.nix { inherit pkgs; };
  c = import ./c.nix { inherit pkgs; };
  js = import ./js.nix { inherit pkgs unstable; };
}