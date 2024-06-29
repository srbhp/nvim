-- Define signs
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " "(❌) }
-- local signs = { Error = "🔥", Warn = "⚠️ ", Hint = "🇦", Info = "ℹ️" }
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=orange ]])

-- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=#5f0a0a guibg=#1f2335]])
-- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder2 guifg=red ]])
-- local border = {
-- 	{ "▛", "FloatBorder" },
--
-- 	{ "▀", "FloatBorder" },
-- 	{ "▜", "FloatBorder" },
--
-- 	{ "▐", "FloatBorder" },
-- 	{ "▟", "FloatBorder" },
--
-- 	{ "▄", "FloatBorder" },
--
-- 	{ "▙", "FloatBorder" },
-- 	{ "▌", "FloatBorder" },
-- }
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
		{ "▔",  "FloatBorder" },
		{ "🭾", "FloatBorder" },
		{ "▕",  "FloatBorder" },
		{ "🭿", "FloatBorder" },
		{ "▁",  "FloatBorder" },
		{ "🭼", "FloatBorder" },
		{ "▏",  "FloatBorder" },
}


local servers = {
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
		lua_ls = {
				settings = {
						Lua = {
								runtime = {
										-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
										version = "LuaJIT",
								},
								diagnostics = {
										-- Get the language server to recognize the `vim` global
										globals = { "vim" },
								},
								workspace = {
										-- Make the server aware of Neovim runtime files
										-- library = vim.api.nvim_get_runtime_file("", true),
										checkThirdParty = true,
										library = {
												vim.env.VIMRUNTIME,
										},
								},
								-- Do not send telemetry data containing a randomized but unique identifier
								telemetry = {
										enable = false,
								},
						},
				},
		},
		bashls = {},
		vimls = {},
		ruff = {},
		pylsp = {
				pylsp = {
						plugins = {
								-- formatter options
								black = {
										enabled = false
								},
								autopep8 = {
										enabled = false
								},
								yapf = {
										enabled = false
								},
								-- linter options
								pylint = {
										enabled = true,
								},
								ruff = { enabled = false },
								pyflakes = { enabled = false },
								pycodestyle = { enabled = false },
								-- type checker
								pylsp_mypy = {
										enabled = true,
										-- overrides = { "--python-executable", py_path, true },
										report_progress = true,
										live_mode = false
								},
								-- auto-completion options
								jedi_completion = { fuzzy = true },
								-- import sorting
								isort = { enabled = true },
						},
				},
		},
		cmake = {},
		texlab = {
				settings = {
						texlab = {
								--auxDirectory = "/tmp/.",
								--bibtexFormatter = "texlab",
								build = {
										--args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-pv" },
										--args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
										-- executable = "tectonic",
										args = { "-lualatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
										forwardSearchAfter = true,
										onSave = true,
										isContinuous = true,
								},
								chktex = {
										onEdit = true,
										onOpenAndSave = true,
								},
								diagnosticsDelay = 10,
								formatterLineLength = 80,
								forwardSearch = {
										-- executable = "okular",
										-- args = { "--unique", "--noraise", "file:%p#src:%l%f" },
										-- executable = "zathura",
										-- args = { "--synctex-forward", "%l:1:%f", "%p" },
										executable = "evince-synctex",
										args = { "-f", "%l", "%p", '"code -g %f:%l"' },
										onSave = true,
								},
								latexFormatter = "latexindent",
								latexindent = {
										modifyLineBreaks = true,
								},
						},
				},
		},
		textlsp = {
				settings = {
						textLSP = {
								analysers = {
										languagetool = {
												enabled = true,
												check_text = {
														on_open = true,
														on_save = true,
														on_change = true,
												},
										},
										gramformer = {
												-- gramformer dependency needs to be installed manually
												enabled = true,
												gpu = true,
												check_text = {
														on_open = true,
														on_save = true,
														on_change = true,
												},
										},
										openai = {
												enabled = true,
												api_key = "<MY_API_KEY>",
												check_text = {
														on_open = false,
														on_save = false,
														on_change = false,
												},
												-- model = 'text-ada-001',
												model = "text-babbage-001",
												-- model = 'text-curie-001',
												-- model = 'text-davinci-003',
												edit_model = "text-davinci-edit-001",
												max_token = 16,
										},
										grammarbot = {
												enabled = false,
												api_key = "<MY_API_KEY>",
												-- longer texts are split, this parameter sets the maximum number of splits per analysis
												input_max_requests = 1,
												check_text = {
														on_open = false,
														on_save = false,
														on_change = false,
												},
										},
								},
								documents = {
										org = {
												org_todo_keywords = {
														"TODO",
														"IN_PROGRESS",
														"DONE",
												},
										},
								},
						},
				},
		},
		rust_analyzer = {},
		-- pyright = {},
}
local lspconfig = require("lspconfig")
for name, config in pairs(servers) do
	--lspconfig[lsp].setup {
	-- on_attach = my_custom_on_attach,
	-- capabilities = capabilities,
	--}
	-- This is for Coq complication
	lspconfig[name].setup(require("coq").lsp_ensure_capabilities({ settings = config }))
end

--------------------------------------

vim.diagnostic.config({
		underline = true,
		signs = true,
		virtual_text = true,
		-- virtual_text = { source = true, prefix = "", format = rightAlignFormatFunction, spacing = 0 },
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
		severity_sort = true, -- default to false
})
--
vim.o.updatetime = 10
-- Code lens
-- vim.cmd[[ autocmd BufEnter,CursorHold,InsertLeave * lua vim.lsp.codelens.refresh()]]
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once

-- vim.api.nvim_command([[autocmd CursorHold,CursorHoldI *
--     lua vim.diagnostic.open_float({scope="line",pos=2}, {focus=false})]])
-- vim.cmd[[autocmd CursorHold * lua vim.lsp.buf.code_action()]]
vim.api.nvim_command([[autocmd CursorHold * silent! lua vim.lsp.buf.hover()]])
-- vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])

vim.cmd([[autocmd! CursorHold * lua vim.diagnostic.open_float(nil,{})]])
-- vim.cmd([[autocmd DiagnosticChanged * lua vim.diagnostic.setqflist() ]])
vim.api.nvim_command([[autocmd BufWritePre * lua vim.lsp.buf.format({ })]])

-- vim.api.nvim_command([[autocmd BufWritePre * lua vim.lsp.buf.formatting({ })]])
vim.api.nvim_command([[autocmd CursorHold *tex  silent! TexlabForward]])
