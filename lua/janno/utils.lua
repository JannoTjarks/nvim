---@class Util
---@field masonpath string Path to the packages installed by mason
local utils = {}
utils.masonpath = vim.fn.stdpath("data") .. "/mason"

--- @param name string Name of the augroup, 'janno_' will be added as prefix
--- @return integer
utils.augroup = function(name)
    return vim.api.nvim_create_augroup("janno_" .. name, { clear = true })
end

--- @param mode string | string[] Mode short-name
--- @param lhs string Left-hand side {lhs} of the mapping.
--- @param rhs string | function Right-hand side {rhs} of the mapping
--- @param opts table? Table of :map-arguments
utils.map = function(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

return utils
