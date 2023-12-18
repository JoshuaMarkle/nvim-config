return {
	'nvim-telescope/telescope.nvim',
	cmd = "Telescope",
	lazy = true,
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
	},
    keys = {
    	{ "ff", "<cmd>Telescope find_files<CR>", desc = "Find Files Fuzzily" },
    	{ "fg", "<cmd>Telescope live_grep<CR>", desc = "Find Text" },
    	{ "fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
    	{ "fo", "<cmd>Telescope colorscheme<CR>", desc = "Choose Colorschemes" },
    	{ "fe", "<cmd>Telescope emoji<CR>", desc = "Emoji search - copy - paste" },
    	{ "fd", "<cmd>Telescope diagnostics<CR>", desc = "Workspace Diagnostics [Telescope]" },
    },
	config = function ()
		require('telescope').setup {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					}
				}
			}
		}

		-- Enable telescope fzf native, if installed
		pcall(require('telescope').load_extension, 'fzf')
	end,
}
