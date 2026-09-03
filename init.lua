require("riu.core")
if vim.g.nix_managed then
  require("riu.nix")
else
  require("riu.lazy")
end

local function load_palette()
  local path = vim.fn.expand("~/.cache/matugen/nvim-palette.lua")
  local chunk, err = loadfile(path)
  if not chunk then
    return nil
  end
  local ok, palette = pcall(chunk)
  if not ok or type(palette) ~= "table" then
    return nil
  end
  return palette
end

local function apply_syntax_overrides(p)
  if not p then return end
  local nvim_set_hl = vim.api.nvim_set_hl
  local function hl(g, o) nvim_set_hl(0, g, o) end

  -- Preserve existing fg when forcing transparency
  local function merge_highlight(group, overrides)
    local cur = vim.api.nvim_get_hl(0, { name = group })
    local attrs = {}
    if cur.fg and cur.fg ~= false then attrs.fg = cur.fg end
    for _, attr in ipairs({"bold", "italic", "underline", "undercurl"}) do
      if cur[attr] then attrs[attr] = true end
    end
    for k, v in pairs(overrides) do
      attrs[k] = v
    end
    nvim_set_hl(0, group, attrs)
  end

  -- Transparency for UI groups
  local transparent_groups = {
    "Normal", "NormalNC", "NormalFloat",
    "FloatBorder", "SignColumn", "LineNr",
    "CursorLine", "CursorLineNr", "StatusLine",
  }
  for _, group in ipairs(transparent_groups) do
    merge_highlight(group, { bg = "none" })
  end

  -- Comment
  merge_highlight("Comment", { fg = p.outline, italic = true })

  -- Syntax: distinct hue overrides using harmonized custom colors
  hl("Constant",    { fg = p.yellow })
  hl("String",      { fg = p.green, italic = true })
  hl("Character",   { fg = p.green })
  hl("Number",      { fg = p.yellow })
  hl("Boolean",     { fg = p.yellow, bold = true })
  hl("Float",       { fg = p.yellow })
  hl("Identifier",  { fg = p.fg })
  hl("Function",    { fg = p.blue })
  hl("Statement",   { fg = p.red })
  hl("Conditional", { fg = p.red })
  hl("Repeat",      { fg = p.red })
  hl("Label",       { fg = p.red })
  hl("Operator",    { fg = p.cyan })
  hl("Keyword",     { fg = p.red, bold = true })
  hl("Exception",   { fg = p.magenta })
  hl("PreProc",     { fg = p.cyan })
  hl("Include",     { fg = p.cyan })
  hl("Define",      { fg = p.cyan })
  hl("Macro",       { fg = p.cyan })
  hl("PreCondit",   { fg = p.cyan })
  hl("Type",        { fg = p.yellow })
  hl("StorageClass", { fg = p.red })
  hl("Structure",   { fg = p.yellow })
  hl("Typedef",     { fg = p.yellow })
  hl("Special",     { fg = p.magenta })
  hl("SpecialChar", { fg = p.magenta })
  hl("Tag",         { fg = p.red })
  hl("Delimiter",   { fg = p.outline })
  hl("SpecialComment", { fg = p.outline, italic = true })
  hl("Debug",       { fg = p.magenta })
  hl("Error",       { fg = p.error })
  hl("Todo",        { fg = p.on_primary, bg = p.primary, bold = true })

  -- Treesitter @ groups
  hl("@comment",           { fg = p.outline, italic = true })
  hl("@comment.error",     { fg = p.magenta, italic = true })
  hl("@comment.warning",   { fg = p.yellow, italic = true })
  hl("@comment.todo",      { fg = p.on_primary, bg = p.primary, bold = true })
  hl("@comment.note",      { fg = p.on_primary_container, bg = p.primary_container, bold = true })

  hl("@string",            { fg = p.green, italic = true })
  hl("@string.regexp",     { fg = p.green })
  hl("@string.escape",     { fg = p.cyan, bold = true })
  hl("@string.special",    { fg = p.magenta })
  hl("@string.special.url", { fg = p.blue, underline = true })

  hl("@character",         { fg = p.green })
  hl("@character.special", { fg = p.cyan })

  hl("@boolean",           { fg = p.yellow, bold = true })
  hl("@number",            { fg = p.yellow })
  hl("@number.float",      { fg = p.yellow })

  hl("@variable",          { fg = p.fg })
  hl("@variable.builtin",  { fg = p.cyan, italic = true })
  hl("@variable.parameter", { fg = p.on_surface_variant })
  hl("@variable.parameter.builtin", { fg = p.cyan, italic = true })
  hl("@variable.member",   { fg = p.blue })

  hl("@constant",          { fg = p.yellow, bold = true })
  hl("@constant.builtin",  { fg = p.yellow, bold = true })
  hl("@constant.macro",    { fg = p.cyan, bold = true })

  hl("@module",            { fg = p.on_surface_variant })
  hl("@module.builtin",    { fg = p.cyan, italic = true })
  hl("@label",             { fg = p.red })

  hl("@function",          { fg = p.blue })
  hl("@function.builtin",  { fg = p.blue, italic = true })
  hl("@function.call",     { fg = p.blue })
  hl("@function.macro",    { fg = p.cyan, bold = true })
  hl("@function.method",   { fg = p.blue })
  hl("@function.method.call", { fg = p.blue })

  hl("@constructor",       { fg = p.cyan })
  hl("@operator",          { fg = p.cyan })

  hl("@keyword",           { fg = p.red, bold = true })
  hl("@keyword.coroutine", { fg = p.red, bold = true })
  hl("@keyword.function",  { fg = p.red, bold = true })
  hl("@keyword.operator",  { fg = p.cyan })
  hl("@keyword.import",    { fg = p.cyan })
  hl("@keyword.type",      { fg = p.yellow })
  hl("@keyword.modifier",  { fg = p.red })
  hl("@keyword.repeat",    { fg = p.red, bold = true })
  hl("@keyword.return",    { fg = p.red, bold = true })
  hl("@keyword.debug",     { fg = p.magenta })
  hl("@keyword.exception", { fg = p.magenta })
  hl("@keyword.conditional", { fg = p.red, bold = true })
  hl("@keyword.conditional.ternary", { fg = p.cyan })
  hl("@keyword.directive", { fg = p.cyan })
  hl("@keyword.directive.define", { fg = p.cyan })

  hl("@type",              { fg = p.yellow })
  hl("@type.builtin",      { fg = p.yellow, italic = true })
  hl("@type.definition",   { fg = p.yellow })

  hl("@attribute",         { fg = p.cyan })
  hl("@attribute.builtin", { fg = p.cyan, italic = true })
  hl("@property",          { fg = p.blue })

  hl("@punctuation.delimiter", { fg = p.outline })
  hl("@punctuation.bracket",   { fg = p.on_surface_variant })
  hl("@punctuation.special",   { fg = p.cyan })

  hl("@tag",               { fg = p.red })
  hl("@tag.builtin",       { fg = p.red, italic = true })
  hl("@tag.attribute",     { fg = p.blue })
  hl("@tag.delimiter",     { fg = p.outline })

  hl("@diff.plus",         { fg = p.green })
  hl("@diff.minus",        { fg = p.magenta })
  hl("@diff.delta",        { fg = p.yellow })

  hl("@markup.heading",    { fg = p.primary, bold = true })
  hl("@markup.strong",     { bold = true })
  hl("@markup.italic",     { italic = true })
  hl("@markup.link",       { fg = p.blue, underline = true })
  hl("@markup.list",       { fg = p.red })
  hl("@markup.quote",      { fg = p.outline, italic = true })
  hl("@markup.raw",        { fg = p.on_surface_variant })
end

local function apply_theme_tweaks()
  local p = load_palette()
  apply_syntax_overrides(p)
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_theme_tweaks,
})
