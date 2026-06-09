{ pkgs }:

pkgs.mkShell {
  name = "jsa";
  packages = [ 
    pkgs.nodejs
    pkgs.unstable.bun
    pkgs.unstable.pnpm
    pkgs.unstable.yarn
  ];
}
