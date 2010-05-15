set nocompatible
filetype plugin indent on
syntax enable

:set nu

if &diff
  set t_Co=256
  set background=dark
  colorscheme peaksea
else
  colorscheme vividchalk
endif

:let ruby_fold = 1

" autotag to work with ctags
source $HOME/.vim/source/autotag.vim

" additional key mapping for vcscommands
map bc :VCSBlame<CR>

map <C-j> <ESC><C-w>j
map <C-k> <ESC><C-w>k
map <C-h> <ESC>:bnext<cr>
map <C-l> <ESC>:bprev<cr>

" abbreviations for parens
iabbrev ( ()<ESC>i
iabbrev { {}<ESC>i

" clojure options
let clj_highlight_builtins = 1
let clj_paren_rainbow = 1

