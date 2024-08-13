{
  description = "Rob's nix flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-search-github.url = "github:peterldowns/nix-search-cli";
    nix-search-github.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { nix-search-github, nixpkgs, flake-utils, nixgl, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        robsPackages = with pkgs; [
          neovim
          curl
          sqlite-interactive
          ripgrep
          kitty
          nodejs_latest
          fzf
          rlwrap
          fd
          ffmpeg
          cloudflared
          sqlite-analyzer
          clojure
          jq
          gnugrep
          units
          luajit_openresty
          nmap
          wrk
          watchexec
          wget
          difftastic
          pandoc
          openssh
          imagemagick
          htop
          bat
          babashka
          rsync
          go_1_22
          gh
          git
          shellcheck
          nix-search-github.packages.${system}.default
          python3Full
          gcc
          gnupg
          devbox
          direnv
          ruff-lsp
          restic
          pure-prompt
          keepassxc
          unzip
        ];
        other = 
          if system == "x86_64-linux" then
            with pkgs; [
              #firefox
              #chromium
              #nixgl.packages.${system}.default
              #wmenu
              #wdisplays
              #wl-clipboard
              #coreutils
            ]
          else if system == "aarch64-darwin" then 
            with pkgs; [
              uutils-coreutils-noprefix
              rectangle
              pinentry_mac
              colima
              docker
              textliveFull
            ]
          else [];
      in 
        { 
        packages.default = pkgs.buildEnv {
          name = "development-stuff";
          paths = robsPackages ++ other;
        };
      }
    );
}
