{ pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # CLI Tools
    gh
    git
    git-credential-oauth
    neovim
    curl
    wslu
    zsh
    wget
    tree
    zoxide
    xclip

    # Languages
    nodejs
    # python # Don't install python directly: https://wiki.nixos.org/wiki/Python
    jdk21_headless
    go
  ];

  programs.git = {
    config = {
      init.defaultBranch = "main";
    };
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };
}
