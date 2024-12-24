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
    jdk21_headless
    go

    # Language Tools
    nodePackages.pnpm
    moon
    unstable.buf
    unstable.uv

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

  services.ollama.enable = true;
}
