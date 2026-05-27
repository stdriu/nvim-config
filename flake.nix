{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    telescope-themes = {
      url = "github:andrewberty/telescope-themes";
      flake = false;
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    telescope-themes,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      neovim-custom = pkgs.callPackage ./neovim.nix {
        inherit pkgs inputs;

        plugin_srcs = {
          telescope_themes = telescope-themes;
        };

        plugin_revs = {
          telescope_themes = telescope-themes.rev or null;
        };
      };

      default = self.packages.${system}.neovim-custom;
    };
  };
}
