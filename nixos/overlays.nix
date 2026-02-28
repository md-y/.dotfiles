{ inputs }:

[
  (import inputs.rust-overlay)

  (final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  })
]
