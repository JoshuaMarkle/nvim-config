-- LSP configuration & plugins

return {
	'neovim/nvim-lspconfig',
	enabled = true,
	lazy = true,
	event = 'BufReadPre',
	dependencies = {
		-- Additional lua configuration
		{
			'folke/neodev.nvim',
			config = function()
				require('neodev').setup()
			end,
		},

		'williamboman/mason-lspconfig.nvim',
	},
	config = function()
		local on_attach = function(_, bufnr) end
		local nmap = function(keys, func, desc)
			if desc then
				desc = 'LSP: ' .. desc
			end
			vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
		end

		nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
		nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

		nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
		nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
		nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
		nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
		nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
		nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

		-- See `:help K` for why this keymap
		nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
		nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

		-- Lesser used LSP functionality
		nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
		nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
		nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
		nmap('<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, '[W]orkspace [L]ist Folders')

		-- Enable the following language servers
		local servers = {
			clangd = {},
			pyright = {},
			-- rust_analyzer = {},
			-- gopls = {},
			-- tsserver = {},
			html = { filetypes = { 'html', 'twig', 'hbs' } },
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		}

		-- Setup mason stuff
		require('mason').setup()
		local mason_lspconfig = require 'mason-lspconfig'

		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}

		mason_lspconfig.setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}
			end,
		}
	end,
}
