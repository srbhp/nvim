vim.cmd([[autocmd ColorScheme * highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[autocmd ColorScheme * highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[autocmd ColorScheme * highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[autocmd ColorScheme * highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[autocmd ColorScheme * highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[autocmd ColorScheme * highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↴")
vim.opt.lcs = "tab:░░░"
require("indent_blankline").setup({
	char = "┊",
	space_char_blankline = " ",
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
	show_current_context_start_on_current_line = true,
	use_treesitter_scope = true,
	show_current_context = true,
	show_current_context_start = true,
	use_treesitter = true,
	char_list = { "|", "¦", "┆", "┊" },
	context_char_list = { "┃", "║", "╬", "█" },
	space_char_blankline_highlight_list = { "Error", "Function" },
})
