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
    " Python boons and bonuses, mostly autopep8 and rake\gi\gg\igg,gi
    Plugin 'klen/python-mode'
    " Coverage highlighting for Python
    Plugin 'alfredodeza/coveragepy.vim'

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

let g:syntastic_python_checkers = ['python', ]
let g:syntastic_aggregate_errors = 1


""" Vim-Indent-Guides ------------------------------------------------------------------------------

" Automatically use indent guides
let g:indent_guides_enable_on_vim_startup=0
" Choose own guide colors
let g:indent_guides_auto_colors=0
" Guide width is 1 character column
let g:indent_guides_guide_size=4
" Explicit odd-numbered line color
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=11
" Explicit even-numbered line color
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=11


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


""" Python Mode ------------------------------------------------------------------------------------

" Sort linter errors by priority
let g:pymode_lint_sort = ["E", "F", "V", "C", "I", "T"]
" 110 line characters maximum
let g:pymode_options_max_line_length=109
" Don't fold functions
let g:pymode_folding=0
" Leave linting to Syntastic
let g:pymode_lint=1
" Run linter on write
let g:pymode_lint_on_write=1
" Run linter on unmodified buffers too
let g:pymode_lint_unmodified=0
" Specify linters
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pep257']
" Linter symbols
let g:pymode_lint_comment_symbol = '📓'
let g:pymode_lint_docs_symbol = '📝'
let g:pymode_lint_error_symbol = '🔥'
let g:pymode_lint_info_symbol = 'ℹ️'
let g:pymode_lint_pyflakes_symbol = '💣'
let g:pymode_lint_todo_symbol = '✏️'
let g:pymode_lint_visual_symbol = '▶️'
" Ignore warnings about
"  - E501: line size > 80
"  - D100: docstring uses indicative rather than imperative conjugation " (https://mail.python.org/pipermail/tutor/2012-May/089584.html)
"  - D203: blank line ABOVE docstring
"  - D204: blank line BELOW docstring
"  - D401: missing module docstring
let g:pymode_lint_ignore="E501,D100,D203,D204,D401"
" Leave syntax highlighting to Syntastic
let g:pymode_syntax = 1
" No rope, too slow
let g:pymode_rope=0
" No rope completion
let g:pymode_rope_completion=0


""" My Functions -----------------------------------------------------------------------------------

" Cycle through text-width definitions
" ====================================
function! CycleTextWidth()
    " Set default widths if not defined
    if !exists("g:textwidths")
        let g:textwidths = [110, 80, ]
    endif
    " Take the next textwidth off the front of the list
    let next_textwidth = get(g:textwidths, 0, 110)
    let &textwidth = next_textwidth
    " Move the value to the back of the list
    let g:textwidths = g:textwidths[1:] + [next_textwidth]
endfunction


""" Key Mapping ------------------------------------------------------------------------------------

" Control+Shift+Tab, Previous tab
noremap         <C-S-Tab>       :tabprevious<CR>
" Control+Tab, Next tab
noremap         <C-Tab>         :tabnext<CR>
" Control+T, New tab
noremap         <C-t>           :tabnew<CR>
" Leader+1, Truncate to first 100 characters on-line
noremap         <Leader>1       ^100<Right>C<ESC>
" Leader+l, Run linters, PLUGIN: python-mode
noremap         <Leader>l       :PymodeLint<CR>
" Leader+r, Show Coverage, PLUGIN: coveragepy.vim
noremap         <Leader>r       :silent CoveragePy report<CR>
" Leader+w, Cycle through text-width definitions
noremap         <leader>w       :call CycleTextWidth()<CR>
