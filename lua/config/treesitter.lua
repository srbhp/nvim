require("nvim-treesitter.configs").setup({
		-- rainbow parentheses
		--rainbow = {
		-- enable = true,
		-- extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		-- max_file_lines = nil, -- Do not enable for files with more than n lines, int
		--},
		--
		highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
				enable = true,
				keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
				},
		},
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		indent = { enable = true },
		auto_install = true,
})
