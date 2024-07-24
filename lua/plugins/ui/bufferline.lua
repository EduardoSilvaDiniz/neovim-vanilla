return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{
			"<leader>bp",
			"<Cmd>BufferLineTogglePin<CR>",
			desc = "Toggle Pin",
		},
		{
			"<leader>bP",
			"<Cmd>BufferLineGroupClose ungrouped<CR>",
			desc = "Delete Non-Pinned Buffers",
		},
		{
			"<leader>bo",
			"<Cmd>BufferLineCloseOthers<CR>",
			desc = "Delete Other Buffers",
		},
		{
			"<leader>br",
			"<Cmd>BufferLineCloseRight<CR>",
			desc = "Delete Buffers to the Right",
		},
		{
			"<leader>by",
			"<Cmd>BufferLineCloseLeft<CR>",
			desc = "Delete Buffers to the Left",
		},
		{
			"<leader>bh",
			"<cmd>BufferLineCyclePrev<cr>",
			desc = "Prev Buffer",
		},
		{
			"<leader>bl",
			"<cmd>BufferLineCycleNext<cr>",
			desc = "Next Buffer",
		},
	},
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				always_show_bufferline = true,
				enforce_regular_tabs = true,
				offsets = {
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					separador = true,
				},
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and " " or (e == "warning" and " " or " ")
						s = s .. n .. sym
					end
					return s
				end,
			},
		})
	end,
}
