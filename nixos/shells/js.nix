{ pkgs, unstable }:

let
  nx = import ../packages/nx/nx.nix { inherit pkgs; };
in
pkgs.mkShell {
  name = "jsa";
  packages = [ 
    pkgs.nodejs
    unstable.bun
    nx
  ];
}
