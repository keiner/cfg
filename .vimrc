"VUNDEL----------------------------{{{
"SETTINGS---------{{{
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim "set the runtime path to include Vundle and init
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"-----------------}}}
"PLUGINS----------{{{
Plugin 'tmux-plugins/vim-tmux'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mtth/cursorcross.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'godlygeek/tabular'
Plugin 'vim-latex/vim-latex'
Plugin 'Chiel92/vim-autoformat'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'majutsushi/tagbar'
Plugin 'vimwiki'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line
"-----------------}}}
"----------------------------------}}}
"PATHOGEN--------------------------{{{
execute pathogen#infect()
"----------------------------------}}}
"GENERAL SETTINGS------------------{{{
let mapleader = ","
set autoindent
syntax  on
"g:cursorcross_dynamic = 'clw'
":set background=dark
"colorscheme solarized
set wildmenu        "autocomplete in commandline mode
set mouse=a     "activate mouse
":set list      "show not printable stuff
set splitbelow
set splitright
set runtimepath^=~/.vim/bundle/node
set autochdir       "working dir is always file dir
"tabconfig
set tabstop=4
set shiftwidth=4
set expandtab
"----------------------------------}}}
"STATUSLINE------------------------{{{
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
set laststatus=2        "allways show statusline
set statusline=
set statusline+=%{StatuslineGit()}
set statusline+=%F      " Path to the file
set statusline+=%{ObsessionStatus()}
set statusline+=%=      "swich to right side
set statusline+=%y      " Filetype of the file
set statusline+=\ c:
set statusline+=%c      "current column
set statusline+=\ l:
set statusline+=%l      " Current line
set statusline+=/       " Separator
set statusline+=%L      " Total lines
set statusline+=\ %p%%
""---------------------------------}}}
"LINE AND COLUMN NUMBERING---------{{{
set ruler
set number
set invrelativenumber
nmap ^ :set invrelativenumber<CR> " Toggle relative line number
"---------------------------------}}}
"SEARCH OPTIONS--------------------{{{
set ignorecase
set incsearch
set hlsearch
nnoremap <CR> :noh<CR>
"----------------------------------}}}
"FOLDING---------------------------{{{
set foldenable
set foldmethod=marker
"FOLDTEXT---------------{{{
set foldtext=getline(v:foldstart+0)
"set foldtext=MyFoldText()
function! MyFoldText()
    let line = getline(v:foldstart)
    if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
        let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
        let linenum = v:foldstart + 1
        while linenum < v:foldend
            let line = getline( linenum )
            let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
            if comment_content != ''
                break
            endif
            let linenum = linenum + 1
        endwhile
        let sub = initial . ' ' . comment_content
    else
        let sub = line
        let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
        if startbrace == '{'
            let line = getline(v:foldend)
            let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
            if endbrace == '}'
                let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
            endif
        endif
    endif
    let n = v:foldend - v:foldstart + 1
    let info = " " . n . " lines"
    let sub = sub . "                                                                                                                  "
    let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
    let fold_w = getwinvar( 0, '&foldcolumn' )
    let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
    return sub . info
endfunction
"-----------------------}}}
"FILETYPE FOLDING-------{{{
augroup folding
    au!
    "find filetype with  :set ft ?
    au FileType txt,vim,html,tmux,conf,zsh setlocal foldmethod=marker
    au FileType sh,css setlocal foldmethod=indent
    au Filetype xhtml,json,javascript setlocal foldmethod=syntax
    au Filetype c setlocal=expr
augroup END
"-----------------------}}}
"CREATE FOLDMARKS-------{{{
nnoremap fs A{{{<esc>:call<space>NERDComment(1,"comment")<CR>
nnoremap fe o}}}<esc>:call<space>NERDComment(1,"comment")<CR>
"-----------------------}}}
"----------------------------------}}}
"MOVING----------------------------{{{
"Jump to <++> Placeholders in insert mode
inoremap <C-I> <Esc>/<++><CR>dea
"Shift h&l for jump to begining and end of line
noremap <S-L> $
noremap <S-H> 0
"----------------------------------}}}
"TAB AND SPLIT HANDLING------------{{{
"MOVING IN TABS
noremap tl :tabn<CR>
noremap tt :tabn<CR>
noremap th :tabp<CR>
noremap tn :tabnew<CR>
noremap tc :tabclose<CR>
"MOVING IN SPLITS
noremap fj <C-W><C-J>
noremap fk <C-W><C-K>
noremap fl <C-W><C-L>
noremap fh <C-W><C-H>
noremap fn :vnew<CR>
noremap fm :new<CR>
noremap fv :split<CR>           "split current file
noremap fb :vsplit<CR>          "vsplit current file
noremap fF <C-W>f           "open file under curser in new split
noremap ff :vertical wincmd f <CR>  "open file under curser in new vsplit
noremap FF :vsplit <cfile><cr>      "create and open file under curser
noremap fc :q<CR>
"RESIZE SPLITS
noremap fJ <C-W><C-J>
noremap fK <C-W><C-K>
noremap fL :vertical resize +5<CR>
noremap fH :vertical resize -5<CR>
"----------------------------------}}}
"OTHER MAPPINGS--------------------{{{
" save as root when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee  > /dev/null %
"kj for esc
inoremap kj <esc>
"AUTOFORMAT
noremap <F3> :Autoformat<CR>
"SPELL-CHECK
noremap <F8>  :setlocal spell spelllang=de,en <return>
noremap <F9> :setlocal spell& <return>
"Quickly open/reload vimrc
noremap <F10> :source $MYVIMRC<CR>:echo '> > > > > > > > V I M R C - R E L O A D E D ! < < < < < < < <'<CR>
nnoremap <leader>v :tabnew ~/cfg/.vimrc<CR>
nnoremap <leader>t :tabnew ~/cfg/.tmux.conf<CR>
nnoremap <leader>a :tabnew ~/cfg/.aliasesrc<CR>
nnoremap <leader>u :UltiSnipsEdit<CR>:vertical resize -20<CR>
"Quickly open a tmux split in working directory
noremap <F11> :!tmux split-window -l 10 -c %:p:h<CR>
"Open split and execute file in bash
nnoremap <leader>x :!tmux split-window -l 10 -c %:p:h  'bash %:p;read'<CR>
nnoremap <leader>X :!tmux split-window -l 10 -c %:p:h  'bash %:p;read'<left><left><left><left><left><left>
"yank&put to system clipboard with strg-c/strg-v
vnoremap <C-c> "*y
nnoremap <C-v> "*p
inoremap <C-v> <esc>"*pa
"mark all text
nnoremap <C-a> ggVGG
"open folder in nemo
"nnoremap  fe :! nemo . <CR>
"----------------------------------}}}
"AUTO COMPLETE --------------------{{{
iabbrev uu ubuntu-users
iabbrev %%% %%%%%%%%%%
iabbrev """ """"""""""
iabbrev $$$ $$$$$$$$$$
iabbrev bbang #!/bin/bash
"pannellum
iabbrev hotspot
            \<CR>{
            \<CR>"pitch": <++>,
            \<CR>"yaw": <++>,
            \<CR>"hfov": 120,
            \<CR>"type": "scene",
            \<CR>"text": "<++>",
            \<CR>"sceneId": "<++>",
            \<CR>"targetYaw": <++>,
            \<CR>"targetPitch": <++>
            \<CR>}<esc>8k<C-j>
"---------------------------------}}}
"FORMATING-------------------------{{{
noremap > >>
noremap < <<
"---------------------------------}}}
"TAGBAR----------------------------{{{
"nnoremap <F3> :TagbarToggle<CR>
"LANGS--------{{{
"-------------}}}
"---------------------------------}}}
"NERDTree--------------------------{{{
augroup nerdtree
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END
noremap <F2> :NERDTreeToggle<CR>
"---------------------------------}}}
"YCM-------------------------------{{{
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"let g:ycm_key_invoke_completion = '<C-Space>'
"" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

"let g:ycm_server_python_interpreter
"---------------------------------}}}
""ULTISNIPS------------------------{{{
"let g:UltiSnipsSnippetsDir="~/.vim/snips"
"let g:UltiSnipsSnippetDirectories=["snips", "UltiSnips"]
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
"if exists("g:UltiSnipsExpandTrigger")
"inoremap <CR> <esc>:call UltiSnips#ExpandSnippet()<cr>
"endif
"inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippet()<CR>" : "\<CR>"
let g:UltiSnipsExpandTrigger="<C-Space>"
"if !exists("g:UltiSnipsJumpForwardTrigger")
let g:UltiSnipsJumpForwardTrigger="<tab>"
"endif
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
""---------------------------------}}}
"SESSION HANDLING------------------{{{
nnoremap <leader>q :qa<CR>
nnoremap <leader>s :Obsession ~/.vim/session.vim<CR>
nnoremap <leader>r :source ~/.vim/session.vim<CR>
"if(argc() == 0)
"au VimEnter * nested :source ~/.vim/session.vim
"endif
"---------------------------------}}}
"LATEX-----------------------------{{{
" IMPORTANT: grep will sometimes skip displaying the file name if you"
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
"let g:Tex_BibtexFlavor='biber'
"au BufEnter *.tex set autowrite
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_MultipleCompileFormats = 'pdf,dv,dvi'
let g:Tex_CompileRule_pdf = 'arara -v $*'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_GotoError = 0
let g:Tex_ViewRule_pdf = 'okular $*'
let g:LatexBox_complete_inlineMath = 1
set winaltkeys=no
nnoremap <leader>ch :!evince ~/cheatsheets/vimlatexqrc.pdf & <CR><CR>
map <Leader>lb :<C-U>exec '!biber '.Tex_GetMainFileName(':p:t:r')<CR>
"FOLDTEXT---------------{{{
let g:tex_fold_override_foldtext = 1
let g:Tex_FoldedSections = 'part|addpart,chapter|addchap,section|addsec,subsection,subsubsection,paragraph,subparagraph'
let g:Tex_FoldedEnvironments = 'document'
let g:Tex_FoldedMisc = 'preamble,item'
"-----------------------}}}
"--------------------------------}}}
"JAVASCRIPT------------------------{{{

let g:javascript_plugin_jsdoc = 1
"let g:javascript_plugin_ngdoc = 1
"let g:javascript_plugin_flow = 1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"
map <leader>c :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
"--------------------------------}}}
"NODEJS----------------------------{{{
""<C-w>f to open fle under curser in vsplit
augroup node
    autocmd!
    autocmd User Node
                \ if &filetype == "javascript" |
                \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
                \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
                \ endif
augroup END

"--------------------------------}}}
"GO-LANG---------------------------{{{
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
"---------------------------------}}}
""VIM-WIKI-----------------------{{{
let g:vimwiki_folding=1
let g:vimwiki_table_auto_fmt=1
"-----------------------}}}
