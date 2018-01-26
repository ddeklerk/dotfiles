" Essential.vim
set nocompatible
filetype plugin on

" Enable the matchit plugin to jump between matching keywords
runtime macros/matchit.vim

" Start the plugin manager
call plug#begin()

Plug 'mattn/emmet-vim'
Plug 'morhetz/gruvbox'

call plug#end()

" Set the colorscheme
colorscheme gruvbox

nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬,trail:·,precedes:←,extends:→,nbsp:␣

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
 
set hidden
 
set backupcopy=yes

" Automatically reload .vimrc when saved
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" When typing %%, expand to the path of the active buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
