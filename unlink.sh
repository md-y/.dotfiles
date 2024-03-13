#! /usr/bin/bash 

# Make sure that this script is running where the script is located in the repo
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $SCRIPT_DIR

pushd home

echo "Removing current links:"
stow -D */ -vt "$HOME"


popd
popd
