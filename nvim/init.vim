:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline' " status bar
Plug 'https://github.com/preservim/nerdtree' " NerdTree

call plug#end()


:nnoremap <C-e> :NERDTreeToggle<CR>


let g:neovide_cursor_trail_length = 0
let g:neovide_cursor_animation_length = 0

let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
