set nocompatible
filetype off

" :PluginInstall

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

Plugin 'gmarik/Vundle.vim'
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/InstantRst'
Plugin 'nvie/vim-rst-tables'
Plugin 'sjl/gundo.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'valloric/MatchTagAlways'
Plugin 'junegunn/goyo.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'
Bundle 'endel/vim-github-colorscheme'
Bundle 'Powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on

colorscheme github2

let mapleader = " "
set showcmd

nnoremap <F5> :GundoToggle<CR>

" save undo history
set undofile
set undodir=~/.vim/undodir

nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>

" move between buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" MD headings
" Creating underline/overline headings for markup languages
nnoremap <leader>1 I# 
nnoremap <leader>2 I## 
nnoremap <leader>3 I### 
nnoremap <leader>4 I#### 
nnoremap <leader>5 I##### 
nnoremap <leader>6 I###### 

autocmd BufRead,BufNewFile *.rst setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell
au BufRead,BufNewFile *.rst setlocal textwidth=80
au BufNewFile,BufRead *.tmpl set filetype=html

"set complete+=kspell
"imap <Tab> <C-N>
set guifont=Menlo\ Regular:h15

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre *.rst,*.py :call <SID>StripTrailingWhitespaces()

"soft word wraps
:set wrap
:set linebreak
:set nolist  " list disables linebreak
:set textwidth=0
:set wrapmargin=0
:set formatoptions+=l

set wildmenu
set wildmode=full

set laststatus=2

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']

" Quickly edit/reload the vimrc file
" ,ev and ,sv to edit/reload
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set shiftwidth=4 softtabstop=4 expandtab
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " case-sensitive search if contains uppercase chars
set smarttab      " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set nobackup
set noswapfile
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
" Folding rules {{{
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=99           " start out with everything unfolded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>
" }}}

nnoremap ; <Esc>
nnoremap <leader>; ;

" Avoid accidental hits of <F1> while aiming for <Esc>
noremap! <F1> <Esc>

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" Quick yanking to the end of the line
nnoremap Y y$

" Quote words under cursor
nnoremap <leader>" viW<esc>a"<esc>gvo<esc>i"<esc>gvo<esc>3l
nnoremap <leader>' viW<esc>a'<esc>gvo<esc>i'<esc>gvo<esc>3l
nnoremap <leader>` viW<esc>a`<esc>gvo<esc>i`<esc>gvo<esc>3l

" Use shift-H and shift-L for move to beginning/end
nnoremap H 0
nnoremap L $

" Wrap visual selection in an XML comment
vmap <Leader>c <Esc>:call CommentWrap()<CR>
function! CommentWrap()
  normal `>
  if &selection == 'exclusive'
    exe "normal i-->"
  else
    exe "normal a-->"
  endif
  normal `<
  exe "normal i<!--"
  normal `<
endfunction
