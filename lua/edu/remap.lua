vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
--vim.keymap.set("n", "<F5>", ':term gcc out -o a.out && ./a.out<CR>')
vim.keymap.set("n", "<F5>", ':w<CR>:make<CR>')
--vim.api.nvim_set_keymap('n', '<F5>', ':w<CR>:term gcc % -o %:r && ./%:r<CR>i', {noremap = true})
