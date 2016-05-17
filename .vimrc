syntax on

"=====[ Enable Nmap command for documented mappings ]================

runtime plugin/documap.vim


"====[ Edit and auto-update this config file and plugins ]==========

augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

Nmap <silent>  ;v   [Edit .vimrc]          :new $MYVIMRC<CR>
Nmap           ;vv  [Edit .vim/plugin/...] :new ~/.vim/plugin/

"=====[ Edit files in local bin directory ]========

Nmap ;b  [Edit ~/bin/...]  :new ~/bin/

"====[ Use persistent undo ]=================

if has('persistent_undo')
    " Save all undo files in a single location (less messy, more risky)...
    set undodir=$HOME/.vim_undo_files

    " Save a lot of back-history...
    set undolevels=5000

    " Actually switch on persistent undo
    set undofile

endif

"====[ I'm sick of typing :%s/.../.../g ]=======

Nmap S  [Shortcut for :s///g]  :%s//g<LEFT><LEFT>
vmap S                         :Blockwise s//g<LEFT><LEFT>

Nmap <expr> M  [Shortcut for :s/<last match>//g]  ':%s/' . @/ .  '//g<LEFT><LEFT>'
vmap <expr> M                                     ':s/' . @/ .  '//g<LEFT><LEFT>'

"====[ Toggle visibility of naughty characters ]============

" Make naughty characters visible...
" (uBB is right double angle, uB7 is middle dot)
exec "set lcs=tab:\uBB\uBB,trail:\uB7,nbsp:~"

"====[ Set up smarter search behaviour ]=======================

set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       "...unless uppercase letters used

set hlsearch        "Highlight all matches
"Delete in normal mode to switch off highlighting till next search and clear messages...
Nmap <silent> <BS> [Cancel highlighting]  :nohlsearch <CR>

"Double-delete to remove trailing whitespace...
Nmap <silent> <BS><BS>  [Remove trailing whitespace] mz:call TrimTrailingWS()<CR>`z

function! TrimTrailingWS ()
    if search('\s\+$', 'cnw')
        :%s/\s\+$//g
    endif
endfunction

"=====[ Make Visual modes work better ]==================

" Visual Block mode is far more useful that Visual mode (so swap the commands)...
nnoremap v <C-V>
nnoremap <C-V> v

vnoremap v <C-V>
vnoremap <C-V> v

"Square up visual selections...
set virtualedit=block

" Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
vmap <BS> x

"=====[ Configure % key (via matchit plugin) ]==============================

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

set wildmode=list:longest,full      "Show list of completions
                                    "  and complete as much as possible,
                                    "  then iterate full completions

set infercase                       "Adjust completions to match case

set noshowmode                      "Suppress mode change messages

set updatecount=10                  "Save buffer every 10 chars typed

set scrolloff=2                     "Scroll when 2 lines from top/bottom
set sidescrolloff=2                  "Scroll when 2 columns from left/right

" Use space to jump down a page (like browsers do)...
nnoremap   <Space> <PageDown>
vnoremap   <Space> <PageDown>

" do SQL formatting
let g:sqlutil_load_default_maps = 0

vmap <silent> sf        <plug>SQLU_Formatter<CR>
nmap <silent> scl       <Plug>SQLU_CreateColumnList<CR>
nmap <silent> scd       <Plug>SQLU_GetColumnDef<CR>
nmap <silent> scdt      <Plug>SQLU_GetColumnDataType<CR>
nmap <silent> scp       <Plug>SQLU_CreateProcedure<CR>

" Indent/outdent current block...
nmap %% $>i}``
nmap $$ $<i}``

" Move to prev/next
nmap <silent> <UP>            :prev<CR>
nmap <silent> <DOWN>          :next<CR>

set nocompatible
set backspace=indent,eol,start

execute pathogen#infect()

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
set ruler
set showcmd

" show line and column highlated
set cursorcolumn
set cursorline
" highlight everything over 80columns
call matchadd('ColorColumn', '==81v', 100)

set ls=2
set statusline=%<%f\ %y%h%m%r
set statusline+=%{fugitive#statusline()}
set statusline+=%=%-14.(%l,%c%V%)\ %P

filetype plugin indent on

set showmatch
set mat=6

" Opening and closing braces
imap <C-F> {<CR>}<C-O>O

set sessionoptions+=resize
set diffopt+=iwhite

set background=dark

filetype plugin on

" save swap every 10 characters
set updatecount=10

" format file using xmllint
map <F2> <Esc>:1,$!xmllint --format -<CR>

