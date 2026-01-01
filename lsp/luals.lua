return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".emmyrc.json",
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	diagnostics = {
		-- Get the language server to recognize the `vim` global
		globals = {
			'vim',
			'require'
		},
	},
	workspace = {
		-- Make the server aware of Neovim runtime files
		library = vim.api.nvim_get_runtime_file("", true),
	},
	settings = {
		Lua = {
			codeLens = { enable = true },
			hint = { enable = true, semicolon = "Disable" },

			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			runtime = {
				version = 'LuaJIT',
			}
		}
	}

}
