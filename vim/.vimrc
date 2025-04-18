colorscheme habamax

set number
set relativenumber
set cursorline
set tabstop=4
set shiftwidth=4
set noexpandtab
set wrap
set linebreak
set scrolloff=0
set hlsearch
set ignorecase

inoremap jk <esc>
inoremap <C-h> <C-w>

inoremap <C-down> <esc>:m .+1<cr>==gi
inoremap <C-up> <esc>:m .-2<cr>==gi
nnoremap <C-down> :m .+1<cr>==
nnoremap <C-up> :m .-2<cr>==
vnoremap <C-down> :m '>+1<cr>gv=gv
vnoremap <C-up> :m '<-2<cr>gv=gv

noremap U <C-r>
noremap <C-r> U

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
