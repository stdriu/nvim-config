local palette = require("riu.core.palette")

local M = {}

-- Highlight definitions, grouped by integration. Each group references
-- SEMANTIC color names (see riu.core.palette), plus optional fg/bg/sp.
-- This is the base46-style mapping table: the single source of truth for
-- how the theme colors every part of the UI.
M.definitions = {
  ui = {
    Normal = { fg = "fg", bg = "bg" },
    NormalNC = { fg = "fg", bg = "bg" },
    NormalFloat = { fg = "fg", bg = "bg_float" },
    FloatBorder = { fg = "grey", bg = "bg_float" },
    FloatTitle = { fg = "primary", bg = "bg_float" },
    SignColumn = { fg = "grey", bg = "bg" },
    LineNr = { fg = "grey", bg = "bg" },
    CursorLineNr = { fg = "primary" },
    CursorLine = { bg = "bg_hover" },
    CursorColumn = { bg = "bg_hover" },
    StatusLine = { fg = "fg", bg = "bg_alt" },
    StatusLineNC = { fg = "fg_dim", bg = "bg_alt" },
    WinSeparator = { fg = "line" },
    Pmenu = { fg = "fg", bg = "bg_popup" },
    PmenuSel = { fg = "on_primary", bg = "primary" },
    PmenuSbar = { bg = "bg_popup" },
    PmenuThumb = { bg = "grey" },
    Visual = { bg = "selection" },
    Search = { fg = "on_primary", bg = "primary" },
    CurSearch = { fg = "bg", bg = "primary" },
    MatchParen = { fg = "primary", bold = true },
    IncSearch = { fg = "bg", bg = "primary" },
    Substitute = { fg = "on_primary", bg = "primary" },
    ErrorMsg = { fg = "error" },
    WarningMsg = { fg = "warning" },
    MoreMsg = { fg = "primary" },
    InfoMsg = { fg = "info" },
    Question = { fg = "primary" },
    Title = { fg = "primary", bold = true },
    Directory = { fg = "blue" },
    SpecialKey = { fg = "cyan" },
    NonText = { fg = "grey" },
    Whitespace = { fg = "line" },
    EndOfBuffer = { fg = "bg" },
    TabLine = { fg = "fg_dim", bg = "bg_alt" },
    TabLineSel = { fg = "fg", bg = "bg_popup", bold = true },
    TabLineFill = { bg = "bg" },
    Folded = { fg = "fg_dim", bg = "bg_alt" },
    FoldColumn = { fg = "grey", bg = "bg" },
    Conceal = { fg = "grey" },
    CursorColumn = { bg = "bg_hover" },
    ColorColumn = { bg = "bg_alt" },
    QuickFixLine = { fg = "on_primary", bg = "primary" },
    DiagnosticError = { fg = "error" },
    DiagnosticWarn = { fg = "warning" },
    DiagnosticInfo = { fg = "info" },
    DiagnosticHint = { fg = "hint" },
    DiagnosticOk = { fg = "ok" },
    DiagnosticUnderlineError = { undercurl = true, sp = "error" },
    DiagnosticUnderlineWarn = { undercurl = true, sp = "warning" },
    DiagnosticUnderlineInfo = { undercurl = true, sp = "info" },
    DiagnosticUnderlineHint = { undercurl = true, sp = "hint" },
    LspReferenceText = { bg = "selection" },
    LspReferenceRead = { bg = "selection" },
    LspReferenceWrite = { bg = "selection" },
    LspSignatureActiveParameter = { fg = "primary", bold = true },
    IncSearch = { fg = "bg", bg = "primary" },
  },
  syntax = {
    Comment = { fg = "grey", italic = true },
    Constant = { fg = "yellow" },
    String = { fg = "green", italic = true },
    Character = { fg = "green" },
    Number = { fg = "yellow" },
    Boolean = { fg = "yellow", bold = true },
    Float = { fg = "yellow" },
    Identifier = { fg = "fg" },
    Function = { fg = "blue" },
    Statement = { fg = "red" },
    Conditional = { fg = "red" },
    Repeat = { fg = "red" },
    Label = { fg = "red" },
    Operator = { fg = "cyan" },
    Keyword = { fg = "red", bold = true },
    Exception = { fg = "magenta" },
    PreProc = { fg = "cyan" },
    Include = { fg = "cyan" },
    Define = { fg = "cyan" },
    Macro = { fg = "cyan" },
    PreCondit = { fg = "cyan" },
    Type = { fg = "yellow" },
    StorageClass = { fg = "red" },
    Structure = { fg = "yellow" },
    Typedef = { fg = "yellow" },
    Special = { fg = "magenta" },
    SpecialChar = { fg = "magenta" },
    Tag = { fg = "red" },
    Delimiter = { fg = "grey" },
    SpecialComment = { fg = "grey", italic = true },
    Debug = { fg = "magenta" },
    Error = { fg = "error" },
    Todo = { fg = "on_primary", bg = "primary", bold = true },
  },
  treesitter = {
    ["@comment"] = { fg = "grey", italic = true },
    ["@comment.error"] = { fg = "magenta", italic = true },
    ["@comment.warning"] = { fg = "yellow", italic = true },
    ["@comment.todo"] = { fg = "on_primary", bg = "primary", bold = true },
    ["@comment.note"] = { fg = "on_primary_container", bg = "primary_container", bold = true },
    ["@string"] = { fg = "green", italic = true },
    ["@string.regexp"] = { fg = "green" },
    ["@string.escape"] = { fg = "cyan", bold = true },
    ["@string.special"] = { fg = "magenta" },
    ["@string.special.url"] = { fg = "blue", underline = true },
    ["@character"] = { fg = "green" },
    ["@character.special"] = { fg = "cyan" },
    ["@boolean"] = { fg = "yellow", bold = true },
    ["@number"] = { fg = "yellow" },
    ["@number.float"] = { fg = "yellow" },
    ["@variable"] = { fg = "fg" },
    ["@variable.builtin"] = { fg = "cyan", italic = true },
    ["@variable.parameter"] = { fg = "fg_alt" },
    ["@variable.parameter.builtin"] = { fg = "cyan", italic = true },
    ["@variable.member"] = { fg = "blue" },
    ["@constant"] = { fg = "yellow", bold = true },
    ["@constant.builtin"] = { fg = "yellow", bold = true },
    ["@constant.macro"] = { fg = "cyan", bold = true },
    ["@module"] = { fg = "fg_alt" },
    ["@module.builtin"] = { fg = "cyan", italic = true },
    ["@label"] = { fg = "red" },
    ["@function"] = { fg = "blue" },
    ["@function.builtin"] = { fg = "blue", italic = true },
    ["@function.call"] = { fg = "blue" },
    ["@function.macro"] = { fg = "cyan", bold = true },
    ["@function.method"] = { fg = "blue" },
    ["@function.method.call"] = { fg = "blue" },
    ["@constructor"] = { fg = "cyan" },
    ["@operator"] = { fg = "cyan" },
    ["@keyword"] = { fg = "red", bold = true },
    ["@keyword.coroutine"] = { fg = "red", bold = true },
    ["@keyword.function"] = { fg = "red", bold = true },
    ["@keyword.operator"] = { fg = "cyan" },
    ["@keyword.import"] = { fg = "cyan" },
    ["@keyword.type"] = { fg = "yellow" },
    ["@keyword.modifier"] = { fg = "red" },
    ["@keyword.repeat"] = { fg = "red", bold = true },
    ["@keyword.return"] = { fg = "red", bold = true },
    ["@keyword.debug"] = { fg = "magenta" },
    ["@keyword.exception"] = { fg = "magenta" },
    ["@keyword.conditional"] = { fg = "red", bold = true },
    ["@keyword.conditional.ternary"] = { fg = "cyan" },
    ["@keyword.directive"] = { fg = "cyan" },
    ["@keyword.directive.define"] = { fg = "cyan" },
    ["@type"] = { fg = "yellow" },
    ["@type.builtin"] = { fg = "yellow", italic = true },
    ["@type.definition"] = { fg = "yellow" },
    ["@attribute"] = { fg = "cyan" },
    ["@attribute.builtin"] = { fg = "cyan", italic = true },
    ["@property"] = { fg = "blue" },
    ["@punctuation.delimiter"] = { fg = "grey" },
    ["@punctuation.bracket"] = { fg = "fg_alt" },
    ["@punctuation.special"] = { fg = "cyan" },
    ["@tag"] = { fg = "red" },
    ["@tag.builtin"] = { fg = "red", italic = true },
    ["@tag.attribute"] = { fg = "blue" },
    ["@tag.delimiter"] = { fg = "grey" },
    ["@diff.plus"] = { fg = "green" },
    ["@diff.minus"] = { fg = "magenta" },
    ["@diff.delta"] = { fg = "yellow" },
    ["@markup.heading"] = { fg = "primary", bold = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.link"] = { fg = "blue", underline = true },
    ["@markup.list"] = { fg = "red" },
    ["@markup.quote"] = { fg = "grey", italic = true },
    ["@markup.raw"] = { fg = "fg_alt" },
  },
  plugins = {
    BufferLineFill = { bg = "bg" },
    BufferLineBackground = { fg = "fg_dim", bg = "bg" },
    BufferLineBuffer = { fg = "fg_dim", bg = "bg" },
    BufferLineBufferSelected = { fg = "fg", bg = "bg_alt", bold = true },
    BufferLineBufferVisible = { fg = "fg_alt", bg = "bg" },
    BufferLineModified = { fg = "yellow" },
    BufferLineModifiedSelected = { fg = "yellow" },
    BufferLineModifiedVisible = { fg = "yellow" },
    BufferLineCloseButton = { fg = "grey" },
    BufferLineCloseButtonSelected = { fg = "error" },
    BufferLineIndicatorSelected = { fg = "primary" },
    BufferLineError = { fg = "error" },
    BufferLineErrorSelected = { fg = "error" },
    BufferLineWarning = { fg = "warning" },
    BufferLineWarningSelected = { fg = "warning" },
    BufferLineInfo = { fg = "info" },
    BufferLineInfoSelected = { fg = "info" },

    LualineNormal = { fg = "fg", bg = "bg_alt" },
    LualineInsert = { fg = "bg", bg = "green" },
    LualineVisual = { fg = "bg", bg = "magenta" },
    LualineReplace = { fg = "bg", bg = "red" },
    LualineCommand = { fg = "bg", bg = "primary" },
    LualineInactive = { fg = "fg_dim", bg = "bg" },
    LualineError = { fg = "error" },
    LualineWarning = { fg = "warning" },
    LualineInfo = { fg = "info" },

    CmpItemAbbr = { fg = "fg" },
    CmpItemAbbrMatch = { fg = "primary", bold = true },
    CmpItemAbbrMatchFuzzy = { fg = "primary" },
    CmpItemMenu = { fg = "fg_dim" },
    CmpItemKind = { fg = "magenta" },
    CmpItemKindText = { fg = "green" },
    CmpItemKindMethod = { fg = "blue" },
    CmpItemKindFunction = { fg = "blue" },
    CmpItemKindConstructor = { fg = "cyan" },
    CmpItemKindField = { fg = "yellow" },
    CmpItemKindVariable = { fg = "fg" },
    CmpItemKindClass = { fg = "cyan" },
    CmpItemKindInterface = { fg = "cyan" },
    CmpItemKindModule = { fg = "blue" },
    CmpItemKindProperty = { fg = "yellow" },
    CmpItemKindUnit = { fg = "yellow" },
    CmpItemKindValue = { fg = "yellow" },
    CmpItemKindEnum = { fg = "cyan" },
    CmpItemKindKeyword = { fg = "red" },
    CmpItemKindSnippet = { fg = "magenta" },
    CmpItemKindColor = { fg = "magenta" },
    CmpItemKindFile = { fg = "primary" },
    CmpItemKindReference = { fg = "magenta" },
    CmpItemKindFolder = { fg = "primary" },
    CmpItemKindEvent = { fg = "yellow" },
    CmpItemKindOperator = { fg = "cyan" },
    CmpItemKindTypeParameter = { fg = "cyan" },

    GitSignsAdd = { fg = "green" },
    GitSignsChange = { fg = "yellow" },
    GitSignsDelete = { fg = "magenta" },
    GitSignsChangedelete = { fg = "yellow" },
    GitSignsUntracked = { fg = "green" },

    GitSignsAddLn = { bg = "green", fg = "bg" },
    GitSignsChangeLn = { bg = "yellow", fg = "bg" },
    GitSignsDeleteLn = { bg = "magenta", fg = "bg" },

    WhichKey = { fg = "primary" },
    WhichKeyGroup = { fg = "cyan" },
    WhichKeySeparator = { fg = "grey" },
    WhichKeyDesc = { fg = "fg" },
    WhichKeyFloat = { bg = "bg_float" },

    TelescopePromptBorder = { fg = "grey", bg = "bg_float" },
    TelescopePromptTitle = { fg = "on_primary", bg = "primary" },
    TelescopeResultsTitle = { fg = "on_primary", bg = "primary" },
    TelescopePreviewTitle = { fg = "on_primary", bg = "primary" },
    TelescopeSelection = { bg = "selection" },
    TelescopeMatching = { fg = "primary" },

    SnacksPickerBorder = { fg = "primary" },
    SnacksPickerTitle = { fg = "on_primary", bg = "primary" },
    SnacksPickerInput = { fg = "fg", bg = "bg_float" },
    SnacksPickerSelection = { bg = "selection" },
    SnacksNormal = { fg = "fg", bg = "bg" },

    SnacksDashboardHeader = { fg = "primary" },
    SnacksDashboardTitle = { fg = "primary", bold = true },
    SnacksDashboardDesc = { fg = "fg_alt" },
    SnacksDashboardKey = { fg = "cyan" },
    SnacksDashboardIcon = { fg = "magenta" },

    NavicText = { fg = "fg_alt" },
    NavicSeparator = { fg = "grey" },
    NavicIconsFile = { fg = "primary" },
    NavicIconsModule = { fg = "primary" },
    NavicIconsNamespace = { fg = "primary" },
    NavicIconsPackage = { fg = "primary" },
    NavicIconsClass = { fg = "cyan" },
    NavicIconsMethod = { fg = "blue" },
    NavicIconsProperty = { fg = "yellow" },
    NavicIconsField = { fg = "yellow" },
    NavicIconsConstructor = { fg = "cyan" },
    NavicIconsEnum = { fg = "cyan" },
    NavicIconsInterface = { fg = "cyan" },
    NavicIconsFunction = { fg = "blue" },
    NavicIconsVariable = { fg = "fg" },
    NavicIconsConstant = { fg = "yellow" },
    NavicIconsString = { fg = "green" },
    NavicIconsNumber = { fg = "yellow" },
    NavicIconsBoolean = { fg = "yellow" },
    NavicIconsArray = { fg = "cyan" },
    NavicIconsObject = { fg = "cyan" },
    NavicIconsKey = { fg = "red" },
    NavicIconsNull = { fg = "magenta" },
    NavicIconsEnumMember = { fg = "cyan" },
    NavicIconsStruct = { fg = "yellow" },
    NavicIconsEvent = { fg = "yellow" },
    NavicIconsOperator = { fg = "cyan" },
    NavicIconsTypeParameter = { fg = "cyan" },
    NavicIconsType = { fg = "yellow" },
    NavicIconsKeyword = { fg = "red" },
    NavicIconsBranch = { fg = "magenta" },
    NavicIconsLabel = { fg = "red" },
    NavicIconsFolder = { fg = "primary" },
    NavicIconsFunction = { fg = "blue" },

    NvimTreeNormal = { fg = "fg", bg = "bg" },
    NvimTreeNormalNC = { fg = "fg", bg = "bg" },
    NvimTreeEndOfBuffer = { fg = "bg", bg = "bg" },
    NvimTreeRootFolder = { fg = "primary", bold = true },
    NvimTreeFolderIcon = { fg = "blue" },
    NvimTreeFolderName = { fg = "blue" },
    NvimTreeOpenedFolderName = { fg = "primary", bold = true },
    NvimTreeEmptyFolderName = { fg = "fg_alt" },
    NvimTreeFileIcon = { fg = "fg" },
    NvimTreeFileName = { fg = "fg" },
    NvimTreeIndentMarker = { fg = "line" },
    NvimTreeSymlink = { fg = "cyan" },
    NvimTreeGitDirty = { fg = "yellow" },
    NvimTreeGitStaged = { fg = "primary" },
    NvimTreeGitMerge = { fg = "magenta" },
    NvimTreeGitRenamed = { fg = "magenta" },
    NvimTreeGitDeleted = { fg = "error" },
    NvimTreeGitUntracked = { fg = "magenta" },
    NvimTreeLiveFilter = { fg = "primary" },
    NvimTreeCursorLine = { bg = "selection" },
    NvimTreeWindowPicker = { fg = "on_primary", bg = "primary" },
    NvimTreeOperational = { fg = "cyan" },
    NvimTreeIdentifier = { fg = "magenta" },

    DiffviewNormal = { fg = "fg", bg = "bg" },
    DiffviewFilePanelTitle = { fg = "primary", bold = true },
    DiffviewFilePanelFileName = { fg = "fg" },
    DiffviewFilePanelCounter = { fg = "fg_alt" },
    DiffviewStatusAdded = { fg = "green" },
    DiffviewStatusModified = { fg = "yellow" },
    DiffviewStatusDeleted = { fg = "magenta" },

    IndentBlanklineChar = { fg = "line" },
    IndentBlanklineContextChar = { fg = "primary" },
    IblIndent = { fg = "line" },
    IblScope = { fg = "primary" },

    TodoFgFIX = { fg = "error" },
    TodoFgTODO = { fg = "info" },
    TodoFgHACK = { fg = "warning" },
    TodoFgWARN = { fg = "warning" },
    TodoFgPERF = { fg = "yellow" },
    TodoFgNOTE = { fg = "hint" },
    TodoBgFIX = { bg = "bg_alt", fg = "error" },
    TodoBgTODO = { bg = "bg_alt", fg = "info" },
  },
}

-- Groups that get a transparent background. Keeps their fg/attrs; removes bg.
M.transparent_groups = {
  "Normal", "NormalNC", "NormalFloat", "FloatBorder",
  "SignColumn", "LineNr", "CursorLine", "CursorLineNr",
  "StatusLine", "StatusLineNC", "TabLine", "TabLineSel", "TabLineFill",
  "BufferLineFill", "BufferLineBackground", "BufferLineBuffer",
  "BufferLineBufferVisible", "BufferLineBufferSelected",
  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
  "NavicText",
}

-- Resolve semantic color names -> hex, exactly like base46's turn_str_to_color.
local function resolve(pal, def)
  for k, v in pairs(def) do
    if (k == "fg" or k == "bg" or k == "sp")
      and type(v) == "string"
      and v ~= "none" and v ~= "NONE"
      and v:sub(1, 1) ~= "#"
    then
      def[k] = pal[v] or def[k]
    end
  end
  return def
end

-- Set a single highlight group, merging with the current one for
-- transparency (preserve existing fg/attrs when clearing bg).
local function merge_set(group, attrs)
  local cur = vim.api.nvim_get_hl(0, { name = group })
  local merged = {}
  for _, a in ipairs({ "fg", "sp", "bold", "italic", "underline", "undercurl", "strikethrough" }) do
    if cur[a] and cur[a] ~= false then merged[a] = cur[a] end
  end
  for k, v in pairs(attrs) do merged[k] = v end
  vim.api.nvim_set_hl(0, group, merged)
end

local function apply_group(group, attrs, transparent)
  if transparent then
    attrs.bg = "none"
    merge_set(group, attrs)
  else
    vim.api.nvim_set_hl(0, group, attrs)
  end
end

--- Apply all highlight definitions against the current palette.
function M.apply()
  local pal = palette.get()
  if not pal then return end

  for _, section in pairs(M.definitions) do
    for group, def in pairs(section) do
      local resolved = resolve(pal, vim.deepcopy(def))
      apply_group(group, resolved, M.transparent_groups[group] ~= nil)
    end
  end
end

--- Re-read the palette and reapply all highlights.
function M.reload()
  palette.reload()
  M.apply()
end

local augroup = vim.api.nvim_create_augroup("RiuHighlight", { clear = false })

-- Apply after startup so plugins (treesitter, matugen, ...) have registered
-- their highlight groups first.
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  once = true,
  callback = function()
    vim.schedule(M.apply)
  end,
})

-- Re-read the palette on theme changes (color scheme switch / re-source).
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  pattern = "*",
  callback = M.reload,
})

return M
