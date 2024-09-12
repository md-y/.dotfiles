# .dotfiles

These are my personal dotfiles for NixOS running on WSL2.

## Setting Up

1. Follow the NixOS WSL2 [instructions](https://github.com/nix-community/NixOS-WSL).
2. Follow the [instructions](https://nix-community.github.io/NixOS-WSL/how-to/change-username.html) to change the username to `sam`.
3. Temporarily install `git`:
```bash
nix-shell -p git
```
4. Rebuild the system:
```bash
sudo nixos-rebuild switch --flake ~/.dotfiles
```
5. Restart WSL2
