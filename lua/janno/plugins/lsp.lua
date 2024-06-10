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
                "tsserver",
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
                        "<space>e",
                        "<Cmd>lua vim.diagnostic.open_float()<CR>",
                        { desc = "Show diagnostics in a floating window" }
                    )
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
                    map("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", {
                        desc = "Lists all the implementations for the symbol under the cursor [LSP]",
                    })
                    map("n", "<leader>k", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", {
                        desc =
                        "Displays signature information about the symbol under the cursor [LSP]",
                    })
                    map("n", "<space>D", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", {
                        desc =
                        "Jumps to the definition of the type of the symbol under the cursor [LSP]",
                    })
                    map("n", "<space>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", {
                        desc = "Selects a code action available at the current cursor position [LSP]",
                    })
                    map("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", {
                        desc =
                        "Lists all the references to the symbol under the cursor in the quickfix window [LSP]",
                    })
                    map(
                        "n",
                        "<space>rn",
                        "<Cmd>lua vim.lsp.buf.rename()<CR>",
                        { desc = "Rename old_fname to new_fname [LSP]" }
                    )
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

            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            local lsp = require("lspconfig")

            lsp.bashls.setup({
                capabilities = capabilities,
            })

            lsp.eslint.setup({
                capabilities = capabilities,
            })

            lsp.gopls.setup({
                capabilities = capabilities,
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
                            fieldalignment = true,
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
                },
            })

            lsp.jsonls.setup({
                capabilities = capabilities,
            })

            lsp.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                        codeLens = {
                            enable = true,
                        },
                        hint = {
                            enable = true,
                            setType = false,
                            paramType = true,
                            paramName = "Disable",
                            semicolon = "Disable",
                            arrayIndex = "Disable",
                        }
                    },
                },
            })

            lsp.omnisharp.setup({
                cmd = {
                    require("janno.utils").masonpath .. "/bin/omnisharp",
                },
                capabilities = capabilities,
            })

            lsp.powershell_es.setup({
                bundle_path = require("janno.utils").masonpath
                    .. "/packages/powershell-editor-services",
                capabilities = capabilities,
            })

            lsp.pyright.setup({
                capabilities = capabilities,
            })

            lsp.terraformls.setup({
                -- capabilities = vim.tbl_deep_extend("keep", {
                --     experimental = {
                --         showReferencesCommandId = "client.showReferences",
                --     },
                -- }, require("cmp_nvim_lsp").default_capabilities()),
                capabilities = capabilities,
                init_options = {
                    experimentalFeatures = {
                        validateOnSave = true,
                        prefillRequiredFields = true,
                    },
                },
                filetypes = { "terraform", "terraform-vars" },
            })

            lsp.tflint.setup({
                capabilities = capabilities,
            })

            lsp.tsserver.setup({
                capabilities = capabilities,
            })

            lsp.yamlls.setup({
                capabilities = capabilities,
                filetypes = { "yaml", "yml", "yaml.docker-compsose" },
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
                            ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] =
                            "roles/**.{yml,yaml}",
                            ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] =
                            "playbooks/**.{yml,yaml}",
                            ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/hosts"] =
                            "*host*.{yml,yaml}",
                            ["https://json.schemastore.org/github-workflow.json"] =
                            ".github/workflows/*",
                            ["https://json.schemastore.org/github-action.json"] =
                            ".github/actions/*.{yml,yaml}",
                            kubernetes = "deploy/**/!(kustomization).{yml,yaml}",
                            ["https://json.schemastore.org/kustomization.json"] =
                            "kustomization.{yml,yaml}",
                        },
                    },
                },
            })
        end,
    },
    {
        "JannoTjarks/tflint.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {},
    },
}
