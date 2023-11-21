-- Remap <C-d> and <C-u> to center screen
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'tt', "<cmd>lua require('nvterm.terminal').toggle('vertical')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'th', "<cmd>lua require('nvterm.terminal').toggle('horizontal')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tf', "<cmd>lua require('nvterm.terminal').toggle('float')<CR>", { noremap = true, silent = true })

-- Map neo-tree to <leader-n>
vim.api.nvim_set_keymap('n', '<Leader>n', ':Neotree<CR>', {noremap = true, silent = true})

-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

