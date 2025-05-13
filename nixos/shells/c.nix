{ pkgs }:

pkgs.mkShell {
  name = "cca";
  packages = with pkgs; [ 
    gcc
    glibc.out
    glibc.static
    gnumake
    gdb
    emscripten
  ];
}
