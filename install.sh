#!/bin/bash

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -u ~/.vim/bundles.vim +BundleInstall +qa
