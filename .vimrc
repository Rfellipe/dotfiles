" GENERAL ---------------------------------------------------------------- {{{

" Make vim accept Ç
set encoding=utf-8
set fileencoding=utf-8

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Set shift width to 2 spaces.
set shiftwidth=2

" Set tab width to 2 spaces.
set tabstop=2

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
" set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

  call plug#begin('~/.vim/plugged')

  Plug 'srcery-colors/srcery-vim'
  Plug 'fneu/breezy'
  Plug 'marcopaganini/mojave-vim-theme'
  Plug 'Donaldttt/fuzzyy'
  Plug 'dense-analysis/ale'
  Plug 'cdelledonne/vim-cmake'
  Plug 'terryma/vim-multiple-cursors'
  if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  call plug#end() 
  
  let g:deoplete#enable_at_startup = 1

  " use ALE as completion source
  call deoplete#custom#option('sources', { 
  \ '_': ['ale'],
  \})

  let g:ale_set_balloons=1
  let g:ale_completion_enabled = 1


  " Fuzzy config
  let g:fuzzyy_files_ignore_file = ['*.so', '*.o', '*.plist']
  
  let g:fuzzyy_files_ignore_dir = ['.git', 'node_modules', 'dist', '.next', 'build', '.ccls-cache']
" }}}

" MAPPINGS --------------------------------------------------------------- {{{

  " Set backlash as the leader key
  let mapleader = '\'
 
  "navigation keys {{{
    " normal mode
    nnoremap j h
    nnoremap k j
    nnoremap l k
    nnoremap ç l

    " visual mode
    vnoremap j h
    vnoremap k j
    vnoremap l k
    vnoremap ç l
  "}}}

  " Split the window in Vim by typing :split or :vsplit.
  " Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
  nnoremap <c-k> <c-w>j 
  nnoremap <c-l> <c-w>k 
  nnoremap <c-j> <c-w>h 
  nnoremap <c-ç> <c-w>l 

  " Resize split windows using arrow keys by pressing:
  " CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
  noremap <c-up> <c-w>+
  noremap <c-down> <c-w>-
  noremap <c-left> <c-w>>
  noremap <c-right> <c-w><

  " type : with space in normal mode
  nnoremap <space> :
  xnoremap <space> :

  " jj to exit insert mode quicker
  inoremap jj <esc>
  
  " Open explore
  nnoremap <c-e> :Explore<return>
  nnoremap <c-e>v :Vexplore!<return>
  nnoremap <c-b> :b#<return>

  " Ale keymapping configuration
  nnoremap <c-]> :ALEGoToDefinition<return> " Go to definition
  nnoremap <c-]>] :ALEGoToDefinition -vsplit<return> " Go to definition in vertical split
  nnoremap gr :ALEFindReferences<CR> " Find reference of symbol under the cursor
  nnoremap K :ALEHover<return>" Print brief info about the symbol under the cursor

  nnoremap <C-c> :call system("wl-copy", @")<CR>
  xnoremap <silent> <C-c> :w !wl-copy<CR><CR>

  " Close brackets, parenthesis and else automatically
  imap { {}<left>
  imap ( ()<left>
  imap [ []<left>

  " fuzzy finder mappin
  map <c-p> :FuzzyFiles<return>
  " imap <c-p> FuzzyFiles

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

  " This will enable code folding.
  " Use the marker method of folding.
  augroup filetype_vim
      set foldmethod=indent
      autocmd!
      autocmd FileType vim setlocal foldmethod=marker
  augroup END

  " If Vim version is equal to or greater than 7.3 enable undofile.
  " This allows you to undo changes to a file even after saving it.
  if version >= 703
      set undodir=~/.vim/backup
      set undofile
      set undoreload=10000
  endif

  " Line cursor in insert mode and block cursor everywhere else
  let &t_SI = "\e[6 q"
  let &t_EI = "\e[2 q"

  " Make deoplete not insert bs while on multicursor mode
  func! Multiple_cursors_before()
    if deoplete#is_enabled()
      call deoplete#disable()
      let g:deoplete_is_enable_before_multi_cursors = 1
    else
      let g:deoplete_is_enable_before_multi_cursors = 0
    endif
  endfunc
  func! Multiple_cursors_after()
    if g:deoplete_is_enable_before_multi_cursors
      call deoplete#enable()
    endif
  endfunc
 
" }}}

" STATUS LINE ------------------------------------------------------------ {{{

  " Clear status line when vimrc is reloaded.
  set statusline=

  " Status line left side.
  set statusline+=\ %F\ %M\ %Y\ %R

  function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
  endfunction

  set statusline+=%{LinterStatus()}

  " Use a divider to separate the left side from the right side.
  set statusline+=%=

  " Status line right side.
  set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

  " Show the status on the second to last line.
  set laststatus=2

" }}}

" COLOR SCHEME ---------------------------------------------------------------- {{{

" Load colorScheme
  set background=dark
  set termguicolors
  colorscheme breezy
  hi CursorLine term=bold cterm=bold ctermbg=236 guibg=#303030
  hi CursorLineNr term=bold cterm=bold ctermfg=3 ctermbg=0 guifg=#FBB829 guibg=#1C1B19
 
"}}}
