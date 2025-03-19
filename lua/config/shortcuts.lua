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
-- reload config
map("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>") -- reload neovim config
-- Tab bindings
map("n", "<leader>t", ":tabnew<CR>")                         -- space+t creates new tab
map("n", "<leader>x", ":tabclose<CR>")                       -- space+x closes current tab
map("n", "<leader>j", ":tabprevious<CR>")                    -- space+j moves to previous tab
map("n", "<leader>k", ":tabnext<CR>")                        -- space+k moves to next tab
-- easy split generation
map("n", "<leader>v", ":vsplit")                             -- space+v creates a veritcal split
map("n", "<leader>s", ":split")                              -- space+s creates a horizontal split
-- easy split navigation
map("n", "<C-h>", "<C-w>h")                                  -- control+h switches to left split
map("n", "<C-l>", "<C-w>l")                                  -- control+l switches to right split
map("n", "<C-j>", "<C-w>j")                                  -- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k")                                  -- control+k switches to top split
-- buffer navigation
map("n", "<Tab>", ":bnext <CR>")                             -- Tab goes to next buffer
map("n", "<S-Tab>", ":bprevious <CR>")                       -- Shift+Tab goes to previous buffer
map("n", "<leader>d", ":bd! <CR>")                           -- Space+d delets current buffer
-- adjust split sizes easier
map("n", "<C-Left>", ":vertical resize +3<CR>")              -- Control+Left resizes vertical split +
map("n", "<C-Right>", ":vertical resize -3<CR>")             -- Control+Right resizes vertical split -
-- Open netrw in 25% split in tree view
map("n", "<leader>e", ":25Lex<CR>")                          -- space+e toggles netrw tree view
-- Easy way to get back to normal mode from home row
map("i", "kj", "<Esc>")                                      -- kj simulates ESC
map("i", "jk", "<Esc>")                                      -- jk simulates ESC
-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")       -- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>")                               -- Sort highlighted text in visual mode with Control+S
map("v", "J", ":m '>+1<CR>gv=gv")                            -- Move current line down
map("v", "K", ":m '>-2<CR>gv=gv")                            -- Move current line up
