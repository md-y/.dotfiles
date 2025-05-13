{ pkgs, unstable }:

pkgs.mkShell {
  name = "jsa";
  packages = [ 
    pkgs.nodejs
    unstable.bun
  ];
}
