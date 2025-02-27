{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [ 
    pkgs.gcc
    pkgs.musl
    pkgs.gnumake
  ];
}
