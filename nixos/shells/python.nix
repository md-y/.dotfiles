{ pkgs }:

let
  packages = [ 
    pkgs.python312Full
    pkgs.python312Packages.tkinter
    pkgs.python312Packages.pygraphviz
    pkgs.glib
    pkgs.zlib
    pkgs.libGL
    pkgs.fontconfig
    pkgs.xorg.libX11
    pkgs.libxkbcommon
    pkgs.freetype
    pkgs.dbus
    pkgs.stdenv.cc.cc
    pkgs.graphviz
    pkgs.pkg-config
    pkgs.cudatoolkit
    pkgs.linuxPackages.nvidia_x11
    pkgs.ncurses5
  ];
in
pkgs.mkShell {
  name = "pya";
  inherit packages;
  shellHook = ''
    export CUDA_PATH=${pkgs.cudatoolkit}
    export LD_LIBRARY_PATH="/usr/lib/wsl/lib:${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib:${pkgs.lib.makeLibraryPath packages}:$LD_LIBRARY_PATH"
    export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
    export EXTRA_CCFLAGS="-I/usr/include"

    if [ ! -d ".venv" ]; then
      echo "No virtual environment found. Creating one..."
      python -m venv .venv
    fi

    source .venv/bin/activate
    echo "Virtual environment activated!"

    if [ -f "requirements.txt" ]; then
      pip install -r requirements.txt | grep -v 'already satisfied'
      echo "Installed requirements."
    fi
  '';
}
