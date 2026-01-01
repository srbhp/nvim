vim.go.termguicolors = true
-- vim.go.t_Co = "256"
-- vim.go.t_ut = ""

require("plugins")
require("config.alpha")
require("config.appearance")
require("config.latex")
require("config.shortcuts")
require("config.telescope")
-- Path: config/treesitter.lua does not work in plugin file
require("config.treesitter")
-- add neovim buildin lsp
require("config.lsp")
vim.lsp.enable({"ty", "clangd","ruff","luals"})
