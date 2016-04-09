"=====[ Enable Nmap command for documented mappings ]================

runtime plugin/documap.vim

"=====[ Edit files in local bin directory ]========

Nmap ;b  [Edit ~/bin/...]  :next ~/bin/

"====[ I'm sick of typing :%s/.../.../g ]=======

Nmap S  [Shortcut for :s///g]  :%s//g<LEFT><LEFT>
vmap S                         :Blockwise s//g<LEFT><LEFT>

Nmap <expr> M  [Shortcut for :s/<last match>//g]  ':%s/' . @/ .  '//g<LEFT><LEFT>'
vmap <expr> M                                     ':s/' . @/ .  '//g<LEFT><LEFT>'

"Delete in normal mode to switch off highlighting till next search and clear messages...
Nmap <silent> <BS> [Cancel highlighting]  :call HLNextOff() <BAR> :nohlsearch <BAR> :call VG_Show_CursorColumn('off')<CR>

"Double-delete to remove trailing whitespace...
Nmap <silent> <BS><BS>  [Remove trailing whitespace] mz:call TrimTrailingWS()<CR>`z

function! TrimTrailingWS ()
    if search('\s\+$', 'cnw')
        :%s/\s\+$//g
    endif
endfunction

Nmap <silent> ;y [Toggle syntax highlighting]
                 \ : if exists("syntax_on") <BAR>
                 \    syntax off <BAR>
                 \ else <BAR>
                 \    syntax enable <BAR>
                 \ endif<CR>

syntax on
set nocompatible
set backspace=indent,eol,start

set nu
set wmw=0
set wmh=0
set noea

set nowrap
" auto indent files
set autoindent
set smartindent

" expand tabs
set et
" step to use indent
set sw=4
"
set ts=4

set history=400
"set ruler
set showcmd
set cul

set ls=2
set statusline=%<%f\ %y%h%m%r
set statusline+=%{fugitive#statusline()}
set statusline+=%=%-14.(%l,%c%V%)\ %P

set hlsearch incsearch smartcase
filetype plugin indent on

" disable hls on backspace
nmap <silent> <BS>  :nohlsearch<CR>

" swap Visual and Block Visual
nnoremap v <C-V>
nnoremap <C-V> v

vnoremap v <C-V>
vnoremap <C-V> v

" use arrows to move between files
nmap <silent> <UP>            :prev<CR>
nmap <silent> <DOWN>          :next<CR>

" Use space to jump down a page (like browsers do)...
nnoremap   <Space> <PageDown>
vnoremap   <Space> <PageDown>

" Indent/outdent current block...
nmap %% $>i}``
nmap $$ $<i}``

set spelllang=en_us

Nmap <silent> ;ss [Toggle Basic English spell-checking] :set    spell spelllang=en-basic<CR>

" Make naughty characters visible...
" (uBB is right double angle, uB7 is middle dot)
exec "set lcs=tab:\uBB\uBB,trail:\uB7,nbsp:~"

augroup VisibleNaughtiness
    autocmd!
    autocmd BufEnter  *       set list
    autocmd BufEnter  *.txt   set nolist
    autocmd BufEnter  *.vp*   set nolist
    autocmd BufEnter  *       if !&modifiable
    autocmd BufEnter  *           set nolist
    autocmd BufEnter  *       endif
augroup END

" Match angle brackets...
set matchpairs+=<:>

" Match double-angles, XML tags and Perl keywords...
let TO = ':'
let OR = ','
let b:match_words =
\
\                          '<<' .TO. '>>'
\
\.OR.     '<\@<=\(\w\+\)[^>]*>' .TO. '<\@<=/\1>'

set scrolloff=2

set showmatch
set mat=6

" Opening and closing braces
imap <C-F> {<CR>}<C-O>O

set sessionoptions+=resize
set diffopt+=iwhite

set background=dark

filetype plugin on

" upload/edit vimrc
nmap <silent>  ;v  :next $MYVIMRC<CR>

augroup VimReload
    autocmd!
    autocmd BufWritePost  $MYVIMRC  source $MYVIMRC
augroup END

if has('persistent_undo')
    set undolevels=5000
    set undodir=$HOME/.vim_undo_files
    set undofile
endif

" save swap every 10 characters
set updatecount=10

" format file using xmllint
map <F2> <Esc>:1,$!xmllint --format -<CR>

