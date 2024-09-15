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

    # Language Tools
    nodePackages.pnpm
    moon
    unstable.buf

    # Protobuf
    protobuf
    grpcurl
    protoc-gen-go
    protoc-gen-connect-go
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
