{ pkgs }:

pkgs.mkShell {
  name = "jva";
  packages = [ 
    pkgs.jdk21_headless
  ];
}
