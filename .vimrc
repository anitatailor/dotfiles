set nocompatible
syntax on
set encoding=utf8
set nowrap


" OSX stupid backspace fix
set backspace=indent,eol,start

" Show linenumbers
set number
set ruler

" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Always display the status line
set laststatus=2
set showcmd

set incsearch
set hlsearch

" Enable Elite mode, No ARRRROWWS!!!!
"let g:elite_mode=1

" Enable highlighting of the current line
set cursorline


" Theme and Styling 
set t_Co=256
set background=dark

if (has("termguicolors"))
  set termguicolors
endif

let base16colorspace=256  " Access colors present in 256 colorspace

"colorscheme distinguished
"colorscheme desert

colorscheme spacegray 
let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

highlight Search ctermfg=9 	guifg=#ff0000 ctermbg=15 guibg=#ffffff gui=bold cterm=bold

if has('mouse')
  set mouse=a
endif
