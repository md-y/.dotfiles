{ pkgs, ... }:

{
  environment.variables = {
    CGO_ENABLED="1";
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };
}
