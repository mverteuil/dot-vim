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
    Plugin 'kien/ctrlp.vim'
    " Search using Ag
    Plugin 'rking/ag.vim'
    " Flake8 linting for Python
    Plugin 'nvie/vim-flake8'
    " Move through named variables easier
    Plugin 'bkad/CamelCaseMotion'
    " Visualized indentation guide lines
    Plugin 'nathanaelkane/vim-indent-guides'
    " Syntax highlighting for winners
    Plugin 'scrooloose/syntastic'
    " Awesome status bar for cool people
    Plugin 'bling/vim-airline'
    " Styles the awesome status bar for cool people
    Plugin 'vim-airline/vim-airline-themes'
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
" Airline {{{
let g:airline_theme             = 'lucius'
" vim-powerline symbols
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
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
" }}}
" Markdown {{{
" Don't fold in markdown files
let g:vim_markdown_folding_disabled=1
" }}}
" supertab {{{
"let g:SuperTabDefaultCompletionType = '<tab>'
" }}}
" Syntastic {{{
let g:syntastic_python_checkers = ['python', ]
let g:syntastic_aggregate_errors = 1
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
" ultiSnips {{{
" Better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<CR>"
if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<CR>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif
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
" Alternative selection keys
"let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
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
" Load filetype settings
filetype on
" Load filetype indents
filetype indent on
" Load filetype plugins
filetype plugin on
" Set the <Leader> to space
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
" Use Base16's Atelier Seaside theme
colorscheme base16-atelierseaside
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
" Smart UltiSnips Completion
" ==========================
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction
" Smart UltiSnips Reverse
" =======================
function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif
  return ""
endfunction

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
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
nnoremap        $               <nop>
"nnoremap        ^               <nop>
" Highlight last inserted text
nnoremap        gV              `[v`]
" Leader+s, Turn of highlighting search matches
nnoremap        <Leader><space> :nohlsearch<CR>
" Leader+1, Truncate to first 100 characters on-line
noremap         <Leader>1       ^100<Right>C<ESC>
" Leader+l, Run linters, PLUGIN: python-mode
noremap         <Leader>l       :PymodeLint<CR>
" Leader+r, Show Coverage, PLUGIN: coveragepy.vim
noremap         <Leader>r       :silent Coveragepy report<CR>
" Leader+R, Show/hide Coverage window, PLUGIN: coveragepy.vim
noremap         <Leader>R       :Coveragepy session<CR>
" Leader+w, Cycle through text-width definitions
noremap         <Leader>w       :call CycleTextWidth()<CR>
" Leader+i, Split multiple imports on one line into a multi-line tuple-import
noremap         <Leader>i       :Isort<CR>
" Leader+z, Clear all CtrlP caches
noremap         <Leader>z       :ClearAllCtrlPCaches<CR>
" Leader+n, Toggle relative numbers
noremap         <Leader>n       :call ToggleNumber()<CR>
" }}}
" vim:foldmethod=marker:foldlevel=0
