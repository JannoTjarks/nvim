return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "BurntSushi/ripgrep" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "JannoTjarks/telescope-terraform-doc.nvim" },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    terraform_doc = {
                        url_open_command = vim.fn.has("macunix") and "open" or "xdg-open",
                        latest_provider_symbol = "  ",
                        wincmd = "new",
                        wrap = "nowrap",
                    },
                },
            })

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("terraform_doc")

            local map = require("janno.utils").map
            local builtin = require("telescope.builtin")

            map(
                "n",
                "<leader>ff",
                builtin.find_files,
                { desc = "Lists files, respects .gitignore" }
            )
            map("n", "<leader>fl", builtin.git_files, {
                desc = "Fuzzy search through the output of git ls-files command, respects .gitignore",
            })
            map("n", "<leader>fg", builtin.live_grep, {
                desc = "Search for a string and get results live as you type, respects .gitignore.",
            })
            map("n", "<leader>fw", builtin.grep_string, {
                desc = "Searches for the string under your cursor in your current working directory",
            })
            map(
                "n",
                "<leader>fb",
                builtin.buffers,
                { desc = "Lists open buffers in current neovim instance" }
            )
            map("n", "<leader>fh", builtin.help_tags, { desc = "Lists available help tags" })
            map(
                "n",
                "<leader>fD",
                builtin.diagnostics,
                { desc = "Lists Diagnostics for all open buffers or a specific buffer" }
            )
            map("n", "<leader>fd", builtin.lsp_definitions, {
                desc =
                "Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope",
            })
            map("n", "<leader>fr", builtin.lsp_references, {
                desc = "Lists LSP references for word under the cursor, jumps to reference on `<cr>`",
            })
            map("n", "<leader>fGs", builtin.git_status, {
                desc = "Lists git status for current directory",
            })
            map("n", "<leader>fGb", builtin.git_branches, {
                desc =
                "List branches for current directory, with output from `git log --oneline` shown in the preview window",
            })
            map("n", "<leader>fGc", builtin.git_commits, {
                desc = "Lists commits for current directory with diff preview",
            })

            map(
                "n",
                "<leader>fta",
                "<cmd>Telescope terraform_doc full_name=hashicorp/azurerm<cr>",
                {
                    desc = "Lists commits for current directory with diff preview",
                }
            )
            map(
                "n",
                "<leader>fte",
                "<cmd>Telescope terraform_doc full_name=hashicorp/azuread<cr>",
                {
                    desc = "Lists commits for current directory with diff preview",
                }
            )
        end,
    },
    {
        "chrisgrieser/nvim-alt-substitute",
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {},
    },
    {
        "Vigemus/iron.nvim",
        config = function()
            local iron = require("iron.core")
            iron.setup({
                config = {
                    scratch_repl = true,
                    repl_definition = {
                        sh = {
                            command = { "bash" },
                        },
                        bash = {
                            command = { "bash" },
                        },
                        ps1 = {
                            command = { "pwsh" },
                        },
                        py = {
                            command = { "python3" },
                        },
                        lua = {
                            command = { "luajit" },
                        },
                    },
                    repl_open_cmd = "botright 20 split",
                },
            })

            local map = require("janno.utils").map
            map("n", "<leader>rs", "<Cmd>IronRepl<CR>", {
                desc = "Open a REPL for current filetype",
            })
            map("n", "<leader>rr", "<Cmd>IronRestart<CR>", {
                desc = "Restart the current REPL",
            })
            map("n", "<leader>sf", "<Cmd>lua require('iron.core').send_file()<CR>", {
                desc = "Sends the whole file to the repl",
            })
            map("n", "<leader>sl", "<Cmd>lua require('iron.core').send_line()<CR>", {
                desc = "Sends line below the cursor to the repl",
            })
            map("v", "<leader>sv", "<Cmd>lua require('iron.core').visual_send()<CR>", {
                desc = "Sends the visual selection to the repl",
            })
        end,
    },
    {
        "christoomey/vim-tmux-navigator",
        config = function()
            local iron = require("iron.core")
            iron.setup({
                config = {
                    scratch_repl = true,
                    repl_definition = {
                        sh = {
                            command = { "bash" },
                        },
                        bash = {
                            command = { "bash" },
                        },
                        ps1 = {
                            command = { "pwsh" },
                        },
                        py = {
                            command = { "python3" },
                        },
                        lua = {
                            command = { "luajit" },
                        },
                    },
                    repl_open_cmd = "botright 20 split",
                },
            })

            local map = require("janno.utils").map
            map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", {
                desc = "Navigate to the next pane left",
            })
            map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", {
                desc = "Navigate to the next pane down",
            })
            map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", {
                desc = "Navigate to the next pane above",
            })
            map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", {
                desc = "Navigate to the next pane rigth",
            })
            map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", {
                desc = "Navigate to the previous pane",
            })
        end,
    },
    {
        "folke/trouble.nvim",
        branch = "dev",
        config = function()
            local trouble = require("trouble")
            trouble.setup()

            local map = require("janno.utils").map
            map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {
                desc = "Diagnostics (Trouble)",
            })
            map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {
                desc = "Buffer Diagnostics (Trouble)",
            })
            map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", {
                desc = "Symbols (Trouble)",
            })
            map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {
                desc = "LSP Definitions / references / ... (Trouble)",
            })
            map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", {
                desc = "Location List (Trouble)",
            })
            map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", {
                desc = "Quickfix List (Trouble)",
            })
        end,
    },
}
