{ pkgs }:

pkgs.mkShell {
  name = "pla";
  packages = with pkgs; [
    ciao
    gprolog
  ];
  shellHook = ''
    export CIAOPATH="$PWD/.ciao"
    mkdir -p .ciao
    echo "Ciao workspace set to $CIAOPATH"
  '';
}
