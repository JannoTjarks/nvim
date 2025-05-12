return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "ansiblels",
                "bashls",
                "eslint",
                "gopls",
                "jsonls",
                "lua_ls",
                "omnisharp",
                "powershell_es",
                "pyright",
                "terraformls",
                "tflint",
                "ts_ls",
                "yamlls",
            },
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",                                  -- only load on lua files
        dependencies = {
            { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
        },
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local augroup = require("janno.utils").augroup
            vim.api.nvim_create_autocmd("LspAttach", {
                group = augroup("-lsp-attach"),
                callback = function(event)
                    local map = require("janno.utils").map
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    -- inlay-hints
                    if
                        client
                        and client.server_capabilities.inlayHintProvider
                        and vim.lsp.inlay_hint
                    then
                        map("n", "<space>th", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                        end, { desc = "Toggle Inlay Hints [LSP]" })
                    end

                    map(
                        "n",
                        "<space>q",
                        "<Cmd>lua vim.diagnostic.setloclist()<CR>",
                        { desc = "Add buffer diagnostics to the location list" }
                    )
                    map(
                        "n",
                        "gD",
                        "<Cmd>lua vim.lsp.buf.declaration()<CR>",
                        { desc = "Jumps to the declaration of the symbol under the cursor [LSP]" }
                    )
                    map(
                        "n",
                        "gd",
                        "<Cmd>lua vim.lsp.buf.definition()<CR>",
                        { desc = "Jumps to the definition of the symbol under the cursor [LSP]" }
                    )
                    map("n", "<space>D", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", {
                        desc =
                        "Jumps to the definition of the type of the symbol under the cursor [LSP]",
                    })
                    map(
                        "n",
                        "<leader>l",
                        "<Cmd>lua vim.lsp.codelens.run()<CR>",
                        { desc = "Run the code lens in the current line [LSP]" }
                    )

                    -- formatting
                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                            buffer = event.buf,
                            group = augroup("formatting"),
                            callback = function()
                                vim.lsp.buf.format()
                            end,
                        })
                    end

                    -- highlight
                    if client and client.server_capabilities.documentHighlightProvider then
                        local highlight_augroup = augroup("-lsp-highlight")
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        local detach_augroup = augroup("-lsp-detach")
                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = detach_augroup,
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({
                                    group = highlight_augroup,
                                    buffer = event2.buf,
                                })
                            end,
                        })
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            vim.lsp.config('gopls', {
                settings = {
                    gopls = {
                        codelenses = {
                            gc_details = false,
                            generate = true,
                            regenerate_cgo = true,
                            run_govulncheck = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true,
                        },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                        analyses = {
                            nilness = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        usePlaceholders = true,
                        completeUnimported = true,
                        staticcheck = true,
                        directoryFilters = {
                            "-.git",
                            "-.vscode",
                            "-.idea",
                            "-.vscode-test",
                            "-node_modules",
                        },
                        semanticTokens = true,
                    },
                }
            })

            vim.lsp.config('yamlls', {
                settings = {
                    yaml = {
                        format = {
                            enable = true,
                            singleQuote = true,
                            bracketSpacing = true,
                        },
                        hover = true,
                        validate = true,
                        completion = true,
                        schemas = {
                            ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] =
                            "/.azurepipelines/*",
                            ["https://json.schemastore.org/github-workflow.json"] =
                            ".github/workflows/*",
                            ["https://json.schemastore.org/github-action.json"] =
                            ".github/actions/*.{yml,yaml}",
                            ["https://json.schemastore.org/kustomization.json"] =
                            "kustomization.{yml,yaml}",
                        },
                    },
                }
            })

            vim.lsp.config('lua_ls', {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force',
                        client.config.settings.Lua, {
                            runtime = {
                                version = 'LuaJIT',
                                path = {
                                    'lua/?.lua',
                                    'lua/?/init.lua',
                                },
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME
                                }
                            }
                        })
                end,
                settings = {
                    Lua = {}
                }
            })

            vim.lsp.enable('bashls')
            vim.lsp.enable('csharp_ls')
            vim.lsp.enable('eslint')
            vim.lsp.enable('gdscript')
            vim.lsp.enable('gopls')
            vim.lsp.enable('jsonls')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('powershell_es')
            vim.lsp.enable('pyrigth')
            vim.lsp.enable('terraformls')
            vim.lsp.enable('ts_ls')
            vim.lsp.enable('yamlls')
        end,
    },
    {
        "JannoTjarks/tflint.nvim",
        version = "*",
        dependencies = {
            "neovim/nvim-lspconfig"
        },
        lazy = true,
        ft = "terraform",
    }
}
