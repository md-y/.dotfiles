{ pkgs }:

let
  nx = import ../packages/nx/nx.nix { inherit pkgs; };
in
pkgs.mkShell {
  name = "jsa";
  packages = [ 
    pkgs.nodejs
    pkgs.unstable.bun
    pkgs.unstable.pnpm
    pkgs.unstable.yarn
    nx
  ];
}
