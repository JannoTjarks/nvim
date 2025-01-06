return {
    { "onsails/lspkind.nvim" },
    {
        'L3MON4D3/LuaSnip',
        build = (function()
            return 'make install_jsregexp'
        end)(),
    },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },

                cmp.setup({
                    completion = {
                        completeopt = "menuone,noinsert,noselect",
                    },
                    mapping = cmp.mapping.preset.insert({
                        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-f>"] = cmp.mapping.scroll_docs(4),
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ["<C-e>"] = cmp.mapping.close(),
                        ['<CR>'] = cmp.mapping.confirm { select = true },
                        ['<Tab>'] = cmp.mapping.select_next_item(),
                        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                        ['<C-l>'] = cmp.mapping(function()
                            if luasnip.expand_or_locally_jumpable() then
                                luasnip.expand_or_jump()
                            end
                        end, { 'i', 's' }),
                        ['<C-h>'] = cmp.mapping(function()
                            if luasnip.locally_jumpable(-1) then
                                luasnip.jump(-1)
                            end
                        end, { 'i', 's' }),
                    }),
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end,
                    },
                    sources = cmp.config.sources({
                        {
                            name = 'lazydev',
                            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                            group_index = 0,
                        },
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                        { name = "path" },
                        { name = "buffer" },
                    }),
                    formatting = {
                        format = require("lspkind").cmp_format({
                            mode = "symbol_text",
                            maxwidth = 50,
                        }),
                    }
                })
            }
        end,
    },
}
