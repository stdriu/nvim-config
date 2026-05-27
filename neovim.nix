{
  symlinkJoin,
  neovim-unwrapped,
  makeWrapper,
  vimPlugins,
  runCommand,
  lib,
  pkgs,
  inputs ? null,
  plugin_srcs ? {},
  plugin_revs ? {},
}: let
  extraPlugins = import ./nix/plugins-extra.nix {
    inherit lib;
    vimUtils = pkgs.vimUtils;
    plugin_srcs = plugin_srcs;
    plugin_revs = plugin_revs;
  };

  plugins = with vimPlugins;
    [
      lualine-nvim
      base16-nvim
      indent-blankline-nvim
      auto-session
      which-key-nvim
      nvim-autopairs
      oil-nvim
      snacks-nvim
      todo-comments-nvim
      plenary-nvim
      nvim-web-devicons
      nvim-cmp
      cord-nvim
      nvim-lspconfig
      cmp-nvim-lsp
      telescope-fzf-native-nvim
      telescope-nvim
      nvim-treesitter.withAllGrammars
      vimtex
      snacks-nvim
    ]
    ++ extraPlugins;

  allPlugins = lib.unique (
    let
      collectDeps = plugin: [plugin] ++ (lib.concatMap collectDeps (plugin.dependencies or []));
    in
      lib.concatMap collectDeps plugins
  );

  extraPackages = import ./nix/bin.nix {inherit pkgs inputs;};

  packpath = runCommand "nvim-packpath" {} ''
    mkdir -p $out/pack/nix/start
    ${lib.concatMapStringsSep "\n" (
        plugin: "ln -sf ${plugin} $out/pack/nix/start/${lib.getName plugin}"
      )
      allPlugins}
  '';
in
  symlinkJoin {
    name = "neovim-custom";
    paths = [neovim-unwrapped];
    nativeBuildInputs = [makeWrapper];

    propagatedBuildInputs = extraPackages;

    postBuild = ''
      wrapProgram $out/bin/nvim \
        --prefix PATH : ${lib.makeBinPath extraPackages} \
        --add-flags '--cmd "lua vim.opt.packpath:prepend(\"${packpath}\")"' \
        --add-flags '--cmd "lua vim.opt.rtp:prepend(\"${packpath}\")"' \
        --add-flags '--cmd "lua vim.opt.rtp:prepend(\"${./.}\")"' \
        --add-flags '--cmd "lua vim.g.nix_managed = true"' \
        --add-flags '-u "${./init.lua}"'
    '';

    passthru = {
      inherit packpath;
      unwrapped = neovim-unwrapped;
    };
  }
