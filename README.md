# Neovim Configuration

![Plugins Badge](https://dotfyle.com/srbhp/nvim/badges/plugins?style=for-the-badge) ![Leader Key Badge](https://dotfyle.com/srbhp/nvim/badges/leaderkey?style=for-the-badge) ![Plugin Manager Badge](https://dotfyle.com/srbhp/nvim/badges/plugin-manager?style=for-the-badge)

## Setting Up Neovim for Python/C/C++ Development

Neovim is a powerful, modernized fork of Vim that is designed for developers who want a lightweight, yet extensible text editor. Its speed, versatility, and rich plugin ecosystem make it an excellent choice for Python development. In this blog post, we'll walk through the steps to set up Neovim for a seamless Python development experience.

![Screenshots](nvim.png)

### Getting Started

First, we need to get the latest stable version of Neovim (currently 0.10.0). We can also install it using the system package manager `(apt/yum/zypper) install neovim` or we can get it from GitHub.

```bash
mkdir -p ~/.local/bin/
cd ~/.local/bin
wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage
mv nvim.appimage nvim
chmod +x nvim
export PATH=$PATH:~/.local/bin #  add ~/.local/bin to your PATH . Add this line to your ~/.bashrc 
```

### Dependencies

To add support for many of the Language Server Protocol (LSP) features, i.e., Formatting, Code action, goto documentation, we need a few packages that add this functionality. Programming languages that I use:

| Language   | Package | How to Install |
| ---------- | ------- | --------------- |
| C/C++      | clangd  | (apt/yum/dnf/zypper) install clangd |
| Lua        | lua_ls  | https://luals.github.io/#neovim-install |
| Bash       | bashls  | https://github.com/bash-lsp/bash-language-server |
| Vim Script | vimls   | https://github.com/iamcco/vim-language-server |
| Python     | pylsp   | `pip install python-lsp-server[all]` |
| CMake      | cmake   | `pip install cmake-language-server` |
| Latex      | texlab  | https://github.com/latex-lsp/texlab |
| Text       | textls  | https://github.com/hangyav/textLSP |

#### Debian / Ubuntu 
    
``` bash 
    apt install clangd vim git cmake python3-venv luarocks tree-sitter-dev  fd-find ripgrep gdb ninja-build
```


### List of Neovim Plugins

There are thousands of Neovim plugins available on GitHub. Only use the ones that you need. Here are the plugins that I use.

### Install this config

1. Clone the repo

```bash
cd ~/.config/
git clone https://github.com/srbhp/nvim.git
```

2. Install Plugins

    Launch Neovim and run the following command to install the plugins:
    ```vim
    :Lazy
    ```

3. Install `coq_nvim` dependencies:
   This needs the `python3-venv` package to be installed.
   ```vim
    :COQdeps
   ```

4. Check Neovim Health

   ```vim
   :checkhealth
   ```
   This will give you the current status of Neovim and report if there are any missing dependencies.

### Development Container

To set up a development environment using a devcontainer, follow these steps:

1. Ensure you have Docker installed on your machine.
2. Open the project in a container using Visual Studio Code.
3. When prompted, select "Reopen in Container".

This will set up the development environment with all necessary dependencies and tools.
