require("riu.core")
if vim.g.nix_managed then
  require("riu.nix")
else
  require("riu.lazy")
end
