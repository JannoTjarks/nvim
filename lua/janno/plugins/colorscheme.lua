return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = true,
            no_italic = true,
            no_bold = true,
            no_underline = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                grug_far = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                markdown = true,
                native_lsp = {
                    enabled = true,
                    inlay_hints = {
                        background = true,
                    },
                },
                nvimtree = true,
                telescope = {
                    enabled = true,
                },
                treesitter = true,
                which_key = true,
            },
        })
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}
