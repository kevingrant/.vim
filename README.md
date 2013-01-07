# Vim Configuration

## Installation

    git clone https://github.com/kevingrant/.vim.git ~/.vim
    rm ~/.vimrc && ls -s ~/.vim/vimrc ~/.vimrc
    rm ~/.gvimrc && ls -s ~/.vim/gvimrc ~/.gvimrc
    cd ~/.vim
    git submodule init
    git submodule update

## Updating Submodules

    cd ~/.vim
    git submodule foreach git pull origin master
