-- Włącz numerację linii
vim.opt.number = true
vim.opt.relativenumber = true

-- Ustawienia tabulacji i wcięć
vim.opt.tabstop = 4        -- Ustaw tabulację na 4 spacje
vim.opt.shiftwidth = 4     -- Automatyczne wcięcia na 4 spacje
vim.opt.expandtab = true   -- Konwersja tabów na spacje
vim.opt.autoindent = true  -- Włącz autoindent
vim.opt.smartindent = true -- Inteligentne wcięcia

-- Włącz kolorowanie składni (syntax highlighting)
vim.cmd("syntax on")

-- Wyłącz kompatybilność wsteczną z Vi
vim.opt.compatible = false

