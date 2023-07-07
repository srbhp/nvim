local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<space>,", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<space>;", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<space>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<space>d", "<cmd>lua vim.lsp.buf.definition()<CR><CR>")
map("n", "<space>h", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<space>m", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<space>r", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<space>s", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
-- Buffers
map("n", "]", "<cmd>bn <CR>")
map("n", "[", "<cmd>bp <CR>")
-- Telescope
map("n", "ff", "<cmd>Telescope find_files <CR>")
map("n", "fo", "<cmd>Telescope oldfiles <CR>") -- luacheck: ignore
-- Set command line
vim.cmd([[command LspRename     lua vim.lsp.buf.rename()]])
vim.cmd([[command LspCodeAction lua vim.lsp.buf.code_action()]])
vim.cmd([[command LspHover      lua vim.lsp.buf.hover()]])
vim.cmd([[command LspDef        lua vim.lsp.buf.definition()]])
vim.cmd([[command LspReferenc   lua vim.lsp.buf.reference()]])
vim.cmd([[command LspNext       lua  vim.diagnostic.goto_next()]])
vim.cmd([[command LspPrev       lua vim.diagnostic.goto_prev()]])
--------------------------------------------------
