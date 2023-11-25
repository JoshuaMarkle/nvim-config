return {
	-- Tmux integration
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
	},

	-- Auto pair () [] {}
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = function()
			require('nvim-autopairs').setup({
				disable_filetype = { "tex" },
			})
		end
	},

	-- Visualize tabs
	{ 
		"lukas-reineke/indent-blankline.nvim", 
		main = "ibl", 
		config = function()
			require("ibl").setup {
				scope = { enabled = true },
			}
		end
	},

	-- Useful plugin to show you pending keybinds.
	{ 
		'folke/which-key.nvim', 
		enabled = true,
		opts = {} 
	},

	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				icons_enabled = true,
				theme = "onedark",
				component_separators = '|',
				section_separators = '',
			},
		},
	},

	-- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

	-- Add a dashboard on open
	{
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function ()
			require'alpha'.setup(require'alpha.themes.theta'.config)
		end
	},

	-- Code runner
	{
		"CRAG666/code_runner.nvim",
		config = true
	},

  -- Notification
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      --dofile(vim.g.base46_cache .. "notify")
      require("notify").setup {
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "fade",
        timeout = 3000,
        top_down = true,
      }

      vim.notify = require "notify"
    end,
  },

	{
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

	-- Navigation
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function ()
		  -- If you want icons for diagnostic errors, you'll need to define them somewhere:
		  vim.fn.sign_define("DiagnosticSignError",
			{text = " ", texthl = "DiagnosticSignError"})
		  vim.fn.sign_define("DiagnosticSignWarn",
			{text = " ", texthl = "DiagnosticSignWarn"})
		  vim.fn.sign_define("DiagnosticSignInfo",
			{text = " ", texthl = "DiagnosticSignInfo"})
		  vim.fn.sign_define("DiagnosticSignHint",
			{text = "󰌵", texthl = "DiagnosticSignHint"})

		  require("neo-tree").setup({
			close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
			sort_case_insensitive = false, -- used when sorting files and directories in the tree
			sort_function = nil , -- use a custom function for sorting files and directories in the tree 
			-- sort_function = function (a,b)
			--       if a.type == b.type then
			--           return a.path > b.path
			--       else
			--           return a.type > b.type
			--       end
			--   end , -- this sorts files and directories descendantly
			default_component_configs = {
			  container = {
				enable_character_fade = true
			  },
			  indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			  },
			  icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "󰜌",
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "*",
				highlight = "NeoTreeFileIcon"
			  },
			  modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			  },
			  name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			  },
			  git_status = {
				symbols = {
				  -- Change type
				  added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				  modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
				  deleted   = "✖",-- this can only be used in the git_status source
				  renamed   = "󰁕",-- this can only be used in the git_status source
				  -- Status type
				  untracked = "",
				  ignored   = "",
				  unstaged  = "󰄱",
				  staged    = "",
				  conflict  = "",
				}
			  },
			  -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
			  file_size = {
				enabled = true,
				required_width = 64, -- min width of window required to show this column
			  },
			  type = {
				enabled = true,
				required_width = 122, -- min width of window required to show this column
			  },
			  last_modified = {
				enabled = true,
				required_width = 88, -- min width of window required to show this column
			  },
			  created = {
				enabled = true,
				required_width = 110, -- min width of window required to show this column
			  },
			  symlink_target = {
				enabled = false,
			  },
			},
			-- A list of functions, each representing a global custom command
			-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
			-- see `:h neo-tree-custom-commands-global`
			commands = {},
			window = {
			  position = "left",
			  width = 40,
			  mapping_options = {
				noremap = true,
				nowait = true,
			  },
			  mappings = {
				["<space>"] = { 
					"toggle_node", 
					nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
				},
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["<esc>"] = "cancel", -- close preview or floating neo-tree window
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
				-- Read `# Preview Mode` for more information
				["l"] = "focus_preview",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				-- ["S"] = "split_with_window_picker",
				-- ["s"] = "vsplit_with_window_picker",
				["t"] = "open_tabnew",
				-- ["<cr>"] = "open_drop",
				-- ["t"] = "open_tab_drop",
				["w"] = "open_with_window_picker",
				--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
				["C"] = "close_node",
				-- ['C'] = 'close_all_subnodes',
				["z"] = "close_all_nodes",
				--["Z"] = "expand_all_nodes",
				["a"] = { 
				  "add",
				  -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
				  -- some commands may take optional config options, see `:h neo-tree-mappings` for details
				  config = {
					show_path = "none" -- "none", "relative", "absolute"
				  }
				},
				["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
				-- ["c"] = {
				--  "copy",
				--  config = {
				--    show_path = "none" -- "none", "relative", "absolute"
				--  }
				--}
				["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
				["i"] = "show_file_details",
			  }
			},
			nesting_rules = {},
			filesystem = {
			  filtered_items = {
				visible = false,
				hide_dotfiles = true,
				hide_gitignored = true,
				hide_hidden = true,
				always_show = {},
				never_show = {},
			  },
			  follow_current_file = {
				enabled = false, -- This will find and focus the file in the active buffer every time
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			  },
			  group_empty_dirs = true, -- when true, empty folders will be grouped together
			  hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
			  use_libuv_file_watcher = false,
			  window = {
				mappings = {
				  ["<bs>"] = "navigate_up",
				  ["."] = "set_root",
				  ["H"] = "toggle_hidden",
				  ["/"] = "fuzzy_finder",
				  ["D"] = "fuzzy_finder_directory",
				  ["#"] = "fuzzy_sorter",
				  ["f"] = "filter_on_submit",
				  ["<c-x>"] = "clear_filter",
				  ["[g"] = "prev_git_modified",
				  ["]g"] = "next_git_modified",
				  ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
							

				  ["od"] = { "order_by_diagnostics", nowait = false },
				  ["og"] = { "order_by_git_status", nowait = false },
				  ["om"] = { "order_by_modified", nowait = false },
				  ["on"] = { "order_by_name", nowait = false },
				  ["os"] = { "order_by_size", nowait = false },
				  ["ot"] = { "order_by_type", nowait = false },
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				  ["<down>"] = "move_cursor_down",
				  ["<C-n>"] = "move_cursor_down",
				  ["<up>"] = "move_cursor_up",
				  ["<C-p>"] = "move_cursor_up",
				},
			  },

			  commands = {} -- Add a custom command or override a global one using the same function name
			},
			buffers = {
			  follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--              -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			  },
			  group_empty_dirs = true, -- when true, empty folders will be grouped together
			  show_unloaded = true,
			  window = {
				mappings = {
				  ["bd"] = "buffer_delete",
				  ["<bs>"] = "navigate_up",
				  ["."] = "set_root",
				  ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				  ["oc"] = { "order_by_created", nowait = false },
				  ["od"] = { "order_by_diagnostics", nowait = false },
				  ["om"] = { "order_by_modified", nowait = false },
				  ["on"] = { "order_by_name", nowait = false },
				  ["os"] = { "order_by_size", nowait = false },
				  ["ot"] = { "order_by_type", nowait = false },
				}
			  },
			},
			git_status = {
			  window = {
				position = "float",
				mappings = {
				  ["A"]  = "git_add_all",
				  ["gu"] = "git_unstage_file",
				  ["ga"] = "git_add_file",
				  ["gr"] = "git_revert_file",
				  ["gc"] = "git_commit",
				  ["gp"] = "git_push",
				  ["gg"] = "git_commit_and_push",
				  ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				  ["oc"] = { "order_by_created", nowait = false },
				  ["od"] = { "order_by_diagnostics", nowait = false },
				  ["om"] = { "order_by_modified", nowait = false },
				  ["on"] = { "order_by_name", nowait = false },
				  ["os"] = { "order_by_size", nowait = false },
				  ["ot"] = { "order_by_type", nowait = false },
				}
			  }
			}
		  })
		end
	}, 

	{
		"Aasim-A/scrollEOF.nvim",
		config = function()
			require("scrollEOF").setup({
				pattern = "*",
				insert_mode = false,
				disable_filetypes = {},
			})
		end,
	}, 

	-- {
	-- 	'declancm/cinnamon.nvim',
	-- 	config = function()
	-- 		require('cinnamon').setup()
	-- 	end,
	-- },
}
