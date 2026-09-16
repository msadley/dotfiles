-- Rendered by caelestia to ~/.local/state/caelestia/theme/nvim.lua
-- Loaded from ~/.config/nvim/lua/plugins/colorscheme.lua
if vim.g.colors_name then
  vim.cmd("highlight clear")
end
vim.g.colors_name = "caelestia"

local c = {
  fg = "#{{ onSurface.hex }}",
  bg = "#{{ surface.hex }}",
  muted = "#{{ subtext0.hex }}",
  comment = "#{{ overlay0.hex }}",
  faint = "#{{ surfaceVariant.hex }}",
  line = "#{{ surfaceContainerHigh.hex }}",
  panel = "#{{ surfaceContainerLow.hex }}",
  sel = "#{{ secondary.hex }}",
  on_sel = "#{{ onSecondary.hex }}",
  primary = "#{{ primary.hex }}",
  on_primary = "#{{ onPrimary.hex }}",
  primary_c = "#{{ primaryContainer.hex }}",
  on_primary_c = "#{{ onPrimaryContainer.hex }}",
  red = "#{{ red.hex }}",
  green = "#{{ green.hex }}",
  yellow = "#{{ yellow.hex }}",
  blue = "#{{ blue.hex }}",
  magenta = "#{{ mauve.hex }}",
  cyan = "#{{ teal.hex }}",
  orange = "#{{ peach.hex }}",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link(name, target)
  vim.api.nvim_set_hl(0, name, { link = target })
end

hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalNC", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.panel })
hl("FloatBorder", { fg = c.faint, bg = c.panel })
hl("FloatTitle", { fg = c.primary, bg = c.panel, bold = true })
hl("EndOfBuffer", { fg = c.bg })

hl("ColorColumn", { bg = c.line })
hl("Conceal", { fg = c.muted })
hl("Cursor", { bg = c.sel, fg = c.on_sel })
link("CursorIM", "Cursor")
hl("CursorLine", { bg = c.line })
link("CursorColumn", "CursorLine")
hl("LineNr", { fg = c.comment })
hl("CursorLineNr", { fg = c.primary, bold = true })
link("CursorLineFold", "FoldColumn")
link("CursorLineSign", "SignColumn")
hl("SignColumn", { bg = c.bg })
hl("VertSplit", { fg = c.faint })
link("WinSeparator", "VertSplit")
hl("Folded", { fg = c.muted, bg = c.panel })
hl("FoldColumn", { fg = c.comment })
hl("Visual", { bg = c.sel, fg = c.on_sel })
link("VisualNOS", "Visual")
hl("Search", { bg = c.primary_c, fg = c.on_primary_c })
hl("IncSearch", { bg = c.orange, fg = c.bg })
link("CurSearch", "IncSearch")
hl("Substitute", { bg = c.faint, fg = c.fg })
hl("MatchParen", { fg = c.yellow, bold = true, underline = true })
hl("Whitespace", { fg = c.faint })
hl("NonText", { fg = c.faint })
hl("SpecialKey", { fg = c.faint })
hl("Directory", { fg = c.blue })
hl("Title", { fg = c.primary, bold = true })
hl("ErrorMsg", { fg = c.red, bold = true })
hl("WarningMsg", { fg = c.yellow, bold = true })
hl("MoreMsg", { fg = c.green })
hl("ModeMsg", { fg = c.muted })
hl("Question", { fg = c.green })
hl("QuickFixLine", { bg = c.line })
hl("SpellBad", { fg = c.red, undercurl = true })
hl("SpellCap", { fg = c.blue, undercurl = true })
hl("SpellRare", { fg = c.magenta, undercurl = true })
hl("SpellLocal", { fg = c.cyan, undercurl = true })

hl("Pmenu", { fg = c.fg, bg = c.panel })
hl("PmenuSel", { bg = c.line, bold = true })
link("PmenuKind", "Pmenu")
link("PmenuKindSel", "PmenuSel")
link("PmenuExtra", "Pmenu")
link("PmenuExtraSel", "PmenuSel")
hl("PmenuSbar", { bg = c.panel })
hl("PmenuThumb", { bg = c.faint })
hl("PmenuMatch", { fg = c.primary, bg = c.panel, bold = true })
hl("PmenuMatchSel", { fg = c.primary, bg = c.line, bold = true })

hl("StatusLine", { fg = c.fg, bg = c.panel })
hl("StatusLineNC", { fg = c.muted, bg = c.panel })
link("WinBar", "StatusLine")
link("WinBarNC", "StatusLineNC")
link("TabLine", "StatusLineNC")
hl("TabLineSel", { fg = c.primary, bg = c.line, bold = true })
link("TabLineFill", "StatusLine")

hl("Comment", { fg = c.comment, italic = true })

hl("Constant", { fg = c.orange })
link("String", "Constant")
link("Character", "Constant")
link("Number", "Constant")
link("Boolean", "Constant")
link("Float", "Constant")

hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.blue })

hl("Statement", { fg = c.magenta })
link("Conditional", "Statement")
link("Repeat", "Statement")
link("Label", "Statement")
link("Operator", "Statement")
link("Keyword", "Statement")
link("Exception", "Statement")

hl("PreProc", { fg = c.cyan })
link("Include", "PreProc")
link("Define", "PreProc")
link("Macro", "PreProc")
link("PreCondit", "PreProc")

hl("Type", { fg = c.yellow })
link("StorageClass", "Type")
link("Structure", "Type")
link("Typedef", "Type")

hl("Special", { fg = c.cyan })
link("SpecialChar", "Special")
link("Tag", "Special")
link("Delimiter", "Special")
link("SpecialComment", "Special")
link("Debug", "Special")

hl("Underlined", { underline = true })
hl("Bold", { bold = true })
hl("Italic", { italic = true })
hl("Ignore", { fg = c.comment })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.primary, bg = c.panel, bold = true })

hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.blue })
hl("DiagnosticHint", { fg = c.cyan })
link("DiagnosticUnnecessary", "Comment")
link("DiagnosticVirtualTextError", "DiagnosticError")
link("DiagnosticVirtualTextWarn", "DiagnosticWarn")
link("DiagnosticVirtualTextInfo", "DiagnosticInfo")
link("DiagnosticVirtualTextHint", "DiagnosticHint")
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.cyan })

link("LspReferenceText", "CursorLine")
link("LspReferenceRead", "CursorLine")
link("LspReferenceWrite", "CursorLine")
link("LspSignatureActiveParameter", "Visual")
hl("LspInlayHint", { fg = c.comment, italic = true })
link("LspCodeLens", "LspInlayHint")

hl("DiffAdd", { fg = c.green, bg = c.panel })
hl("DiffChange", { fg = c.yellow, bg = c.panel })
hl("DiffDelete", { fg = c.red, bg = c.panel })
hl("DiffText", { fg = c.bg, bg = c.yellow })
link("Added", "DiffAdd")
link("Changed", "DiffChange")
link("Removed", "DiffDelete")

link("GitGutterAdd", "DiffAdd")
link("GitGutterChange", "DiffChange")
link("GitGutterDelete", "DiffDelete")
link("GitSignsAdd", "DiffAdd")
link("GitSignsChange", "DiffChange")
link("GitSignsDelete", "DiffDelete")

local ts = {
  ["@comment"] = "Comment",
  ["@markup.heading"] = "Title",
  ["@markup.link"] = "Directory",
  ["@markup.list"] = "Special",
  ["@markup.raw"] = "String",
  ["@markup.italic"] = "Italic",
  ["@markup.bold"] = "Bold",
  ["@constant"] = "Constant",
  ["@constant.builtin"] = "Special",
  ["@string.escape"] = "Special",
  ["@number"] = "Number",
  ["@boolean"] = "Boolean",
  ["@float"] = "Float",
  ["@function"] = "Function",
  ["@function.builtin"] = "Special",
  ["@function.call"] = "Function",
  ["@method"] = "Function",
  ["@constructor"] = "Type",
  ["@keyword"] = "Keyword",
  ["@keyword.operator"] = "Operator",
  ["@label"] = "Label",
  ["@operator"] = "Operator",
  ["@parameter"] = "Identifier",
  ["@property"] = "Identifier",
  ["@punctuation.bracket"] = "Delimiter",
  ["@punctuation.delimiter"] = "Delimiter",
  ["@punctuation.special"] = "Special",
  ["@type"] = "Type",
  ["@type.builtin"] = "Type",
  ["@variable"] = "Identifier",
  ["@variable.builtin"] = "Special",
}
for from, to in pairs(ts) do
  link(from, to)
end

link("@attribute", "PreProc")
link("Attribute", "@attribute")

for i, colour in ipairs({
  "#{{ term0.hex }}",
  "#{{ term1.hex }}",
  "#{{ term2.hex }}",
  "#{{ term3.hex }}",
  "#{{ term4.hex }}",
  "#{{ term5.hex }}",
  "#{{ term6.hex }}",
  "#{{ term7.hex }}",
  "#{{ term8.hex }}",
  "#{{ term9.hex }}",
  "#{{ term10.hex }}",
  "#{{ term11.hex }}",
  "#{{ term12.hex }}",
  "#{{ term13.hex }}",
  "#{{ term14.hex }}",
  "#{{ term15.hex }}",
}) do
  vim.g["terminal_color_" .. (i - 1)] = colour
end
