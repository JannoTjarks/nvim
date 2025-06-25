return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    init = function(plugin)
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "bash",
            "c",
            "c_sharp",
            "cmake",
            "cpp",
            "css",
            "diff",
            "dockerfile",
            "gitignore",
            "go",
            "gomod",
            "gowork",
            "gosum",
            "hcl",
            "html",
            "javascript",
            "jq",
            "json",
            "latex",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "scss",
            "sql",
            "tsx",
            "typescript",
            "toml",
            "terraform",
            "vim",
            "vimdoc",
            "yaml",
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
            },
        },
    },
    config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            ---@type table<string, boolean>
            local added = {}
            opts.ensure_installed = vim.tbl_filter(function(lang)
                if added[lang] then
                    return false
                end
                added[lang] = true
                return true
            end, opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)
    end,
}
