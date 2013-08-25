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
set completeopt-=preview
set list
set list listchars=tab:»·

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

" Uppercase word after typing it in insert mode
imap <C-u> <Esc>viwUea

" Save with sudo permissions
cnoremap w!! w !sudo tee % > /dev/null

" Back to normal mode
imap kk <Esc>

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
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']

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

" Insert block braces
inoremap {{ {<CR>}<Esc>O

" Undo/Redo
noremap <C-z> u
noremap <C-y> <C-r>
inoremap <C-z> <C-o>u<Esc>

func! InsertPythonBreakpoint()
  exe "normal! Oimport pdb; pdb.set_trace()\<Esc>^"
endfun

augroup filetypes
  au!
  au FileType python nnoremap <buffer> <leader>k :call InsertPythonBreakpoint()<CR>
  " Do not auto insert the comment leader after 'o' or 'O',
  " and remove comment leader when joining lines.
  au FileType c,cpp,go setlocal formatoptions-=o formatoptions+=qrj
  " Do not auto-wrap comments using textwidth.
  au FileType go setlocal formatoptions-=c
  au FileType go setlocal noexpandtab textwidth=0
  au FileType go nnoremap <buffer> <leader>h :Godoc<CR>
  au FileType go nnoremap <buffer> <leader>f :Fmt<CR>:w<CR>
  au BufWritePre *.go Fmt
augroup END

nnoremap <leader>l :Lint<CR>

func! DiffSetup()
  set nofoldenable foldcolumn=0 number
  wincmd b
  set nofoldenable foldcolumn=0 number
  if has("gui_running")
    let &columns = 180
    let &lines = 80
    wincmd =
    winpos 0 0
  endif
endfun

if &diff
  autocmd VimEnter * call DiffSetup()
endif

highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
augroup trailing
  au!
  au BufWinEnter * match TrailingWhitespace /\s\+$/
  au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match TrailingWhitespace /\s\+$/
  au BufWinLeave * call clearmatches()
augroup END

set statusline=
set statusline+=%t     " tail of filename
set statusline+=%#identifier#
set statusline+=%r     " read only flag
set statusline+=%m     " modified flag
set statusline+=%*
set statusline+=%#warningmsg#
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%{StatuslineLongLineWarning()}
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=     " right align
set statusline+=%c,    " cursor column
set statusline+=%l/%L  " cursor line/total lines
set laststatus=2       " always display status line

" recalculate when idle and after saving
augroup status
  au!
  au cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
  au cursorhold,bufwritepost * unlet! b:statusline_long_line_warning
augroup END

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
