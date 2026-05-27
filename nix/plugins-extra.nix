{
  lib,
  vimUtils,
  plugin_srcs ? {},
  plugin_revs ? {},
}: let
  mk = name: src: rev:
    if src == null
    then null
    else
      vimUtils.buildVimPlugin {
        pname = name;
        version =
          if rev == null
          then null
          else "rev-" + rev;
        src = src;

        doCheck = false;
      };

  telescope_themes =
    mk "telescope-themes"
    (plugin_srcs.telescope_themes or null)
    (plugin_revs.telescope_themes or null);
in
  lib.filter (x: x != null) [
    telescope_themes
  ]
