{ pkgs, lib, ... }:

{
  environment.variables = {
    CGO_ENABLED="1";
    LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.stdenv.cc.cc
    ];
    IDE="code";
  };
}
