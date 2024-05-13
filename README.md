# Dotfiles

These are my personal dotfiles, primarily designed to work on Debian through WSL2.

## Setup

The initial packages should be installed with the command:

```bash
sudo apt-get install -y git curl gcc build-essential procps file man
```

Further packages are managed by [homebrew](https://brew.sh/), so it should be installed according to the documentation.

Afterwards, run within this directory:

```bash
brew tap Homebrew/bundle
brew bundle
```

The `home` directory is linked using GNU Stow using `link.sh`. Run this script after all packages have been installed.

The `etc` directory is not linked, and can be copied anytime with `copy-etc.sh`.

## Manual Setup

[wslu](https://wslutiliti.es/wslu/install.html) needs to be installed manually.

Git needs to be authenticated, which can easily be done through `gh`:

```bash
gh auth login -w
```

## Troubleshooting

Sometimes, Mason will fail to install the default packages, so each must be manually updated (using `u`).
