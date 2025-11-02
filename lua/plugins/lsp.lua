return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", opts = {} },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "denols", "gopls" },
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function() end,
	},
}
