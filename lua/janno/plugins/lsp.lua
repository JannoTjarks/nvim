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
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/neodev.nvim",
                opts = {},
            },
        },
        config = function()
            local on_attach = function(client, bufnr)
                -- formatting
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_command([[augroup Format]])
                    vim.api.nvim_command([[autocmd! * <buffer>]])
                    vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
                    vim.api.nvim_command([[augroup END]])
                end

                -- codelens
                if client.server_capabilities.CodeLensProvider then
                    vim.api.nvim_command([[augroup CodeLens]])
                    vim.api.nvim_command(
                        [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
                    )
                    vim.api.nvim_command([[augroup END]])
                end

                -- inlay-hints
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(bufnr, true)
                end

                local map = require("janno.utils").map
                map(
                    "n",
                    "[d",
                    "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
                    { desc = "Get the previous diagnostic closest to the cursor position" }
                )
                map(
                    "n",
                    "]d",
                    "<Cmd>lua vim.diagnostic.goto_next()<CR>",
                    { desc = "Get the next diagnostic closest to the cursor position" }
                )
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
                map(
                    "n",
                    "K",
                    "<Cmd>lua vim.lsp.buf.hover()<CR>",
                    { desc = "Displays hover information about the symbol under the cursor [LSP]" }
                )
                map(
                    "n",
                    "gi",
                    "<Cmd>lua vim.lsp.buf.implementation()<CR>",
                    { desc = "Lists all the implementations for the symbol under the cursor [LSP]" }
                )
                map("n", "<leader>k", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", {
                    desc = "Displays signature information about the symbol under the cursor [LSP]",
                })
                map("n", "<space>D", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", {
                    desc = "Jumps to the definition of the type of the symbol under the cursor [LSP]",
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
                    "<space>f",
                    "<Cmd>lua vim.lsp.buf.formatting()<CR>",
                    { desc = "Formats the current buffer [LSP]" }
                )
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
            end

            local lsp = require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            lsp.bashls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lsp.eslint.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lsp.gopls.setup({
                on_attach = on_attach,
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
                        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                        semanticTokens = true,
                    },
                },
            })

            lsp.jsonls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lsp.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            lsp.omnisharp.setup({
                cmd = {
                    require("janno.utils").masonpath .. "/bin/omnisharp",
                },
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lsp.powershell_es.setup({
                bundle_path = require("janno.utils").masonpath
                    .. "/packages/powershell-editor-services",
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lsp.pyright.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lsp.terraformls.setup({
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    -- With enabled semanticTokensProvider errors are thrown:
                    -- ERROR: `E5248: Invalid character in group name`
                    -- GitHub Issue: https://github.com/neovim/neovim/issues/23184
                    client.server_capabilities.semanticTokensProvider = nil
                end,
                capabilities = vim.tbl_deep_extend("keep", {
                    experimental = {
                        showReferencesCommandId = "client.showReferences",
                    },
                }, require("cmp_nvim_lsp").default_capabilities()),
                init_options = {
                    experimentalFeatures = {
                        validateOnSave = true,
                        prefillRequiredFields = true,
                    },
                },
                filetypes = { "terraform", "terraform-vars" },
            })

            lsp.tflint.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lsp.tsserver.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lsp.yamlls.setup({
                on_attach = on_attach,
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
                            ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
                            "*api*.{yml,yaml}",
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
                            ["https://json.schemastore.org/dependabot-2.0.json"] =
                            ".github/dependabot.{yml,yaml}",
                            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
                            "*gitlab-ci*.{yml,yaml}",
                            kubernetes = "@(deploy|.k8s)/**/*.{yml,yaml}",
                            -- kubernetes = "deploy/**/*.{yml,yaml}",
                            ["https://json.schemastore.org/kustomization.json"] =
                            "kustomization.{yml,yaml}",
                            ["https://json.schemastore.org/chart.json"] = "Chart.{yml,yaml}",
                        },
                    },
                },
            })
        end,
    },
}
