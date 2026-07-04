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

  pyright
  texlab
  typescript-language-server
  vscode-langservers-extracted

  imagemagick

  texliveFull
  texliveBookPub
  latexrun
  zathura

  trash-cli

  tree-sitter
  nodejs

  qt6.qtdeclarative
]
