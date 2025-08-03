{ pkgs ? import <nixpkgs> {} }:

let
  version = "21.4.0-beta.5";
  hash = "sha256-KEkx2UmAXYckGFltwJC4z4AsNyCvrF8dLF+KlqOiVy0=";
  npmDepsHash = "sha256-gb7R+cNjYmDiEBaniXVwu6wJTvGz96Y3WZOc/njymuU=";
in
pkgs.buildNpmPackage {
  pname = "nx";
  inherit version npmDepsHash;

  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/nx/-/nx-${version}.tgz";
    inherit hash;
  };

  dontNpmBuild = true;
  postPatch = ''
    ln -s ${./package-lock.json} package-lock.json
  '';

  meta = {
    description = "The core Nx plugin contains the core functionality of Nx like the project graph, nx commands and task orchestration.";
    license = pkgs.lib.licenses.mit;
  };
}
