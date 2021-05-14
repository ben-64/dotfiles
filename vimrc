" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
" set compatible

" To avoid the ^M bug...

set fileformat=unix
set fileencoding=utf-8

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" Color theme
" Available themes:
" 	mustang, vitamins, desert, vylight, molokai

set t_Co=256
colorscheme mustang

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=v		" Enable mouse usage (all modes)
set hlsearch

set ts=4
set shiftwidth=4

filetype plugin indent on


let mapleader = ","

" Define New Custom Ag command ignoring some files defined in ~/.ignore_ag
command! -bang -nargs=* AgC call fzf#vim#ag(<q-args>, "--path-to-ignore ~/.ignore_ag", <bang>0)

" Shortcuts
"map <C-t> :tab split<CR>
map <C-PageUp> :gt<CR>
map <C-PageDown> :gT<CR>
map <F3> <Plug>MarkSet 
map <C-w>2 :split<CR>
map <C-w>3 :vsplit<CR>
map <Leader>f :Files<CR>
map <Leader>a :AgC<CR>
map <Leader>q :AgC <C-R><C-W><CR>
map <Leader>t :Tags<CR>
map <Leader>b :Buffers<CR>
map <Leader>< :pop<CR>
map <F4> :set number!<CR>
nnoremap <Leader>> <C-]>

" cscope
set cscopetag
set cst
set csto=0
nmap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines)
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction
" Invoke command. 'g' is for call graph, kinda.
nnoremap <silent> <Leader>c :call Cscope('3', expand('<cword>'))<CR>

execute pathogen#infect()
set laststatus=2
map <F2> :NERDTreeToggle<CR>

" Lightline
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" FZF
set rtp+=~/.fzf
map <F1> :FZF ~<CR>
"command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--follow', <bang>0)

" ACK
let g:ackprg = 'ag --vimgrep --follow'

" Rainbow
let g:rainbow_active = 1

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=['UltiSnips',$HOME.'/.vim/my_snippets']
" Reload snippets: :call UltiSnips#RefreshSnippets

" tex functions
function! UnderscoreSlash()
	execute "normal! viW:s/\\%V_/\\\\_/g\<cr>"
endfunction

function! AddTTT()
	execute "normal! diwi\\texttt{\<esc>pi\<right>}"
endfunction

function! AddEmph()
	execute "normal! diwi\\emph{\<esc>pi\<right>}"
endfunction

autocmd BufRead,BufNewFile *.tex set filetype=tex textwidth=80 
autocmd FileType tex nnoremap <buffer> <F5> :call UnderscoreSlash()<CR>
autocmd FileType tex nnoremap <buffer> <F11> :call AddTTT()<CR>
autocmd FileType tex nnoremap <buffer> <F12> :call AddEmph()<CR>
