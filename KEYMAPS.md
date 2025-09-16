# Keymaps


## LSP
> This are the default lsp keymaps provided by neovim.
> 
> *https://neovim.io/doc/user/index.html* or `help :lsp-defaults`

| Keymap | Mode(s) | Mapping | Description |
| --- | --- | --- | --- |
| `grn` | `N` | `vim.lsp.buf.rename()` | Renames all references to the symbol under the cursor |
| `gra` | `NV` | `vim.lsp.buf.code_action()` | Selects a code action (LSP: "textDocument/codeAction" request) available at cursor position |
| `grr` | `N` | `vim.lsp.buf.references()`  | Lists all the references to the symbol under the cursor in the quickfix window |
| `gri` | `N` | `vim.lsp.buf.implemantation()` | Lists all the implementations for the symbol under the cursor in the quickfix window |
| `grt` | `N` | `vim.lsp.buf.type_definition()` | Jumps to the definition of the type of the symbol under the cursor |
| `gO` | `N` | `vim.lsp.buf.document_symbol()`  | Lists all symbols in the current buffer in the location-list |
| `CTRL-S` | `I` | `vim.lsp.buf.signature_help()` | Displays signature information about the symbol under the cursor in a floating window |
| `CTRL-X CTRL-O` | `I` | `vim.lsp.omnifunc()` | Implements 'omnifunc' compatible LSP completion
| `K` | `N` | `vim.lsp.buf.hover()` | Displays hover information about the symbol under the cursor in a floating window |

## Spell

| Keymap | Mode(s) | Mapping | Description |
| --- | --- | --- | --- |
| `<leader>ss` | `N` | `<cmd>set spell spelllang=en<CR>` | Activates spellcheck with englisch as language |
| `<leader>sg` | `N` | `<cmd>set spell spelllang=de<CR>` | Activates spellcheck with german as language |
| `z=` | `N` | - | Opens the Spelling Suggestions |
| `zg` | `N` | - | Add word to spell list |
| `]s` | `N` | - | Go to next bad spelled word |
| `[s` | `N` | - | Go to previous bad spelled word |

## Movement
| Keymap | Mode(s) | Mapping | Description |
| --- | --- | --- | --- |
| `<A-k>` | `NV` | `<cmd>m-2<CR>` | Move line onetime up |
| `<A-j>` | `NV` | `<cmd>m+1<CR>` | Move line onetime down |

## Buffer Management
| Keymap | Mode(s) | Mapping | Description |
| --- | --- | --- | --- |
| `<A-.>` | `N` | `<cmd>bnext<CR>` | Go to next buffer in buffer list |
| `<A-,>` | `N` | `<cmd>bprevious<CR>` | Go to previous buffer in buffer list |
| `<A-c>` | `N` | `<cmd>bdelete<CR>` | Unload current buffer and delete it from the buffer list |
| `<A-C>` | `N` | `<cmd>bdelete!<CR>` | Unload current buffer and delete it from the buffer list with all changes lost |

## REPL
| Keymap | Mode(s) | Mapping | Description |
| --- | --- | --- | --- |
| `<leader>rs` | `N` | `<Cmd>IronRepl<CR>` | Open a REPL for current filetype |
| `<leader>rr` | `N` | `<Cmd>IronRestart<CR>` | Restart the current REPL |
| `<leader>sf` | `N` | `<Cmd>lua require('iron.core').send_file()<CR>` | Sends the whole file to the repl |
| `<leader>sl` | `N` | `<Cmd>lua require('iron.core').send_line()<CR>` | Sends line below the cursor to the repl |
| `<leader>sv` | `N` | `<Cmd>lua require('iron.core').virtual_send()<CR>` | Sends the visual selection to the repl |

## File Movement
| Keymap | Mode(s) | Mapping | Description |
| --- | --- | --- | --- |
| `<leader>a` | `N` | `function() harpoon:list():add() end` | Add current file to harpoon list |
| `<leader>c` | `N` | `function() harpoon:list():add() end` | Clear harpoon list |
| `<C-e>` | `N` | `function() harpoon.ui:toggle_quick_menu(harpoon:list()) end` | Open harpoon quick list |
| `<leader>1` | `N` | `function() harpoon:list():select(1) end)` | Jump to file on harpoon list in position 1 |
| `<leader>2` | `N` | `function() harpoon:list():select(2) end)` | Jump to file on harpoon list in position 2 |
| `<leader>3` | `N` | `function() harpoon:list():select(3) end)` | Jump to file on harpoon list in position 3 |
| `<leader>4` | `N` | `function() harpoon:list():select(4) end)` | Jump to file on harpoon list in position 4 |
| `<leader>.` | `N` | `function() harpoon:list():next() end)` | Jump to next file on harpoon list |
| `<leader>,` | `N` | `function() harpoon:list():prev() end)` | Jump to previous file on harpoon list |


## Commodity
| Keymap | Mode(s) | Mapping | Description |
| --- | --- | --- | --- |
| `<ESC>` | `N` | `<cmd>nohlsearch<CR>` | Clear highlight search |
| `<ESC>` | `T` | `<C-\\><C-n>` | Easier mode change from inside terminal mode to normal mode |
| `gx` | `NV` | `vim.ui.open()` | Opens the current filepath or URL at cursor using the system default handler |
