-- Enable line numbering and relativity
vim.opt.number = true
vim.opt.relativenumber = true

-- Settings for tabulations
vim.opt.tabstop = 4        -- Ustaw tabulację na 4 spacje
vim.opt.shiftwidth = 4     -- Automatyczne wcięcia na 4 spacje
vim.opt.expandtab = true   -- Konwersja tabów na spacje
vim.opt.autoindent = true  -- Włącz autoindent
vim.opt.smartindent = true -- Inteligentne wcięcia

-- Syntax highlighting
vim.cmd("syntax on")

-- Disable backwards compatibility with Vi
vim.opt.compatible = false

-- Telescope setup
require('telescope').setup{
    defaults = {
        layout_strategy = 'horizontal',
        sorting_strategy = 'ascending',
        layout_config = { prompt_position = 'top' }
    }
}
