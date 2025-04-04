vim.go.termguicolors = true
-- vim.go.t_Co = "256"
-- vim.go.t_ut = ""

-- vim.g.python3_host_prog = "~/.venv/bin/python" --change the default python path
require("plugins")
require("config.alpha")
require("config.appearance")
require("config.latex")
require("config.shortcuts")
require("config.telescope")
-- Path: config/treesitter.lua does not work in plugin file
require("config.treesitter")
