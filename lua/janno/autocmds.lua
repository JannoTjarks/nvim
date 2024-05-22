local augroup = require("janno.utils").augroup

vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize-splits"),
    callback = function()
        vim.cmd("wincmd =")
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = augroup("highligth-yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})
