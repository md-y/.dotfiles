{
  nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
  dfe = "sudo nvim ~/.dotfiles/";
  dfo = "cd ~/.dotfiles/";
  pya = "nix-shell --command \"$SHELL\" ~/.dotfiles/shells/python.nix";
  cca = "nix-shell --command \"$SHELL\" ~/.dotfiles/shells/c.nix";
}
