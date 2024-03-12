#! /usr/bin/bash 

pushd home

# Find and remove all potential conflicting files within $HOME
# This is needed especially for MSYS2 since stow can't identify symlinks
find . \( -type f -o -type l \) | cut -d '/' -f3- | sed "s|^|$HOME/|" | xargs -I{} rm -vf {}

echo "Stowing home"
stow */ -t "$HOME" 

popd
