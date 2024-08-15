{
  description = "Rob's nix flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-search-github.url = "github:peterldowns/nix-search-cli";
    nix-search-github.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nix-search-github, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        robsPackages = with pkgs; [
          neovim
          curl
          sqlite-interactive
          ripgrep
          nodejs_latest
          fzf
          rlwrap
          fd
          ffmpeg
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
          direnv
          unzip
          cargo
          tmux
        ];
      in 
        { 
        packages.default = pkgs.buildEnv {
          name = "development-stuff";
          paths = robsPackages;
        };
      }
    );
}
