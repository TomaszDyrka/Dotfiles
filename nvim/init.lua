-- settings
require("settings")

-- remap keys
require("remap")

-- colours
require('kanagawa').setup({
    theme = "dragon",        
    background = {           
        dark = "dragon",
        light = "lotus"
    },
})

vim.cmd("colorscheme kanagawa")
--vim.cmd([[colorscheme gruvbox]])
