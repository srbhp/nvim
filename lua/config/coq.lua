vim.g.coq_settings = {
		auto_start = "shut-up",
		keymap = {
				recommended = true,
				-- jump_to_mark = "<tab>", -- <c-f> is default
		},
		clients = {
				tabnine = {
						enabled = true,
				},
				lsp = {
						enabled = true,
				},
				snippets = {
						enabled = true,
				},
		},
		display = {
				pum = {
						fast_close = false,
				},
				ghost_text = {
						enabled = true,
						context = { " 《 ", " 》" },
				},
				preview = {
						border = "rounded",
				},
		},
}
