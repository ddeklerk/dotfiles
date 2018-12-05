" Essential.vim
set nocompatible
filetype plugin indent on
syntax on

" Enable true colors
if (has("termguicolors"))
	set termguicolors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Base16 Shell
if filereadable(expand("~/.vimrc_background"))
	source ~/.vimrc_background

	" Personal fixes on top of base16
	highlight link xmlEndTag xmlTag
	highlight ALEError ctermbg=none cterm=underline ctermfg=red
endif

" Enable the matchit plugin to jump between matching keywords
runtime macros/matchit.vim

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

" When typing %%, expand to the path of the active buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Search for the selected text
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
	let @s = temp
endfunction

let g:hardtime_default_on=1

" Highlight trailing whitespace in red
" Have this highlighting not appear whilst you are typing in insert mode
" Have the highlighting of whitspace apply when you open new buffers
highlight ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Indicator of the 81th character, which should not be exceeded
set colorcolumn=81

let g:EditorConfig_core_mode = 'external_command'

" Set textwidth automatically for md files
au BufRead,BufNewFile *.md setlocal textwidth=80
