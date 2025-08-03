{ pkgs ? import <nixpkgs> {} }:

let
  version = "21.3.11";
  hash = "sha256-qALzmHvESXcNLtn1kekmOK643j/d8Q+jcLf7rPt+Y2o=";
  npmDepsHash = "sha256-KeuSYm5xcSK34+zNO1wDZKMjH9bk7pEwisgxXcPJhYA=";
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
