set nocompatible

filetype on
filetype plugin on
filetype indent on
syntax on

set t_Co=256           " 256 color terminal
set background=dark
colorscheme molokai
hi MatchParen cterm=bold ctermbg=none ctermfg=none

set backupdir=~/tmp
set noswapfile
set shortmess+=I

set autoread
set autowrite
set hidden

set statusline=
set statusline+=%t     " tail of filename
set statusline+=%#identifier#
set statusline+=%r     " read only flag
set statusline+=%m     " modified flag
set statusline+=%*
set statusline+=%#warningmsg#
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%{StatuslineLongLineWarning()}
set statusline+=%*
set statusline+=%=     " right align
set statusline+=%c,    " cursor column
set statusline+=%l/%L  " cursor line/total lines
set laststatus=2       " always display status line

" recalculate when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

set scrolloff=3
set noshowcmd
set number

set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab
set cindent

set wrap         " wrap long lines
set linebreak    " wrap lines at word boundaries
set textwidth=80
set formatoptions=c1
set colorcolumn=81
set nolist
set listchars=trail:-

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nohlsearch

set wildchar=<Tab>
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,*.a
set wildmenu
set wildmode=full

let mapleader = ","

" Source vimrc
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" Clear search highlight
nnoremap <Space> :noh<CR>

" Quick buffer selection
nnoremap <leader>b :ls<CR>:b<Space>

" Very magic regex search
nnoremap / /\v
vnoremap / /\v

nnoremap <Return> o<Esc>

" Delete a line without overwriting the yanked text
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Copy/paste to system clipboard
vnoremap <C-c> "+y
noremap <C-v> "+gP
cmap <C-v> <C-r>+
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']

" Undo/Redo
noremap <C-z> u
noremap <C-y> <C-r>
inoremap <C-z> <C-o>u
inoremap <C-y> <C-o><C-r>

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return a warning for "long lines" where "long" is either &textwidth
"or 80 (if no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'),
        \ 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

