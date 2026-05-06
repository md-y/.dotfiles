{ pkgs }:

{
  python = import ./python.nix { inherit pkgs; };
  c = import ./c.nix { inherit pkgs; };
  js = import ./js.nix { inherit pkgs; };
  java = import ./java.nix { inherit pkgs; };
  rust = import ./rust.nix { inherit pkgs; };
  prolog = import ./prolog.nix { inherit pkgs; };
}
