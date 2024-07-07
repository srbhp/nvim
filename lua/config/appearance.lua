-- vim.opt.guifont = "Fira Mono Regular Nerd Font Complete"

------------------------------------------
vim.g.loaded_ruby_provider = 0
--vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
-- vim.g.loaded_python_provider=0
-- vim.g.loaded_node_provider = 0
vim.opt.number = true
vim.opt.mouse = ""
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
--vim.cmd([[set clipboard+=unnamedplus]])
vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "UTF-8"
vim.opt.undofile = true
vim.opt.swapfile = true
vim.opt.tw = 80 -- textwidth
vim.opt.backup = true
vim.opt.dir = os.getenv("HOME") .. "/.vim/swap/"
vim.opt.writebackup = true
vim.opt.backupdir = os.getenv("HOME") .. "/.vim/backup/"
vim.opt.undofile = true --            " Save undo's after file closes
vim.opt.undolevels = 1000 --    " How many undos
vim.opt.undoreload = 10000 --      " number of lines to save for undo
vim.opt.textwidth = 0 -- " lines longer than 79 columns will be broken
vim.opt.shiftwidth = 2 -- " operation >> indents 4 columns; << unindents 4 columns
vim.opt.tabstop = 2 --  " a hard TAB displays as 4 columns
vim.opt.expandtab = false -- " insert spaces when hitting TABs
vim.opt.softtabstop = 4 --" insert/delete 4 spaces when hitting a TAB/BACKSPACE
-- Don't show the mode, since it's already in status line
vim.opt.showmode = false
-- Enable break indent
vim.opt.breakindent = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10


-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- spelling
-- vim.opt.spelllang = 'en_us'
-- vim.opt.spell = true

-- vim.opt.shiftround = true --    " round indent to multiple of 'shiftwidth'
-- vim.opt.wrap='linebreak nolist'
vim.opt.autochdir = true
-- vim.cmd([[autocmd BufWritePost *.py execute ":w !python3 % "]])
-- Templates
vim.cmd([[autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/one.cpp]])
vim.cmd([[autocmd BufNewFile *.hpp 0r ~/.config/nvim/templates/one.hpp]])
vim.cmd([[autocmd BufNewFile *.py 0r ~/.config/nvim/templates/one.py]])
vim.cmd([[autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/sample.tex]])
-- indentLine
--vim.cmd([[autocmd ColorScheme * highlight NormalFloat guibg=#004d2e]])
--vim.cmd([[autocmd ColorScheme * highlight FloatBorder guifg=red]])
vim.opt.termguicolors = true
-- lsp stuff
-- format
-- following options are the default
-- remember last position
vim.cmd(
		[[autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]] --luacheck: ignore
) --luacheck: ignore
vim.cmd("nmap p P")
------------------------------------------
vim.cmd([[nmap <F1> <nop>]])
--vim.cmd[[map  <F1> :Telescope find_files <CR>]]
vim.cmd([[nmap  <F1> :Telescope  oldfiles<CR>]])
vim.cmd([[tmap  <F1> :Telescope  oldfiles<CR>]])
-- vim.cmd([[imap  <F1> :Telescope  oldfiles<CR>]])
-- vim.cmd([[vmap  <F1> :Telescope  oldfiles<CR>]])
vim.opt.termguicolors = true
-- Auto pair
-- If you want insert `(` after select function or method item
--
vim.opt.modifiable = true -- in the term mode

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<F11>", [[<C-\><C-n> :ToggleTerm <CR> ]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
vim.cmd([[map   <F11> :ToggleTerm <CR>]]) -- Open terminal
-- fold line
-- fold settings
vim.o.foldlevel = 99
vim.o.foldcolumn = "1"
vim.wo.foldnestmax = 1
vim.wo.foldminlines = 1
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... '
	. '(' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.wo.foldmethod = "syntax"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.cmd("highlight Folded ctermbg=NONE guibg=NONE")
vim.cmd("highlight FoldColumn ctermfg=NONE guifg=NONE")

------------------------------------------
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldtext = [[substitute(getline(v:foldstart),
-- '\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
-- vim.wo.fillchars = "fold:\\"
-- vim.wo.foldnestmax = 3
-- vim.wo.foldminlines = 1
-- save fold settings
--set keymap to toggle fold

vim.cmd("hi DiagnosticVirtualTextError guifg=#db4b4b guibg=#2D202A")
vim.cmd("hi DiagnosticVirtualTextWarn  guifg=#e0af68 guibg=#2E2A2D")
vim.cmd("hi DiagnosticVirtualTextInfo  guifg=#0db9d7 guibg=#192B38")
vim.cmd("hi DiagnosticVirtualTextHint  guifg=#1abc9c guibg=#1A2B32")

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
