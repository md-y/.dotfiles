{ pkgs }:

pkgs.mkShell {
  name = "pla";
  packages = with pkgs; [
    ciao
    gprolog
    clingo
    swi-prolog
  ];
  shellHook = ''
    export CIAOPATH="$PWD/.ciao"
    export PATH="$CIAOPATH/build/bin:$PATH"
    mkdir -p .ciao
    echo "Ciao workspace set to $CIAOPATH"
  '';
}
