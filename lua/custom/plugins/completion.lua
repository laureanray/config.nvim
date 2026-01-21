return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		priority = 100,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
			"roobert/tailwindcss-colorizer-cmp.nvim",
			{
				"supermaven-inc/supermaven-nvim",
				config = function()
					require("supermaven-nvim").setup({
						keymaps = {
							accept_suggestion = "<Tab>",
							clear_suggestion = "<C-]>",
							accept_word = "<C-j>",
						},
						ignore_filetypes = { cpp = true }, -- or { "cpp", }
						color = {
							suggestion_color = "#ffffff",
							cterm = 244,
						},
						log_level = "info", -- set to "off" to disable logging completely
						disable_inline_completion = false, -- disables inline completion for use with cmp
						disable_keymaps = false, -- disables built in keymaps for more manual control
						condition = function()
							return false
						end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
					})
				end,
			},
		},
		config = function()
			require("custom.completion")
		end,
	},
}
