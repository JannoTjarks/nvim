local function augroup(name)
    return vim.api.nvim_create_augroup("janno_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        vim.cmd("wincmd =")
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = augroup("highligth_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})
