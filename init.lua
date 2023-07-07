vim.go.termguicolors = true
vim.go.t_Co = "256"
vim.go.t_ut = ""

vim.g.python3_host_prog = "/usr/bin/python3.10"
require("plugins")
require("config.alpha")
require("config.appearance")
require("config.latex")
require("config.shortcuts")
require("config.telescope")
require("config.treesitter") -- Path: config/treesitter.lua does not work in plugin file
