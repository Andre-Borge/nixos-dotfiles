require("core.lazy")
require("core.lsp")
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.linebreak = true

vim.opt.cursorline = true


vim.opt.scrolloff = 10

vim.keymap.set('i', '<jk>', '<Esc>')


vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = 'split'

vim.opt.undofile = true

vim.cmd [[
	iabbrev @@ your@email.com
]]

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

--vim.keymap.set('i', '(',  '()<Esc>i')
--vim.keymap.set('i', '{',  '{{<Esc>i')
--vim.keymap.set('i', '[',  '[[<Esc>i')


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')
vim.opt.clipboard = "unnamedplus"
vim.keymap.set('n', '<leader>a', ':split | terminal<CR>')
vim.keymap.set('n', '<leader>st', ':set spell!<CR>')

vim.keymap.set('n', '<leader>su', 'z=')
vim.keymap.set('n', '<leader>sf', ']s')
vim.keymap.set('n', '<leader>sb', '[s')

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set('v', "<leader>'", "c''<Esc>P")
vim.keymap.set('v', '<leader>"', 'c""<Esc>P')

vim.cmd[[colorscheme tokyonight]]


