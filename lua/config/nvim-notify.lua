require("notify").setup({
	timeout = 100,
	fps = 60,
	max_height = 10,
	max_width = 60,
})
vim.notify = require("notify")
-- lsp status update
-- Utility functions shared between progress reports for LSP and DAP
