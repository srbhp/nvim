# neovim config

Personal Neovim config

Most of the stuff are copied from the internet.

### Getting Started

Install latest stable version of Neovim ( currently 0.9.5 ). We can 
also install using the system package manager(apt/yum/zypper).
```bash
	cd ~/bin
	wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
	mv nvim.appimage nvim
	chmod +x nvim
	# add ~/bin to your PATH : export PATH=$PATH:~/bin
```

### Dependencies : 

To add support for many of the Language Server Protocol (LSP)

features i.e., Formatting, Code action, Documents we need 

few packages which add this functionality. Programming Languages 

that I use.

| Language  | Package | How to Install |
| ---------- | ------- | --------------- |
| c/c++  	|	clangd| (apt/yum/dnf/zypper) install clangd| 
| Lua    	|	lua_ls|https://luals.github.io/#neovim-install | 
| Bash   	|	bashls|https://github.com/bash-lsp/bash-language-server | 
| Vim Script|  vimls|https://github.com/iamcco/vim-language-server |
| Python	|	pylsp |`pip install python-lsp-server`|
| CMake     | 	cmake| `pip install cmake-language-server` |
| Latex | 	    texlab|https://github.com/latex-lsp/texlab| 
| Text  |	    textls|https://github.com/hangyav/textLSP| 

##  List of Vim/Neovim Plugins

                packer.nvim - Total plugins: 14


     • Comment.nvim (not loaded)
     • alpha-nvim
     • coq.artifacts
     • coq_nvim
     • indent-blankline.nvim (not loaded)
     • lualine.nvim
     • nvim-autopairs (not loaded)
     • nvim-lspconfig
     • nvim-treesitter
     • nvim-web-devicons
     • packer.nvim
     • plenary.nvim
     • rose-pine
     • telescope.nvim


 **`(not loaded )` plugins are lazy loaded **



 ![Screenshots](nvim.png)
