{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "cca";
  buildInputs = with pkgs; [ 
    gcc
    glibc.out
    glibc.static
    gnumake
    gdb
  ];
}
