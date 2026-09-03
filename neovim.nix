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
      cmp-buffer
      cmp-path
      cmp-nvim-lua
      luasnip
      friendly-snippets
      cord-nvim
      nvim-lspconfig
      cmp-nvim-lsp
      diffview-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      nvim-treesitter.withAllGrammars
      vimtex
      bufferline-nvim
      (pkgs.vimUtils.buildVimPlugin {
        pname = "vim-table-mode";
        version = "bb025308";
        src = pkgs.fetchFromGitHub {
          owner = "dhruvasagar";
          repo = "vim-table-mode";
          rev = "bb025308a45c67c7c8f0763ba37bc2ee3f534df0";
          sha256 = "0mkq8v8l9zbl2l12whzsnbz3fmg7ssqk4qb2syw8hxw1j9sb8wm0";
        };
      })
      snacks-nvim
      direnv-vim
      (pkgs.vimUtils.buildVimPlugin {
        pname = "matugen-nvim";
        version = "rev-08ab233808af9cc1055165b3221a7476354b15ee";
        src = pkgs.fetchFromGitHub {
          owner = "Senal-D-A-Gunaratna";
          repo = "matugen.nvim";
          rev = "08ab233808af9cc1055165b3221a7476354b15ee";
          sha256 = "03clibpw2s2ands0rl39s40d30445ja6n7a3p1mp4vlvfk6qhd1a";
        };
      })
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
