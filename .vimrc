" Start the plugin manager
call plug#begin()

Plug 'mattn/emmet-vim'
Plug 'morhetz/gruvbox'

call plug#end()

set autoindent
filetype plugin indent on
syntax enable

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
