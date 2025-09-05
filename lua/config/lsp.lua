-- Define signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=orange ]])

-- local border = "double"

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
		end

		map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

		-- Find references for the word under your cursor.
		map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

		map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
		map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
		map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
		map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
		map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
		map('K', vim.lsp.buf.hover, 'Hover Documentation')
		map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})





local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}
vim.lsp.enable('luals')

local servers = { 
	ty = {},
	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--clang-tidy-checks=*",
			"--header-insertion=iwyu",
			"--enable-config",
		},
	},
	bashls = {},
	vimls = {},
	ruff = {},
	pylsp = {},
	cmake = {},
	rust_analyzer = {},
	pyright = {},
}
local lspconfig = require("lspconfig")
for name, config in pairs(servers) do
	--lspconfig[lsp].setup {
	-- on_attach = my_custom_on_attach,
	-- capabilities = capabilities,
	--}
	-- This is for Coq complication
	-- lspconfig[name].setup(require("coq").lsp_ensure_capabilities({ settings = config }))
	vim.lsp.config(name , {settings = config}) 
	vim.lsp.enable(name) 
	-- vim.lsp.enable(require("coq").lsp_ensure_capabilities({ settings = config }))
end
--------------------------------------

vim.diagnostic.config({
	underline = true,
	-- signs = true,
	signs = {
		text = { "", "", "", "", },
	},
	virtual_text = true,
	float = {
		show_header = true,
		source = true,
		border = border,
		focus = false,
		scope = "line",
		-- width = 60,
		max_height = 5,
		max_width = 60,
		-- pos=15,
	},
	update_in_insert = true, -- default to false
	severity_sort = true,   -- default to false
})
--
vim.o.updatetime = 10
-- Code lens
-- vim.cmd[[ autocmd BufEnter,CursorHold,InsertLeave * lua vim.lsp.codelens.refresh()]]
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.api.nvim_command([[autocmd CursorHold * silent! lua vim.lsp.buf.hover()]])
-- vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])

vim.cmd([[autocmd! CursorHold * lua vim.diagnostic.open_float(nil,{})]])
-- vim.cmd([[autocmd DiagnosticChanged * lua vim.diagnostic.setqflist() ]])
vim.api.nvim_command([[autocmd BufWritePre * lua vim.lsp.buf.format({ })]])

-- vim.api.nvim_command([[autocmd BufWritePre * lua vim.lsp.buf.formatting({ })]])
vim.api.nvim_command([[autocmd CursorHold *tex  silent! TexlabForward]])
-- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
