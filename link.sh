#! /usr/bin/bash 

# Make sure that this script is running where the script is located in the repo
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $SCRIPT_DIR

pushd home

echo "Resetting current links:"
stow -D */ -vt "$HOME"

echo "Delete .bashrc"
rm "$HOME/.bashrc"

echo "Stowing home:"
stow */ -vt "$HOME" 

popd
popd
