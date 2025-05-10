{ pkgs, inputs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = final.system;
          config.allowUnfree = true;
        };
      })
    ];
  };

  environment.systemPackages = with pkgs; [
    # Git Tools
    gh
    git
    git-credential-oauth

    # CLI Tools
    neovim
    curl
    wslu
    zsh
    wget
    tree
    zoxide
    xclip
    gcc
    tmux

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
