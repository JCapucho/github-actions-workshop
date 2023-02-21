{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.inputs.flake-utils.follows = "flake-utils";
  };
  outputs = {
    nixpkgs,
    flake-utils,
    rust-overlay,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [(import rust-overlay)];
        config.allowUnfree = true;
      };
      python-packages = p:
        with p; [
          pip
          pytest
          flake8
          virtualenv
        ];
    in {
      devShells.default = pkgs.mkShell {
        shellHook = ''
          clear

          export  PS1='\[\e[0;38;5;214m\][\[\e[0;38;5;214m\]CI/CD Glua\[\e[0;38;5;214m\]]\[\e[0m\] '

          alias code="code --user-data-dir vscode"

          export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
          alias act="act --bind --container-daemon-socket $XDG_RUNTIME_DIR/podman/podman.sock"
        '';
        buildInputs = with pkgs; [
          act

          jdk
          yq-go
          nodejs

          cargo-deny
          cargo-outdated
          cargo-audit
          rust-analyzer
          rust-bin.stable.latest.default

          (pkgs.python3.withPackages python-packages)

          (vscode-with-extensions.override {
            vscodeExtensions = with vscode-extensions;
              [
                ms-python.python
                redhat.vscode-yaml
                esbenp.prettier-vscode
              ]
              ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                  name = "vscode-hacker-typer";
                  publisher = "jevakallio";
                  version = "0.1.1";
                  sha256 = "sha256-MN1y+Q9ZQK+FloEqgUEMtQjrEV/HH1Tk1MzfznKKii0=";
                }
              ];
          })
        ];
      };
    });
}
