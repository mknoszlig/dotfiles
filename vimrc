set nocompatible
filetype plugin indent on

:set nu
:colorscheme vividchalk
:let ruby_fold = 1

" autotag to work with ctags
source /home/mk/.vim/source/autotag.vim

" additional key mapping for vcscommands
:map \bc :VCSBlame<CR>

" abbreviations for parens
:iabbrev ( ()<ESC>i
:iabbrev { {}<ESC>i

" clojure options
let clj_highlight_builtins = 1
let clj_paren_rainbow = 1
