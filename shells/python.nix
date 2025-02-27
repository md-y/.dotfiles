{ pkgs ? import <nixpkgs> {} }:

let
  buildInputs = [ 
    pkgs.python312Full
    pkgs.python312Packages.tkinter
    pkgs.glib
    pkgs.zlib
    pkgs.libGL
    pkgs.fontconfig
    pkgs.xorg.libX11
    pkgs.libxkbcommon
    pkgs.freetype
    pkgs.dbus
  ];
in
pkgs.mkShell {
  inherit buildInputs;
  shellHook = ''
    if [ ! -d ".venv" ]; then
      echo "No virtual environment found. Creating one..."
      python -m venv .venv
    fi

    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath buildInputs}:$LD_LIBRARY_PATH"

    source .venv/bin/activate
    echo "Virtual environment activated!"

    if [ -f "requirements.txt" ]; then
      pip install -r requirements.txt | grep -v 'already satisfied'
      echo "Installed requirements."
    fi
  '';
}
