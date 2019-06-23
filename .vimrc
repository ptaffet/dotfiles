set background=dark
set autoindent
set nocompatible
if filereadable(expand('~/localsettings/.vimrc'))
        source ~/localsettings/.vimrc
endif

filetype plugin indent on
syn on

set backspace=indent,eol,start whichwrap+=<,>,[,]
noremap 0 ^
noremap ^ 0

set ttyfast
set shortmess+=I " Don't show intro message
set ic " case insensitive search by default

" ; as an alternate : in normal mode
noremap ; :
" \= indents everything
noremap <Leader>= gg=G``


" Highlight >= 80 col
nnoremap <Leader>H :call<SID>LongLineHLToggle()<cr>
hi OverLength ctermbg=none cterm=none
match OverLength /\%>80v/
fun! s:LongLineHLToggle()
 if !exists('w:longlinehl')
  let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
  echo "Long lines highlighted"
 else
  call matchdelete(w:longlinehl)
  unl w:longlinehl
  echo "Long lines unhighlighted"
 endif
endfunction

" show whitespace
noremap <F11> :set list!<CR>
set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<,nbsp:_
highlight SpecialKey term=standout ctermbg=yellow guibg=yellow

" format xml chunks
function! FormatXML()
        :set filetype=xml
        :%s/></>\r</g
        :0
        normal VG=
endfunction

noremap <Leader>xml :call FormatXML()
noremap <Leader>XML :call FormatXML()

" Format switches better
set cinoptions=l1
" highlight RedundantSpaces term=standout ctermbg=Grey guibg=#ffddcc
" call matchadd('RedundantSpaces', '\(\s\+$\| \+\ze\t\|\t\zs \+\)\(\%#\)\@!')
"

" Customizations from LLNL
execute pathogen#infect()

set title                       " terminal title becomes filename being edited
set titleold=""                 " return terminal title to normal value upon exiting
set smartcase					" if search pattern has capital letters, make it case sensitive

" Spell Checking
" Use ':set spell' and ':set nospell' to turn spell checking on/off
set spelllang=en_us
set wildmenu " show alternative completion options in the status bar

highlight LineNr ctermfg=grey
highlight CursorLineNr ctermfg=255
set number

noremap <Leader>ll :make<CR>

if has('persistent_undo')      "check if your vim version supports it
	set undofile                 "turn on the feature  
	set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif 
