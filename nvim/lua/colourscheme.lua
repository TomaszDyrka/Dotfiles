local colors = {
  base00 = "#1b1918",
  base01 = "#2c2421",
  base02 = "#68615e",
  base03 = "#766e6b",
  base04 = "#383332",
  base05 = "#a8a19f",
  base06 = "#e6e2e0",
  base07 = "#f1efee",
  base08 = "#f22c40",
  base09 = "#df5320",
  base0A = "#c38418",
  base0B = "#7b9726",
  base0C = "#3d97b8",
  base0D = "#407ee7",
  base0E = "#6666ea",
  base0F = "#c33ff3",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

vim.cmd "highlight clear"
vim.g.colors_name = "Atelier_ForestDark"

hl("Normal", { fg = colors.base05, bg = colors.base00 })
hl("Comment", { fg = colors.base03, italic = true })
hl("Constant", { fg = colors.base09 })
hl("String", { fg = colors.base0B })
hl("Function", { fg = colors.base0D })
hl("Keyword", { fg = colors.base0E })
hl("Type", { fg = colors.base0A })
hl("Statement", { fg = colors.base08 })
hl("CursorLine", { bg = colors.base01 })
hl("CursorLineNr", { fg = colors.base04 })
hl("LineNr", { fg = colors.base02 })
hl("Visual", { bg = colors.base02 })
hl("Error", { fg = colors.base00, bg = colors.base08 })
hl("WarningMsg", { fg = colors.base08 })
hl("Search", { fg = colors.base06, bg = colors.base0A })
hl("PMenu", { fg = colors.base04, bg = colors.base01 })
hl("PMenuSel", { fg = colors.base01, bg = colors.base04 })
hl("StatusLine", { fg = colors.base04, bg = colors.base02 })
hl("StatusLineNC", { fg = colors.base03, bg = colors.base01 })
hl("VertSplit", { fg = colors.base00, bg = colors.base00 })
hl("DiffAdd", { fg = colors.base0B, bg = colors.base01 })
hl("DiffDelete", { fg = colors.base08, bg = colors.base01 })
hl("DiffChange", { fg = colors.base03, bg = colors.base01 })
hl("DiffText", { fg = colors.base0D, bg = colors.base01 })

