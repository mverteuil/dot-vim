" Plugins {{{
" Vundle Configuration {{{
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
    " Visual undo
    Plugin 'sjl/gundo.vim'
    " Search for selected text with '*'
    Plugin 'nelstrom/vim-visual-star-search'
    " Search for files and buffers
    Plugin 'ctrlpvim/ctrlp.vim'
    " Search using Ag
    Plugin 'rking/ag.vim'
    " Move through named variables easier
    Plugin 'bkad/CamelCaseMotion'
    " Visualized indentation guide lines
    Plugin 'nathanaelkane/vim-indent-guides'
    " Syntax highlighting for winners
    Plugin 'scrooloose/syntastic'
    " Python boons and bonuses, mostly autopep8 and rake\gi\gg\igg,gi
    Plugin 'klen/python-mode'
    " Coverage highlighting for Python
    Plugin 'alfredodeza/coveragepy.vim'
    " Better auto-alignment to tabs
    Plugin 'godlygeek/tabular'
    " Markdown syntax support
    Plugin 'plasticboy/vim-markdown'
    " Tab renaming
    Plugin 'gcmt/taboo.vim'
    " Look up docs in Dash.app
    Plugin 'rizzatti/dash.vim'
    " Tab completion
    Plugin 'Valloric/YouCompleteMe'
    " Jump around without requiring nohlsearch all the time
    Plugin 'justinmk/vim-sneak'
    " Git change indications in the gutter
    Plugin 'airblade/vim-gitgutter'
    " File browsing like a boss
    Plugin 'scrooloose/nerdtree'
    " NERDTree for dudes with tabs
    Plugin 'jistr/vim-nerdtree-tabs'
    " Syntax highlighting in handlebars/mustache templates
    Plugin 'mverteuil/vim-mustache-handlebars'
    " Every variable a different colour
    Plugin 'jaxbot/semantic-highlight.vim'
    " CoffeeScript support
    Plugin 'kchmck/vim-coffee-script'
    " Syntax highlighting for Django templates
    Plugin 'django.vim'
    " Makes editing XML/HTML a breeze
    Plugin 'xml.vim'
    " Python isort (import sort) support, requires isort to be installed
    Plugin 'fisadev/vim-isort'
    " Tab-complete with tab
    Plugin 'ervandew/supertab'
    " Snippets engine
    Plugin 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    Plugin 'honza/vim-snippets'
    " Time tracking
    Plugin 'wakatime/vim-wakatime'
    " Base16 powerline
    Plugin 'terlar/base16-vim-powerline'
    " Improved shell support
    Plugin 'vim-scripts/Conque-Shell'
    " Pytest support
    Plugin 'mverteuil/pytest.vim'
    " Git support
    Plugin 'tpope/vim-fugitive'
    " Unicode tools and support
    Plugin 'unicode.vim'
    " Virtualenv support
    Plugin 'vimscripts/vim-virtualenv'
    " Ctags explorer
    Plugin 'majutsushi/tagbar'
    " Ctags generator
    Plugin 'xolox/vim-easytags'

    if needs_vundle == 0
        echo "Installing Plugins..."
        :PluginInstall
    endif
endif
" }}}
" Ag {{{
" Open ag.vim
map             <Leader>a       :Ag<cr>
" }}}
" Base16-Vim-Powerlne {{{
let g:Powerline_colorscheme = 'base16'
" }}}
" Control-P {{{
map             <Leader>p       :CtrlP<cr>
map             <Leader>b       :CtrlPBuffer<cr>
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>', '<MiddleMouse>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_switch_buffer = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_working_path_mode = 0
" }}}
" Gundo {{{
" Toggle gundo
nnoremap        <leader>u       :GundoToggle<CR>
" }}}
" Semantic Highlight {{{
" Toggle semantic highlighting
nnoremap        <Leader>j       :SemanticHighlightToggle<CR>
" }}}
" Python Mode {{{
" 110 line characters maximum
let g:pymode_options_max_line_length=109
" Don't fold functions
let g:pymode_folding=0
" Leave linting to Syntastic
let g:pymode_lint=0
let g:pymode_lint_on_write=0
let g:pymode_lint_on_the_fly=0
let g:pymode_lint_unmodified=0
let g:pymode_lint_checkers = []
" Do syntax hightlighting with pymode, not syntastic
let g:pymode_syntax = 1
" No rope, too slow
let g:pymode_rope=0
" No rope completion
let g:pymode_rope_completion=0
" Assist with indenting
let g:pymode_indent = 1
" Load the virtualenv
let g:pymode_virtualenv = 1
" }}}
" Markdown {{{
" Don't fold in markdown files
let g:vim_markdown_folding_disabled=1
" }}}
" NERDTree {{{
" Set ignored file pattern
let NERDTreeIgnore=['.pyc$']
" Use the wildignore list for ignoring files
let NERDTreeRespectWildIgnore=1
" Close explore window on file open
let NERDTreeQuitOnOpen=1
" Don't open nerdtree on startup
let g:nerdtree_tabs_open_on_gui_startup = 0
" }}}
" supertab {{{
let g:SuperTabDefaultCompletionType = '<tab>'
" }}}
" Syntastic {{{
let g:syntastic_python_checkers = ['python', 'compile', 'flake8', 'pydocstyle', 'pylint']
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 4
" Don't open window on errors, but close window if no errors
let g:syntastic_auto_loc_list = 2
" Jump to the first issue detected, but only if it's an error
let g:syntastic_auto_jump = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_highlighting = 1
" Ignore warnings about
"  - D100: docstring uses indicative rather than imperative conjugation " (https://mail.python.org/pipermail/tutor/2012-May/089584.html)
"  - D203: blank line ABOVE docstring
"  - D204: blank line BELOW docstring
"  - D401: missing module docstring
let g:syntastic_python_flake8_args = '--ignore=D100,D203,D204,D401 --max-line-length=109'
let g:syntastic_python_pylint_args = '--disable=missing-docstring,invalid-name,too-many-ancestors'

" }}}
" ultiSnips {{{
" Better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<S-CR>"
let g:UltiSnipsJumpForwardTrigger = "<S-Right>"
let g:UltiSnipsJumpBackwardTrigger="<S-Left>"
" }}}
" vim-easytags {{{
" Re-index tags in the background
let g:easytags_async = 1
" }}}
" Vim-Indent-Guides {{{
" Automatically use indent guides
let g:indent_guides_enable_on_vim_startup=1
" Choose own guide colors
let g:indent_guides_auto_colors=1
" Guide width is 1 character column
let g:indent_guides_guide_size=4
" Explicit odd-numbered line color
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=10
" Explicit even-numbered line color
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=11
" }}}
" vim-virtualenv {{{
" Automatically activate the virtualenv if detected
let g:virtualenv_auto_activate = 1
" }}}
" YouCompleteMe {{{
" Let YCM read tags from Ctags file
let g:ycm_collect_identifiers_from_tags_files = 1
" Default 1, just ensure
let g:ycm_use_ultisnips_completer = 1
" Completion for programming language's keyword
let g:ycm_seed_identifiers_with_syntax = 1
" Completion in comments
let g:ycm_complete_in_comments = 1
" Completion in string
let g:ycm_complete_in_strings = 1
" }}}
" }}}
" Global {{{
" Vi mode is for suckers
set nocompatible
" Don't change directory to the current buffer when opening files.
set noautochdir
" Don't redraw during macros
set lazyredraw
" Backspace eats things correctly
set backspace=indent,eol,start
" Don't jump to start of line when moving around
set nostartofline
" Ctrl-W in command-line stops at /
set iskeyword-=/
" Smart indenting options for pythonic, and so forth
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" Default to utf-8
set encoding=utf-8
" Load filetype settings
filetype on
" Load filetype indents
filetype indent on
" Load filetype plugins
filetype plugin on
" Set the <Leader> to space (via Yen)
let mapleader = '¥'
" }}}
" Searches {{{
" Highlight matches
set hlsearch
" Incremental searches as you type
set incsearch
" Ignore case in searches when lowercase
set ignorecase
set smartcase
" Files to ignore when searching
set wildignore=.git,*.pyc,*.jpg,*.jpeg,*.png,*.bmp,*.doc,*.xls,*.swf,*.pdf,*.psd,*.ai,*.mov,*.gz,*.jfif,*.tiff,*.docx,*.xml,*.wmv,*.otf,*.ttf,*.min.js,*.sassc,CACHE
set wildignore+=tiny_mce,media,.sass-cache
" }}}
" History & Backups {{{
" A thousand remembered commands
set history=1000
" Share clipboard with system
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
" No swap files
set nobackup
set noswapfile
set nowritebackup
" }}}
" Style {{{
" Enable syntax highlighting
syntax on
" Use VGA colors
let base16colorspace=256
" Use dark background always
set background=dark
" Use Base16's Tomorrow Theme
colorscheme base16-tomorrow
" Prefix lines with their number
set number
" Show command in bottom bar
set showcmd
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
" Always keep cursor 2 lines from screen edge
set scrolloff=2
" No GUI
set guioptions=a
" Persist status bar in command mode
set laststatus=2
" Visual autocomplete for command menu
set wildmenu
" Always display the tabline, even if there is only one tab
set showtabline=2 
" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode 

" Fonts
if has("gui_gtk2")
    set guifont=Input\ Mono\ Condensed:h12
    set linespace=4
elseif has("gui_macvim")
    set guifont=Input\ Mono\ Condensed:h12
    set linespace=4
elseif has("gui_win32")
    set guifont=Input\ Mono\ Condensed:h12
    set linespace=4
endif

" }}}
" Custom Functions {{{
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

" Toggle between number and relativenumber
" ========================================
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
" }}}
" Keyboard {{{
map             <space>         ¥
" Control+e, Browse file system
noremap         <C-e>           :NERDTreeTabsToggle<CR>
" Leader+Shift+Tab, Previous tab
noremap         <Leader><S-Tab> :tabprevious<CR>
" Leader+Tab, Next tab
noremap         <Leader><Tab>   :tabnext<CR>
" Control+T, New tab
noremap         <C-t>           :tabnew<CR>
" Move to beginning/end of line
nnoremap        B               ^
nnoremap        E               $
" $/^ become no-op
"nnoremap        $               <nop>
"nnoremap        ^               <nop>
" Highlight last inserted text
nnoremap        gV              `[v`]
" Leader+s, Turn of highlighting search matches
nnoremap        <Leader><space> :nohlsearch<CR>
" Leader+1, Truncate to first 100 characters on-line
noremap         <Leader>1       ^100<Right>C<ESC>
" Leader+l, Run linters, PLUGIN: python-mode
noremap         <Leader>l       :SyntasticCheck<CR>
" Leader+c, Show Coverage, PLUGIN: coveragepy.vim
noremap         <Leader>c       :silent Coveragepy report<CR><C-w><down><C-w>c
" Leader+C, Show/hide Coverage window, PLUGIN: coveragepy.vim
noremap         <Leader>C       :Coveragepy session<CR>
" Leader+w, Cycle through text-width definitions
noremap         <Leader>w       :call CycleTextWidth()<CR>
" Leader+i, Split multiple imports on one line into a multi-line tuple-import
noremap         <Leader>i       :Isort<CR>
" Leader+z, Clear all CtrlP caches
noremap         <Leader>z       :ClearAllCtrlPCaches<CR>
" Leader+n, Toggle relative numbers
noremap         <Leader>n       :call ToggleNumber()<CR>
" Leader+u, Gundo toggle
noremap         <Leader>u       :GundoToggle<CR>
" Leader+p, Run all tests
noremap         <Leader>p       :Pytest project
" Leader+m, Run test method
noremap         <Leader>m       :Pytest method<CR>
" Leader+f, Run test file
noremap         <Leader>f       :Pytest file<CR>
" Leader+t, Show test session
noremap         <leader>t       :Pytest session<CR>

" }}}
" Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
" vim:foldmethod=marker:foldlevel=0
