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
          ripgrep
          fzf
          fd
          jq
          gnugrep
          units
          watchexec
          wget
          difftastic
          htop
          bat
          git
          shellcheck
          nix-search-github.packages.${system}.default
          direnv
          unzip
          cargo
          tmux
          powershell
          gcc
          fish
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
