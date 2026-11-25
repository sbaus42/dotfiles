require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Mappings for LSP
map('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
-- Go to definition mapping
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
