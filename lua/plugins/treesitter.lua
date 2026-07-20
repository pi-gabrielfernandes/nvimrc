local ensure_installed = {
	"bash",
	"c",
	"diff",
	"html",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"vim",
	"vimdoc",
	"go",
	"javascript",
	"typescript",
	"kotlin",
	"json",
	"yaml",
}

-- indentexpr previously disabled for these langs (their own indent plugins/filetype
-- indent are preferred over treesitter's experimental indentexpr)
local indent_disabled = {
	python = true,
	lua = true,
	typescript = true,
	javascript = true,
	go = true,
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()
			require("nvim-treesitter").install(ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match) or args.match
					local tsconfig = require("nvim-treesitter.config")
					if
						vim.list_contains(tsconfig.get_available(), lang)
						and not vim.list_contains(tsconfig.get_installed(), lang)
					then
						require("nvim-treesitter").install({ lang }):wait(120000)
					end
					local ok = pcall(vim.treesitter.start)
					if ok and not indent_disabled[lang] then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local textobjects = {
				aa = "@parameter.outer",
				ia = "@parameter.inner",
				af = "@function.outer",
				["if"] = "@function.inner",
				ac = "@class.outer",
				ic = "@class.inner",
			}
			for keymap, query in pairs(textobjects) do
				vim.keymap.set({ "x", "o" }, keymap, function()
					select.select_textobject(query, "textobjects")
				end)
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		opts = {
			enable = true,
			max_lines = 0,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
			separator = nil,
			zindex = 20,
			on_attach = nil,
		},
	},
}
