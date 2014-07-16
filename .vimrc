""" Global -----------------------------------------------------------------------------------------

" Vi mode is for suckers
set nocompatible
" Change directory to the current buffer when opening files.
set autochdir
" Prefix lines with their number
set number
" Show matching braces
set showmatch
" Don't wrap lines
set nowrap
" Expand tabs into spaces
set expandtab
" Size of tabs
set softtabstop=4
set shiftwidth=4
set tabstop=4
" Round shifted text to multiple of shiftwidth
set shiftround
" Maximum line width
set textwidth=110
" Backspace eats things correctly
set backspace=indent,eol,start
" Always keep cursor 2 lines from screen edge
set scrolloff=2                 
" Don't jump to start of line when moving around
set nostartofline               
" No GUI
set guioptions=a
" Persist status bar in command mode
set laststatus=2

" Highlight matches
set hlsearch
" Incremental searches as you type
set incsearch
" Ignore case in searches when lowercase
set ignorecase
set smartcase
" Files to ignore when searching
set wildignore=.git,*.pyc,*.jpg,*.jpeg,*.png,*.bmp,*.doc,*.xls,*.swf,*.pdf,*.psd,*.ai,*.mov,*.gz,*.jfif,*.tiff,*.docx,*.xml,*.wmv,*.otf,*.ttf,*.min.js,*.sassc
set wildignore+=tiny_mce,media,.sass-cache
" A thousand remembered commands
set history=1000                
" Ctrl-W in command-line stops at /
set iskeyword-=/                
" Share clipboard with system
set clipboard^=unnamed,unnamedplus

" No swap files
set nobackup
set noswapfile
set nowritebackup


""" Plugins ----------------------------------------------------------------------------------------

"" General
filetype on
" Load filetype indents
filetype indent on
" Load filetype plugins
filetype plugin on

"" Vundle Configuration
let needs_vundle = 1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let needs_vundle = 0
endif
if has("user_commands")
  set rtp+=~/.vim/bundle/vundle/
  runtime autoload/vundle.vim
endif
if exists("*vundle#rc")
  filetype off
  call vundle#rc()
  " Plugins for vim
  Plugin 'gmarik/vundle'                           

  " Colours for people who like pretty things
  Plugin 'chriskempson/base16-vim'
  " Substitutions and search for kings
  Plugin 'abolish.vim'                              
  " Search for selected text with '*'
  Plugin 'nelstrom/vim-visual-star-search'        
  " Flake8 linting for Python
  Plugin 'nvie/vim-flake8'                        
  " Move through named variables easier
  Plugin 'bkad/CamelCaseMotion'                   
  " Search for files and buffers
  Plugin 'kien/ctrlp.vim'                         
  " Visualized indentation guide lines
  Plugin 'nathanaelkane/vim-indent-guides'        
  " Syntax highlighting for winners
  Plugin 'scrooloose/syntastic'                   
  " Awesome status bar for cool people
  Plugin 'bling/vim-airline'

  if needs_vundle == 0
      echo "Installing Plugins..."
      :PluginInstall
  endif
endif

""" Style configuration ----------------------------------------------------------------------------


" Enable syntax highlighting
syntax on
" Use dark background always
set background=dark
" Use Base16's Mocha
colorscheme base16-mocha


" Fonts
if has("gui_gtk2")
    set guifont="Menlo for Powerline" 11
    set linespace=2
elseif has("gui_macvim")
    set guifont="Menlo for Powerline":h11
    set linespace=2
elseif has("gui_win32")
    set guifont="Menlo for Powerline":h11
    set linespace=2
endif

""" NERDTree-style Netrw ---------------------------------------------------------------------------

" Toggle Vexplore with Ctrl-E
" ===========================
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_list_hide = '\.git,.*\.swp\($\|\t\),.*\.py[co]\($\|\t\)'

" Default to tree mode
let g:netrw_liststyle=3


""" Control-P --------------------------------------------------------------------------------------
map <Leader>p :CtrlP<cr>
map <Leader>b :CtrlPBuffer<cr>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>', '<MiddleMouse>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_follow_symlinks = 1


""" Syntastic --------------------------------------------------------------------------------------
let g:syntastic_python_checkers = ['flake8', 'python', ]
let g:syntastic_python_flake8_args = '--ignore=E501'
let g:syntastic_aggregate_errors = 1

""" Vim-Indent-Guides ------------------------------------------------------------------------------
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234


""" Python File Helpers ----------------------------------------------------------------------------

" Destroy EOL whitespace in python files
autocmd BufWrite *.py :silent! %s/\s\+$//
" Expand 'ppdb' to a pdb set trace
autocmd BufEnter *.py :iabbr ppdb import pdb;pdb.set_trace()
" Remove pdb expansion in non-python files
autocmd BufLeave *.py :unabbr ppdb


""" Airline ----------------------------------------------------------------------------------------
let g:airline_theme             = 'lucius'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1

" vim-powerline symbols
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'
