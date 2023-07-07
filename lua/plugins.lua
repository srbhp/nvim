local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	local PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- luacheck: globals packer_plugins
vim.cmd([[packadd packer.nvim]])
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua  source <afile>| PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
	-------------------------Appearance
	use("wbthomason/packer.nvim")
	--
	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("rose-pine").setup({
				--- @usage 'main' | 'moon'
				dark_variant = "moon",
			})
			vim.cmd("colorscheme rose-pine")
		end,
	})

	-- IndentLine
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		-- event = "BufReadPre",
		after = "nvim-treesitter",
		config = function()
			require("config.indentblankline")
		end,
	})
	use({
		"goolord/alpha-nvim",
	})

	use({
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		after = "nvim-treesitter",
		config = function()
			require("config.lualine")
		end,
		wants = "nvim-web-devicons",
	})
	use({
		"kyazdani42/nvim-web-devicons",
		module = "nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	})
	-- Code analysis , linter, Auto complete
	-- completion using builtin LSP
	use({
		"windwp/nvim-autopairs",
		wants = "nvim-treesitter",
		module = { "nvim-autopairs" },
		config = function()
			require("nvim-autopairs").setup({})
		end,
	}) --  for (){}[]
	-- "----------------------------LSP Tools
	-- Code documentation
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
		cmd = { "Neogen" },
	})
	-- Git Integration
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		wants = "plenary.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		-- opt = true,
		-- event = "BufRead",
		-- run = function()
		-- 	local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		-- 	ts_update()
		-- end,
		-- config = function()
		-- 	require("config.treesitter")
		-- end,
	})
	-- " TSInstallSync cpp bash cmake latex regex  vim lua python bibtex
	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = {
						preview_cutoff = 120,
					},
					--    previewer = false, layout_strategy = "vertical"
				},
			})
		end,
	})

	-- Completion
	use({
		"ms-jpq/coq_nvim",
		branch = "coq",
		-- event = "VimEnter",
		-- opt = true,
		-- run = ":COQdeps",
		config = function()
			require("config.coq")
		end,
		requires = {
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		},
	})
	-- lsp
	use({
		"neovim/nvim-lspconfig",
		-- opt = true,
		-- event = "VimEnter",
		-- event = { "BufReadPre" },
		wants = {
			"coq_nvim",
		}, -- for coq.nvim
		config = function()
			require("config.lsp")
		end,
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	-- floating terminal window for neovim written in lua
	-- commenting
	use({
		"numToStr/Comment.nvim",
		keys = { "gc", "gcc", "gbc" },
		config = function()
			require("Comment").setup()
		end,
	})
	--Markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_auto_start = 1
			vim.g.mkdp_command_for_global = 1
			vim.g.mkdp_open_to_the_world = 1
			vim.g.mkdp_theme = "light"
		end,
		ft = { "markdown" },
	})
	------End of PAcker
end)
