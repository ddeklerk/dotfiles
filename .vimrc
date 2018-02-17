" Essential.vim
set nocompatible
filetype plugin on

" Enable the matchit plugin to jump between matching keywords
runtime macros/matchit.vim

" Start the plugin manager
call plug#begin()

Plug 'arcticicestudio/nord-vim'

call plug#end()

" Set the colorscheme
colo nord

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

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Clear and redraw the screen, and mute search highlighting
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
