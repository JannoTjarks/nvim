return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            { "AndreM222/copilot-lualine" },
            { "arkav/lualine-lsp-progress" },
        },
        opts = {
            options = {
                icons_enabled = true,
                theme = "catppuccin",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = {
                    "branch",
                    "diff",
                    {
                        sources = {
                            "diagnostics",
                            "nvim_diagnostic",
                        },
                        symbols = {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = " ",
                        },
                    },
                },
                lualine_c = {
                    "filename",
                    "lsp_progress",
                },
                lualine_x = {
                    "copilot",
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = {
                    "searchcount",
                    "progress",
                },
                lualine_z = {
                    "location",
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    "filename",
                },
                lualine_x = {
                    "location",
                },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = {},
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
    },
    {
        "folke/which-key.nvim",
        opts = {},
    },
    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup()

            local map = require("janno.utils").map
            map(
                "n",
                "n",
                [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]]
            )
            map(
                "n",
                "N",
                [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]]
            )
            map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]])
            map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]])
            map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]])
            map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]])
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")
            gitsigns.setup({
                current_line_blame = true,

                on_attach = function(bufnr)
                    local map = require("janno.utils").map
                    map("n", "]g", function()
                        vim.schedule(function()
                            gitsigns.next_hunk()
                        end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                        desc = "Goto previous git hunk",
                    })
                    map("n", "[g", function()
                        vim.schedule(function()
                            gitsigns.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                        desc = "Goto next git hunk",
                    })
                end,
            })
        end,
    },
    { "stevearc/dressing.nvim" },
    {
        "echasnovski/mini.icons",
        opts = {},
        init = function()
            package.preload["nvim-web-devicons"] = function()
                -- needed since it will be false when loading and mini will fail
                package.loaded["nvim-web-devicons"] = {}
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    { "shortcuts/no-neck-pain.nvim", version = "*" }
}
