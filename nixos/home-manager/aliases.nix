{
  nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/#$HOST";
  dfe = "ide ~/.dotfiles/";
  dfo = "cd ~/.dotfiles/";
  pya = "nix develop ~/.dotfiles/#python --command \"$SHELL\"";
  cca = "nix develop ~/.dotfiles/#c --command \"$SHELL\"";
  jsa = "nix develop ~/.dotfiles/#js --command \"$SHELL\"";
  jva = "nix develop ~/.dotfiles/#java --command \"$SHELL\"";
  rsa = "nix develop ~/.dotfiles/#rust --command \"$SHELL\"";
}
