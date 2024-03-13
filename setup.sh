#! /usr/bin/bash 

pushd home

echo "Resetting current links:"
stow -D */ -vt "$HOME"

echo "Stowing home:"
stow */ -vt "$HOME" 

popd
