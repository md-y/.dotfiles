{ pkgs ? import <nixpkgs> {} }:

let
  version = "21.2.3";
  hash = "sha256-Rm1jX+kGIm0sF0y4vgyVesOmRBW2+YjKYGQWTZw/f7s=";
  npmDepsHash = "sha256-bDi5TcMI5hgLYiav/UEYuUzAVPdzLHYvPYhmos+mf/g=";
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
