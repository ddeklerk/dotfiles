" Start the plugin manager
call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'

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

" Use italic font for comments
highlight Comment cterm=italic

" Automatically reload .vimrc when saved
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Automatically open NERDTree when Vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
