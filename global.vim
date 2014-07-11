set nocompatible

filetype on
filetype plugin on
filetype indent on
syntax on

set t_Co=256           " 256 color terminal
set background=dark
colorscheme molokai
hi MatchParen cterm=bold ctermbg=none ctermfg=none

set noswapfile
set shortmess+=I

set autoread
set hidden

set scrolloff=3
set noshowcmd
set number

set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab

set wrap         " wrap long lines
set linebreak    " wrap lines at word boundaries
set textwidth=80
set formatoptions=c1
set colorcolumn=81
set completeopt-=preview
set list
set list listchars=tab:»·
set laststatus=2 " always display status line

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nohlsearch

set spelllang=en_us
hi SpellBad   cterm=none ctermbg=none ctermfg=DarkRed
hi SpellLocal cterm=none ctermbg=none ctermfg=DarkRed
hi SpellRare  cterm=none ctermbg=none ctermfg=DarkRed

set wildchar=<Tab>
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,*.a
set wildmenu
set wildmode=full

let mapleader = ","

" Scroll line
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Toggle spell check
nnoremap <leader>sp :setlocal spell!<CR>

" Clear search highlight
nnoremap <Space> :noh<CR>

" Quick save/quit
nnoremap <leader>, :w<CR>
nnoremap <leader>q :qa<CR>

" Delete buffer without closing window
nnoremap <leader>b :bp\|bd #<CR>

" Format paragraph
nnoremap Q gqap
vnoremap Q gq

" Very magic regex search
nnoremap / /\v
vnoremap / /\v

" Insert newline without leaving normal mode
nnoremap <Return> o<Esc>

" Find conflict
nnoremap <leader>x />>>><CR>zz

" Copy/paste to system clipboard
vnoremap <C-c> "+y
noremap <C-v> "+gP
cmap <C-v> <C-r>+
inoremap <C-v> <C-o>"+p

" Toggle paste mode
set pastetoggle=<F9>
augroup paste
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

" Visual bloCk mode
nnoremap C <C-v>

" Dot to pointer
nnoremap <leader>p s-><Esc>
nnoremap <leader>P 2s.<Esc>

" Undo/Redo
noremap <C-z> u
noremap <C-y> <C-r>
inoremap <C-z> <C-o>u<Esc>

func! InsertPythonBreakpoint()
  exe "normal! Oimport pdb; pdb.set_trace()\<Esc>^"
endfun

augroup filetypes
  au!
  au FileType python nnoremap <buffer> <leader>k
    \ :call InsertPythonBreakpoint()<CR>

  au FileType c,cpp setlocal cindent
  " Do not auto insert the comment leader after 'o' or 'O',
  " and remove comment leader when joining lines.
  au FileType c,cpp,go setlocal formatoptions-=o formatoptions+=qrj
  " Insert block braces
  au FileType c,cpp,go inoremap <buffer> {{ {<CR>}<Esc>O

  " Do not auto-wrap comments using textwidth.
  au FileType go setlocal formatoptions-=c
  au FileType go setlocal noexpandtab textwidth=0
  au FileType go nnoremap <buffer> <leader>h :Godoc<CR>
  au FileType go nnoremap <buffer> <leader>f :Fmt<CR>:w<CR>
  au FileType go au BufWritePre <buffer> Fmt

  au BufReadPost quickfix setlocal cursorline
augroup END

func! LintErrors()
  execute 'Lint'
  botright cwindow
  cc
endfun

nnoremap <leader>l :call LintErrors()<CR>
nnoremap <C-l> :cn<CR>

func! DiffSetup()
  set nofoldenable foldcolumn=0 number
  wincmd b
  set nofoldenable foldcolumn=0 number
endfun

if &diff
  autocmd VimEnter * call DiffSetup()
endif

autocmd VimResized * wincmd =

highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
augroup trailing
  au!
  au BufWinEnter * match TrailingWhitespace /\s\+$/
  au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match TrailingWhitespace /\s\+$/
  au BufWinLeave * call clearmatches()
augroup END
