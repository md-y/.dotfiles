{
  nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
  dfe = "sudo nvim ~/.dotfiles/";
  pya = "nix-shell --command \"$SHELL\" ~/.dotfiles/shells/python.nix";
}
