local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

map('n', '<leader>w', ':write<CR>', default_opts)
map('n', '<leader>q', ':quit<CR>', default_opts)

map('n', '<leader>sv', ':vsplit<CR>', default_opts)
map('n', '<leader>sh', ':split<CR>', default_opts)
map('n', '<leader>se', '<C-W>', default_opts)
map('n', '<leader>sx', ':close<CR>', default_opts)
