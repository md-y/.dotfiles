#! /usr/bin/bash

# Make sure that this script is running where the script is located in the repo
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
pushd $SCRIPT_DIR

cp -vr ./etc/* /etc/

popd
