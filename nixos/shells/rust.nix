{ pkgs }:

let
  rust = pkgs.rust-bin.stable.latest.default.override {
    extensions = [
      "rust-src"
      "rust-analyzer"
    ];
  };
in
pkgs.mkShell {
  name = "rsa";
  buildInputs = [
    rust
  ];
}