# .dotfiles

These are my personal dotfiles for NixOS.

## Setting Up WSL2

1. Follow the NixOS WSL2 [instructions](https://github.com/nix-community/NixOS-WSL).
2. Follow the [instructions](https://nix-community.github.io/NixOS-WSL/how-to/change-username.html) to change the username to `sam`.
3. Temporarily install `git`:
```bash
nix-shell -p git
```
4. Clone this repository to `~/.dotfiles`:
```bash
git clone https://github.com/md-y/.dotfiles ~/.dotfiles
```
5. Rebuild the system using the appropriate host name:
```bash
sudo nixos-rebuild switch --flake ~/.dotfiles#HOSTNAME
```
6. Restart WSL2

Occasionally, run:
```bash
nix flake update
```

## Standalone

1. Setup NixOS using [manual](https://nixos.org/manual/nixos/stable/).
2. Use default configuration, but add new user `sam` like so:
```nix
# configuration.nix
users.users.sam = {
  isNormalUser = true;
  description = "sam";
  extraGroups = [ "wheel" "networkmanager" ]
  initialPassword = "temp";
};
```
3. Log into NixOS using `sam`
4. Clone this repository to `~/.dotfiles`:
```bash
git clone https://github.com/md-y/.dotfiles ~/.dotfiles
```
5. Rebuild the system using the appropriate host name:
```bash
sudo nixos-rebuild switch --flake ~/.dotfiles#HOSTNAME
```
