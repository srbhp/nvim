#!/bin/bash

# install the config
mkdir ~/.config/
cd ~/.config/ || exit
git clone https://github.com/srbhp/nvim.git
sudo apt install clangd vim git cmake python3-venv luarocks tree-sitter-dev fd-find ripgrep gdb ninja-build
# install neovim
mkdir -p ~/.local/bin/
cd ~/.local/bin || exit
wget https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage nvim
chmod +x nvim
export PATH=$PATH:~/.local/bin #  add ~/.local/bin to your PATH . Add this line to your ~/.bashrc
cd ~/ || exit
# run neovim to install plugins
nvim +'Lazy update' +q
# tar all plugins
tar -cvf neovim-share.tar.gz ~/.local/share/nvim
