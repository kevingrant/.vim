set runtimepath+=$GOROOT/misc/vim
set runtimepath+=bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'a.vim'
Bundle 'kevingrant/argtextobj.vim'
Bundle 'kevingrant/vim-colemak'
Bundle 'kevingrant/vim-indent-object'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'molokai'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'

runtime global.vim
runtime plugins.vim
