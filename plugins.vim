" a.vim alternate files
nnoremap <silent> <leader>a :A<CR>
let g:alternateExtensions_cpp = "inl,inc,h,hpp"
let g:alternateExtensions_inl = "h,hpp,c,cpp"
let g:alternateExtensions_inc = "h,hpp,c,cpp"
let g:alternateNoDefaultAlternate = 1
let g:alternateSearchPath = 
    \ 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc,sfr:..,sfr:src'

" indent-object
omap am <Plug>ai_IndentObject
omap im <Plug>ii_IndentObject
vmap am <Plug>vai_IndentObject
vmap im <Plug>vii_IndentObject
omap aM <Plug>aI_IndentObject
omap iM <Plug>iI_IndentObject
vmap aM <Plug>vaI_IndentObject
vmap iM <Plug>viI_IndentObject

" Ctrl-P
nnoremap <silent> <C-b> :CtrlPBuffer<CR>
nnoremap <silent> <C-o> :CtrlPMRUFiles<CR>
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 2
let g:ctrlp_root_markers = ['.p4config']
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|art$\|bin$\|
               \build$\|coverage$\|development_temp_files$\|
               \docs$\|playable$\|sdks$\|tools$',
    \ 'file': '\.exe$\|\.so$\|\.dll$|\.a$|.png$' }
let g:ctrlp_prompt_mappings = {
    \ 'PrtClear()':           ['<c-c>'],
    \ 'PrtSelectMove("j")':   ['<c-e>', '<down>'],
    \ 'PrtSelectMove("k")':   ['<c-u>', '<up>'],
    \ 'PrtCurStart()':        ['<c-l>'],
    \ 'PrtCurEnd()':          ['<c-y>'],
    \ 'PrtCurRight()':        ['<right>'],
    \ 'CreateNewFile()':      [],
    \ 'PrtExit()':            ['<esc>', '<c-g>'],
    \ }

" NERD Commenter
let g:NERDSpaceDelims = 1

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" surround
let g:surround_no_mappings = 1
nmap ds <Plug>Dsurround
nmap ts <Plug>Csurround
xmap S <Plug>VSurround

" syntastic
let g:syntastic_python_flake8_args='--ignore=E111'

" Tagbar
let g:tagbar_compact = 1
nnoremap <silent> <Leader>t :TagbarOpen fj<CR>

