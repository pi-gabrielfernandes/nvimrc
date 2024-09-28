vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.scrolloff = 999

vim.o.hlsearch = false

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

vim.o.wrap = false
vim.o.smartcase = true

vim.o.cursorline = true
vim.o.guicursor = "n-v-c-i:block"

vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.signcolumn = "yes"

vim.o.clipboard = "unnamedplus"

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.undofile = true
vim.o.mouse = "a"

vim.o.foldmethod = "expr"
vim.o.foldlevel = 99
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.o.hlsearch = true

-- lazygit default options
vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = "" -- custom config file path
-- OR
vim.g.lazygit_config_file_path = {} -- table of custom config file paths
