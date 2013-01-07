# Vim Configuration

## Installation

    git clone https://github.com/kevingrant/.vim.git ~/.vim
    rm ~/.vimrc; ln -s ~/.vim/vimrc ~/.vimrc
    rm ~/.gvimrc; ln -s ~/.vim/gvimrc ~/.gvimrc
    cd ~/.vim
    git submodule init
    git submodule update

## Updating Submodules

    cd ~/.vim
    git submodule foreach git pull origin master
