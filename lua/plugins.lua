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
	},
	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		-- branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ -- If encountering errors, see telescope-fzf-native README for install instructions
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'nvim-tree/nvim-web-devicons', },
		},
		config = function()
			-- require("config.telescope")
		end,
	},
	{ -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
		},
		config = function()
			require("config.lsp")
		end,

	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
			})
			vim.cmd.colorscheme "catppuccin"
		end,

	},
	--
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" }, -- optional
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
		},
	},
	-- IndentLine
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("config.ibl")
		end,
	},
	{
		"goolord/alpha-nvim",
	},

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.lualine")
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = 'InsertEnter',
	}, --  for (){}[]
	-- "----------------------------LSP Tools
	-- Code documentation
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ':TSUpdate',
		opts = {
			ensure_installed = {
				'bash',
				'bibtex',
				'c',
				'cmake',
				'cpp',
				'comment',
				'latex',
				'lua',
				'make',
				'markdown',
				'ninja',
				'python',
				'regex',
				'todotxt',
				'vim',
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			indent = { enable = true },
			auto_install = true,


		},
		config = function()
			require("config.treesitter")
		end,
	},
	-- Completion
	{
		"ms-jpq/coq_nvim",
		branch       = "coq",
		lazy         = false,
		-- build        = ":COQdeps",
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
	-- End of plugins
	--####################################END
})
