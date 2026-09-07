{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      neovim-custom = pkgs.callPackage ./neovim.nix {
        inherit pkgs inputs;
      };

      default = self.packages.${system}.neovim-custom;
    };
  };
}
