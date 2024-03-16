-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


-- ####################################################
require('lazy').setup({

		-- "gc" to comment visual regions/lines
		{ 'numToStr/Comment.nvim', opts = {} },
		-- See `:help gitsigns` to understand what the configuration keys do
		{ -- Adds git related signs to the gutter, as well as utilities for managing changes
				'lewis6991/gitsigns.nvim',
				opts = {
						signs = {
								add = { text = '+' },
								change = { text = '~' },
								delete = { text = '_' },
								topdelete = { text = '‾' },
								changedelete = { text = '~' },
						},
				},
		},
		{ -- Fuzzy Finder (files, lsp, etc)
				'nvim-telescope/telescope.nvim',
				event = 'VimEnter',
				-- branch = '0.1.x',
				dependencies = {
						'nvim-lua/plenary.nvim',
						{ -- If encountering errors, see telescope-fzf-native README for install instructions
								'nvim-telescope/telescope-fzf-native.nvim',

								-- `build` is used to run some command when the plugin is installed/updated.
								-- This is only run then, not every time Neovim starts up.
								build = 'make',
								-- `cond` is a condition used to determine whether this plugin should be
								-- installed and loaded.
								cond = function()
									return vim.fn.executable 'make' == 1
								end,
						},
						{ 'nvim-telescope/telescope-ui-select.nvim' },
						-- Useful for getting pretty icons, but requires a Nerd Font.
						{ 'nvim-tree/nvim-web-devicons', },
				},
				config = function()
					require('telescope').setup {
							extensions = {
									['ui-select'] = {
											require('telescope.themes').get_dropdown(),
									},
							},
					}

					-- Enable telescope extensions, if they are installed
					pcall(require('telescope').load_extension, 'fzf')
					pcall(require('telescope').load_extension, 'ui-select')

					-- See `:help telescope.builtin`
					local builtin = require 'telescope.builtin'
					vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
					vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
					vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
					vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
					vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
					vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
					vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
					vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
					vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
					vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

					-- Slightly advanced example of overriding default behavior and theme
					vim.keymap.set('n', '<leader>/', function()
						-- You can pass additional configuration to telescope to change theme, layout, etc.
						builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
								winblend = 10,
								previewer = false,
						})
					end, { desc = '[/] Fuzzily search in current buffer' })

					-- Also possible to pass additional configuration options.
					--  See `:help telescope.builtin.live_grep()` for information about particular keys
					vim.keymap.set('n', '<leader>s/', function()
						builtin.live_grep {
								grep_open_files = true,
								prompt_title = 'Live Grep in Open Files',
						}
					end, { desc = '[S]earch [/] in Open Files' })

					-- Shortcut for searching your neovim configuration files
					vim.keymap.set('n', '<leader>sn', function()
						builtin.find_files { cwd = vim.fn.stdpath 'config' }
					end, { desc = '[S]earch [N]eovim files' })
				end,
		},
		{ -- LSP Configuration & Plugins
				'neovim/nvim-lspconfig',
				dependencies = {
						-- Automatically install LSPs and related tools to stdpath for neovim
						'williamboman/mason.nvim',
						'williamboman/mason-lspconfig.nvim',
						'WhoIsSethDaniel/mason-tool-installer.nvim',

						-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
						-- used for completion, annotations and signatures of Neovim apis
						{ 'folke/neodev.nvim', opts = {} },
				},
				config = function()
					require("config.lsp")
				end,

		},
		--
		{
				"rose-pine/neovim",
				as = "rose-pine",
				config = function()
					require("rose-pine").setup({
							--- @usage 'main' | 'moon'
							dark_variant = "moon",
					})
					vim.cmd("colorscheme rose-pine")
				end,
		},
		-- IndentLine
		{
				"lukas-reineke/indent-blankline.nvim",
				-- event = "BufRead",
				-- event = "BufReadPre",
				-- after = "nvim-treesitter",
				config = function()
					require("config.indentblankline")
				end,
		},
		{
				"goolord/alpha-nvim",
		},

		{
				"nvim-lualine/lualine.nvim",
				-- event = "VimEnter",
				-- after = "nvim-treesitter",
				config = function()
					require("config.lualine")
				end,
				wants = "nvim-web-devicons",
		},
		{
				"kyazdani42/nvim-web-devicons",
		},
		-- Code analysis , linter, Auto complete
		-- completion using builtin LSP
		{
				"windwp/nvim-autopairs",
		}, --  for (){}[]
		-- "----------------------------LSP Tools
		-- Code documentation
		-- Treesitter
		{
				"nvim-treesitter/nvim-treesitter",
				config = function()
					require("config.treesitter")
				end,
		},

		-- Completion
		{
				"ms-jpq/coq_nvim",
				branch       = "coq",
				lazy         = false,
				build        = ":COQdeps",
				-- event = "VimEnter",
				-- opt = true,
				-- run = ":COQdeps",
				init         = function()
					require("config.coq")
				end,
				dependencies = {
						{ "ms-jpq/coq.artifacts",  branch = "artifacts" },
						{ "ms-jpq/coq.thirdparty", branch = "3p" },
				},
		},
		-- lsp
		{
				"neovim/nvim-lspconfig",
				-- opt = true,
				-- event = "VimEnter",
				-- event = { "BufReadPre" },
				config = function()
					require("config.lsp")
				end,
				dependencies = {
						"nvim-lua/plenary.nvim",
				},
		},

		--####################################END
})
