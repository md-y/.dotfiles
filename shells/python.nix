{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs.python3Packages; [ 
    pkgs.python3
  ];

  shellHook = ''
    if [ ! -d ".venv" ]; then
      echo "No virtual environment found. Creating one..."
      python -m venv .venv
    fi

    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH

    source .venv/bin/activate
    echo "Virtual environment activated!"
  '';
}
