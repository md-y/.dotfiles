{ pkgs }:

pkgs.mkShell {
  name = "rsa";
  buildInputs = [
    pkgs.rust-bin.beta.latest.default
  ];
}