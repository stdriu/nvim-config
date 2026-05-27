{
  pkgs,
  inputs,
}:
with pkgs; [
  gnumake
  cmake

  git
  lazygit

  ripgrep
  fd
  fzf

  lua-language-server
  nil
  inputs.alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system}
  llvmPackages.clang-tools

  imagemagick

  texliveFull
  texliveBookPub

  trash-cli

  tree-sitter
  nodejs
]
