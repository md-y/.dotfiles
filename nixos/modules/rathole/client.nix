{ pkgs, ... }:

let
  ratholePackage = pkgs.rathole.overrideAttrs (old: {
    doCheck = false;
  });
in {
  services.rathole = {
    enable = true;
    package = ratholePackage;
    role = "client";
    credentialsFile = ../../../rathole.toml;
  };
}