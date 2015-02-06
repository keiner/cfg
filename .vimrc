" Kommentare werden mit " Eingeleitet
"Allgemeine Einstellungen
:set number  "Zeilennummerierung ein
":set langmap=jklö;hjkl	"hjkl auf jklö ändern
:syntax on "Aktiviert Syntax-Highlighting 
:set spelllang=de,en spell "Sprache
:colorscheme delek "Farbschema einstellen
:set ignorecase	"Groß/klein bei Suche ignorieren
:set incsearch "Waehrend eingaben suchen
:set hlsearch "Markiert alle Such Ergebnisse
:set wildmenu "Akt vervollständigung im menu
filetype on



"""""""""""""""""
"""""LATEX"""""""
"""""""""""""""""
"\ll in *.tex Datei compiliert
"\ls öffnet das PDF in Evince 

filetype plugin on
if has('gui_running')
  set grepprg=grep\ -nH\ $*
  filetype indent on
  let g:tex_flavor='latex'
 endif

filetype plugin on
filetype indent on
au BufEnter *.tex set autowrite
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_CompileRule_pdf = 'mkdir -p out && pdflatex -output-directory=_out -interaction=nonstopmode $* && mv out/$*.pdf .'
"let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_GotoError = 0
let g:Tex_ViewRule_pdf = 'evince' 
let g:LatexBox_complete_inlineMath = 1

""""""""Autovervollständigung
":abbreviate ABKÜRZUNG ERGEBNIS
:abbreviate uu ubuntu-users
:abbreviate lagra "\includegraphics[scale=1]{BILDNAME}"
