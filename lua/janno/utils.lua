local utils = {}

utils.augroup = function(name)
    return vim.api.nvim_create_augroup("janno_" .. name, { clear = true })
end

utils.map = function(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

utils.masonpath = vim.fn.stdpath("data") .. "/mason"

return utils
