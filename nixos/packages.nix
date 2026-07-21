{ pkgs, inputs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = import ./overlays.nix { inherit inputs; };
  };

  environment.systemPackages = with pkgs; [
    # Git Tools
    gh
    git
    git-credential-oauth

    # CLI Tools
    neovim
    curl
    zsh
    wget
    tree
    zoxide
    xclip
    gcc
    tmux
    zip
    unzip
    inputs.agenix.packages.${pkgs.system}.default

    # General Packages
    nodejs
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

  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
    };
  };
}
