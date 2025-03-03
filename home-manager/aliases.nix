{
  nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
  dfe = "$IDE ~/.dotfiles/";
  dfo = "cd ~/.dotfiles/";
  pya = "nix-shell --command \"$SHELL\" ~/.dotfiles/shells/python.nix";
  cca = "nix-shell --command \"$SHELL\" ~/.dotfiles/shells/c.nix";
}
