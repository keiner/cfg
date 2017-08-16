"VUNDEL------------------------{{{

"set nocompatible              " be iMproved, required
"filetype off                  " required

 ""set the runtime path to include Vundle and initialize
 "set rtp+=~/.vim/bundle/Vundle.vim
 "call vundle#begin()
 "" alternatively, pass a path where Vundle should install plugins
 ""call vundle#begin('~/some/path/here')

 "" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'godlygeek/tabular' 



 "" All of your Plugins must be added before the following line
 "call vundle#end()            " required
 "filetype plugin indent on    " required
 "" Brief help
 "" :PluginList       "- lists configured plugins
 "" :PluginInstall    "- installs plugins; append `!` to update or just
 "" :PluginUpdate     "- Searches for Updates for all Plugins
 "" :PluginSearch foo "- searches for foo; append `!` to refresh local cache
 "" :PluginClean      "- confirms removal of unused plugins; append `!` to auto-approve removal
 ""
 "" see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
"}}} 
"PATHOGEN----------------------------------------{{{
execute pathogen#infect()
filetype plugin indent on 
"info unter https://github.com/tpope/vim-pathogen
"}}}
"NERDTree------------------{{{ 
augroup nerdtree
	autocmd!
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END
noremap <F2> :NERDTreeToggle<CR>

"}}}
"LATEX-----------------------{{{
" IMPORTANT: grep will sometimes skip displaying the file name if you"
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
"au BufEnter *.tex set autowrite
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*' 
let g:Tex_GotoError = 0 
let g:Tex_ViewRule_pdf = 'evince' 
let g:LatexBox_complete_inlineMath = 1
set winaltkeys=no
nnoremap <leader>ch :!evince ~/cheatsheets/vimlatexqrc.pdf & <CR><CR>
"}}}
"GENERAL SETTINGS------------------{{{
:set number "Zeilennummerierung ein
:syntax enable "Aktiviert Syntax-Highlighting 

":set background=dark
":colorscheme solarized "Farbschema einstellen
:set ignorecase "Groß/klein bei Suche ignorieren
:set incsearch "Während eingaben suchen"
:set hlsearch "Markiert alle Such Ergebnisse
:set wildmenu "Akt Vervollständigung im menu
:let mapleader = ","
:set mouse=a
":set list "nicht druckbare Zeichen anzeigen(Zeilenende,etc)
:set autoindent
set splitbelow
set splitright
set foldmethod=indent
"}}}
"Vimscript file settings--------------------{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}
"MOVING----------------------------{{{
noremap  t<C-l> :tabn<CR>
noremap  t<C-h> :tabp<CR>
noremap  t<C-n> :tabnew<CR>
noremap  t<C-c> :tabclose<CR>
noremap      <CR>  o
noremap <S-L> $
noremap <S-H> 0
inoremap kj <esc>
"noremap      <C-CR> <O>
"""""""""MOVING IN SPLITS""""""""""""""""
noremap <c-f>j <C-W><C-J>
noremap <c-f>k <C-W><C-K>
noremap <c-f>l <C-W><C-L>
noremap <c-f>h <C-W><C-H>
"}}}
""""""""""""""""SHORT-CMD""""""""""""""""""
" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee  > /dev/null %
"""""""""""SPELL-CHECK""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
noremap <F8>  :setlocal spell spelllang=de,en <return>
noremap <F9> :setlocal spell& <return>

"""""""""""""""""""""""""""""""""""""""""""
"""""""""yank&put to strg-c/strg-v""""""""""
""""""""""""""""""""""""""""""""""""""""""""1
vnoremap <C-c> "+y
noremap <C-v> "+p
"AUTO COMPLETE ------------------------{{{
nnoremap fs O{{{<esc>:call<space>NERDComment(1,"comment")<CR>
nnoremap fe o}}}<esc>:call<space>NERDComment(1,"comment")<CR>
noremap <tab> <C-n>
:iabbrev uu ubuntu-users
:iabbrev %%% %%%%%%%%%%
:iabbrev """ """"""""""
:iabbrev $$$ $$$$$$$$$$
"}}}
"""""""""""""""""""""""""""""""""
"""""""""BOX-BUILDING""""""""""""
"""""""""""""""""""""""""""""""""
nnoremap <leader>cl id<esc><leader>cc$xvy30pi<CR><esc>10pi<++><esc>10pi<CR><esc>30p
"GO-LANG------------------------------- {{{
":GoPath /home/$USER/work/go
":GoInstallBinaries
au FileType go nmap <leader>r <Plug>(go-run)
"au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nnoremap <leader>b :make<CR>
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
"}}}
""""""""""""""""""""""""""""""
""""""""""TAGBAR"""""""""
""""""""""""""""""""""""""""""""
nnoremap <F3> :TagbarToggle<CR>


"""""""""""""""""""""""""""""""""""
""""" Quickly open/reload vim""""""
"""""""""""""""""""""""""""""""""""
nnoremap <F11> :source $MYVIMRC<CR> 
nnoremap <leader>v :vsp ~/.vimrc<CR>
""""""""""""""""""""""""""""""""""""""""""
"""""""""""""cursorcross""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""
"g:cursorcross_dynamic = 'clw'

