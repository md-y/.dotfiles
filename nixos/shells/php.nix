{ pkgs }:

pkgs.mkShell {
  name = "pma";
  packages = with pkgs; [ 
    php
    mariadb
  ];
  shellHook = ''
    export MYSQL_DIR="$PWD/.mariadb"
    export MYSQL_SOCKET="$MYSQL_DIR/mysql.sock"

    mkdir -p "$MYSQL_DIR"

    if [ ! -d "$MYSQL_DIR/mysql" ]; then
      echo "Initializing MariaDB datadir..."
      mysql_install_db --datadir="$MYSQL_DIR" --auth-root-authentication-method=normal
    fi

    echo "Starting MariaDB..."

    mysqld \
      --datadir="$MYSQL_DIR" \
      --socket="$MYSQL_SOCKET" \
      --skip-networking \
      --skip-grant-tables &
    
    export MYSQL_PID=$!

    sleep 2

    echo "MariaDB started on socket: $MYSQL_SOCKET"
    echo "Use: mysql --socket=$MYSQL_SOCKET"

    trap 'echo "Stopping MariaDB..."; kill $MYSQL_PID' EXIT
  '';
}
