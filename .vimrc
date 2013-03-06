" ~/.vimrc by Matthew de Verteuil <onceuponajooks@gmail.com>
" Based on version by: Marius Gedminas <marius@gedmin.as>
" for VIM version 6 or later
"
" You will need to install exuberant-ctags from APT
"

"
" Options                                                       {{{1
"
set nocompatible                " be sane (default if you have a .vimrc)

" Presentation                                                  {{{2
set laststatus=2                " always show a status line
set cmdheight=2                 " avoid 'Press ENTER to continue'
set guioptions-=L               " disable left scrollbar in GUI
set guioptions-=m               " disable GUI menu
set showcmd                     " show partial commands in status line
set ruler                       " show cursor position in status line
set list                        " show tabs and spaces at end of line:
set listchars=tab:>-,trail:.,extends:>
set number
set textwidth=110
if has("linebreak")
  let &sbr = nr2char(8618).' '  " Show ↪ at the beginning of wrapped lines
endif
if has("extra_search")
  set hlsearch                  " highlight search matches
  nohlsearch                    " but not initially
endif


if v:version >= 600
  set listchars+=precedes:<
endif

if v:version >= 703
  set colorcolumn=111           " highlight column 111
"""  if exists('colorcolumn_hack')
"""    " just playing around; this is not actually a good idea (also, slow)
"""    for col in range(82, 200)
"""      let &colorcolumn = &colorcolumn . "," . col
"""    endfor
"""  endif
endif

" Fonts

if has("gui_gtk2")
    set guifont=Letter\ Gothic\ Line\ 11
elseif has("gui_macvim")
    set guifont=LetterGothicLineMonospace:h14
elseif has("gui_win32")
    set guifont=LetterGothicLineMonospace:h14
endif

set linespace=5

" Silence                                                       {{{2
set noerrorbells                " don't beep!
set visualbell                  " don't beep!
set t_vb=                       " don't beep! (but also see below)

" Interpreting file contents                                    {{{2
set modelines=5                 " debian disables this by default
set fileencodings=ucs-bom,utf-8,windows-1252,iso-8859-13,latin1 " autodetect
        " Vim cannot distinguish between 8-bit encodings, so the last two
        " won't ever be considered.  I keep them here for convenience:
        " :set fencs=<tab>, then delete the ones you don't want

" Backup files                                                  {{{2
set backup                      " make backups
set backupdir=~/tmp             " but don't clutter $PWD with them

if $USER == "root"
  " 'sudo vi' on certain machines cannot write to ~/tmp (NFS root-squash)
  set backupdir=/root/tmp
endif

if !isdirectory(&backupdir)
  " create the backup directory if it doesn't already exist
  exec "silent !mkdir -p " . &backupdir
endif

" Avoiding excessive I/O                                        {{{2
set swapsync=                   " be more friendly to laptop mode (dangerous)
                                " this could result in data loss, so beware!
if v:version >= 700
  set nofsync                   " be more friendly to laptop mode (dangerous)
                                " this could result in data loss, so beware!
endif

" Behaviour                                                     {{{2
set wildmenu                    " nice tab-completion on the command line
set wildmode=longest,full       " nicer tab-completion on the command line
set hidden                      " side effect: undo list is not lost on C-^
set browsedir=buffer            " :browse e starts in %:h, not in $PWD
set autoread                    " automatically reload files changed on disk
set history=1000                " remember more lines of cmdline history
set switchbuf=useopen           " quickfix reuses open windows
set iskeyword-=/                " Ctrl-W in command-line stops at /

if has('mouse_xterm')
  set mouse=a                   " use mouse in xterms
endif

if v:version >= 600
  set clipboard=unnamed         " interoperate with the X clipboard
  set splitright                " self-explanatory
endif

if v:version >= 700
  set diffopt+=vertical         " split diffs vertically
  set spelllang=en,ja           " spell-check two languages at once
endif

" Movement                                                      {{{2
set incsearch                   " incremental searching
set scrolloff=2                 " always keep cursor 2 lines from screen edge
set nostartofline               " don't jump to start of line

" Folding                                                       {{{2
if v:version >= 600
  set foldmethod=marker         " use folding by markers by default
  set foldlevelstart=9999       " initially open all folds
endif

" Editing                                                       {{{2
set backspace=indent,eol,start  " sane backspacing
set nowrap                      " do not wrap long lines
set shiftwidth=4                " more-or-less sane indents
set softtabstop=4               " make the <tab> key more useful
set tabstop=8                   " anything else is heresy
set expandtab                   " sane default
set noshiftround                " do NOT enforce the indent
set autoindent                  " automatic indent
set nosmartindent               " but no smart indent (ain't smart enough)
set isfname-=\=                 " fix filename completion in VAR=/path

" Editing code                                                  {{{2
set path+=/usr/include/i386-linux-gnu/  " multiarch on ubuntu
set path+=**                    " let :find do recursive searches
set tags-=./TAGS                " ignore emacs tags to prevent duplicates
set tags-=TAGS                  " ignore emacs tags to prevent duplicates
set tags-=./tags                " bin/tags is not a tags file;
set tags+=tags;$HOME            " look for tags in parent dirs
set suffixes+=.class            " ignore Java class files
set suffixes+=.pyc,.pyo         " ignore compiled Python files
set suffixes+=.~1~,.~2~         " ignore Bazaar droppings
set wildignore+=*.pyc,*.pyo     " same as 'suffixes', but for tab completion
set wildignore+=*.o,*.d,*.so    " same as 'suffixes', but for tab completion
set wildignore+=*~              " same as 'suffixes', but for tab completion
set wildignore+=local/**        " virtualenv creates a local -> . symlink

if v:version >= 700
  set complete-=i               " don't autocomplete from included files (too slow)
  " The following doesn't seem to do what I want it to do -- i.e. let me
  " complete common phrases with ^X^L.  Should I look for a snippet plugin?
  set complete+=k~/.vim/python-snippets
endif

" Python tracebacks (unittest + doctest output)                 {{{2
set errorformat&
set errorformat+=
            \File\ \"%f\"\\,\ line\ %l%.%#,
            \%C\ %.%#,
            \%-A\ \ File\ \"unittest%.py\"\\,\ line\ %.%#,
            \%-A\ \ File\ \"%f\"\\,\ line\ 0%.%#,
            \%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,
            \%Z%[%^\ ]%\\@=%m

" Shell scripts                                                 {{{2
if has("eval")
  let g:is_posix = 1            " /bin/sh is POSIX, not ancient Bourne shell
endif
" Persistent undo (vim 7.3+)                                    {{{2
if has("persistent_undo")
  set undofile                  " enable persistent undo
  let &undodir=&backupdir . "/.vimundo" " but don't clutter $PWD
  if !isdirectory(&undodir)
    " create the undo directory if it doesn't already exist
    exec "silent !mkdir -p " . &undodir
  endif
endif

" Netrw explorer                                                {{{2
if has("eval")
  let g:netrw_keepdir = 1                       " does not work!
  let g:netrw_list_hide = '.*\.swp\($\|\t\),.*\.py[co]\($\|\t\)'
  let g:netrw_sort_sequence = '[\/]$,*,\.bak$,\.o$,\.h$,\.info$,\.swp$,\.obj$,\.py[co]$'
  let g:netrw_timefmt = '%Y-%m-%d %H:%M:%S'
  let g:netrw_use_noswf = 1
endif

"
" Plugins                                                       {{{1
"
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
if has("user_commands")
  set rtp+=~/.vim/bundle/vundle/
  runtime autoload/vundle.vim " apparently without this the exists() check fails
endif
if exists("*vundle#rc")
  " NB:
  "   <graywh> you would want to call vundle#rc() *before* filetype on
  "            so bundles' ftdetect scripts are loaded
  filetype off
  call vundle#rc()
  Bundle "gmarik/vundle"
  Bundle "scrooloose/syntastic"
  Bundle "fugitive.vim"
  Bundle "git://git.wincent.com/command-t.git"
  Bundle "Gundo"
  Bundle "fugitive.vim"
  Bundle "Solarized"
  Bundle "alfredodeza/coveragepy.vim"
  Bundle "spiiph/vim-space"
  Bundle "majutsushi/tagbar"
  Bundle "Conque-Shell"
  Bundle "pytest.vim"
  Bundle 'Rykka/riv.vim'
  Bundle "Conque-Shell"
  Bundle "nvie/vim-flake8"
  Bundle "python-imports.vim"
  if iCanHazVundle == 0
      echo "Installing Bundles, please ignore key map error messages"
      echo ""
      :BundleInstall
      !cd ~/.vim/bundle/command-t/ruby/command-t/ && ruby extconf.rb && make
  endif
endif

set background="light"
let g:solarized_style="light"
colorscheme solarized

" Filetype plugins                                              {{{2
if v:version >= 600
  filetype plugin on            " load filetype plugins
  filetype indent on            " load indent plugins
endif

" Syntastic                                                     {{{2

if has("eval")
  let g:syntastic_check_on_open = 1
  let g:syntastic_enable_signs = 1
  let g:syntastic_enable_baloons = 1
  let g:syntastic_enable_highlighting = 1
  let g:syntastic_auto_jump = 0
  let g:syntastic_auto_loc_list = 2
" let g:syntastic_quiet_warnings = 1
" let g:syntastic_disabled_filetypes = ['ruby', 'php']

  " statusline format
  let g:syntastic_stl_format = '[%t errs, 1st on line %F]'
endif

" Lusty explorer                                                {{{2
" (I dropped it in favour of command-t)

if has("eval")
  let g:LustyExplorerSuppressRubyWarning = 1
endif

" Command-t                                                     {{{2

if has("eval")
  let g:CommandTCursorEndMap = ['<C-e>', '<End>']
  let g:CommandTCursorStartMap = ['<C-a>', '<Home>']
  let g:CommandTMaxHeight = 20
endif

"" Manual pages (:Man foo)                                      {{{2
if v:version >= 600
  runtime ftplugin/man.vim
endif

" Python syntax highligting                                     {{{2
" from http://hlabs.spb.ru/vim/python.vim
if has("eval")
  let python_highlight_all = 1
  let python_slow_sync = 1
endif

" Pytest keys
map             <Leader>k              :Pytest method<CR>
map             <Leader>K              :Pytest method -s<CR>
map             <Leader>l              :Pytest file<CR>
map             <Leader>L              :Pytest file -s<CR>
map             <Leader>;              :Pytest module<CR>
map             <Leader>:              :Pytest module -s<CR>
map             <Leader>cr              :Coveragepy report<CR>
map             <Leader>cs              :Coveragepy show<CR>

imap             <Leader>c              <ESC>:q<CR>
nmap             <Leader>c              <ESC>:q<CR>

map             <Leader>Cr              :Coveragepy report<CR>
map             <Leader>Cs              :Coveragepy show<CR>
if has("user_commands")
  " :Co now expands to :CommandT, but I'm used to type it as a shortcut for
  " :CopyTestUnderCursor
  command! Co CopyTestUnderCursor
  " :E is now ambiguous, but I'm used to it
  command! E Explore
endif

" XML syntax folding                                            {{{2
if has("eval")
  let xml_syntax_folding = 1
endif

" XML tag complyetion                                           {{{2
if has("eval")
  " because autocompleting when I type > is irritating half of the time
  let xml_tag_completion_map = "<C-l>"
endif

" VCSCommand configuration                                      {{{2
if has("eval")
  " I want 'edit' for VCSAnnotate, but 'split' for all others :(
  let VCSCommandEdit = 'split'
  let VCSCommandDeleteOnHide = 1
  let VCSCommandCommitOnWrite = 0
endif

" git ftplugin                                                  {{{2
if has("eval")
  let git_diff_spawn_mode = 1
endif

" surround.vim                                                  {{{2
" make it not clobber 's' in visual mode
vmap <Leader>s <Plug>Vsurround
vmap <Leader>S <Plug>VSurround

" NERD_tree.vim                                                 {{{2
if v:version >= 700 && has("eval")
  let g:NERDTreeIgnore= ['\.pyc$', '\~$']
  let g:NERDTreeHijackNetrw = 0
endif

"
" Status line                                                   {{{1
"

" I need to do this _after_ setting plugin options, since my statusline
" relies on functions defined in some plugins, so I want to try to source
" those plugins early to check if I need to define fallback functions, in
" case those plugins are unavailable.

" To emulate the standard status line with 'ruler' set, use this:
"
"   set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"
" I've tweaked it a bit to show the buffer number on the left, and the total
" number of lines on the right.  Also, show the current Python function in the
" status line, if the pythonhelper.vim plugin exists and can be loaded.

runtime plugin/pythonhelper.vim
if !exists("*TagInStatusLine")
  function TagInStatusLine()
    return ''
  endfunction
endif

runtime plugin/syntastic.vim
if !exists("*SyntasticStatuslineFlag")
  function! SyntasticStatuslineFlag()
    return ''
  endfunction
endif

if !exists("*haslocaldir")
  function! HasLocalDir()
    return ''
  endfunction
else
  function! HasLocalDir()
    if haslocaldir()
      return '[lcd]'
    endif
    return ''
  endfunction
endif

set statusline=                 " my status line contains:
set statusline+=%n:             " - buffer number, followed by a colon
set statusline+=%<%f            " - relative filename, truncated from the left
set statusline+=\               " - a space
set statusline+=%h              " - [Help] if this is a help buffer
set statusline+=%m              " - [+] if modified, [-] if not modifiable
set statusline+=%r              " - [RO] if readonly
set statusline+=%2*%{HasLocalDir()}%*           " [lcd] if :lcd has been used
set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%*
set statusline+=\               " - a space
set statusline+=%1*%{TagInStatusLine()}%*       " [current class/function]
set statusline+=\               " - a space
set statusline+=%=              " - right-align the rest
set statusline+=%-10.(%l,%c%V%) " - line,column[-virtual column]
set statusline+=\               " - a space
set statusline+=%4L             " - total number of lines in buffer
set statusline+=\               " - a space
set statusline+=%P              " - position in buffer as percentage

" Other notes:
"   %1*         -- switch to highlight group User1
"   %{}         -- embed the output of a vim function
"   %*          -- switch to the normal highlighting
"   %=          -- right-align the rest
"   %-10.(...%) -- left-align the group inside %(...%)


"
" Commands                                                      {{{1
"

if has("user_commands")

" how many occurrences of the current search pattern?           {{{2
command! CountMatches                   %s///n

" die, trailing whitespace! die!                                {{{2
command! NukeTrailingWhitespace         %s/\s\+$//

" diffoff sets wrap; don't wanna                                {{{2
command! Diffoff                        setlocal nodiff noscrollbind fdc=0

" See :help DiffOrig                                            {{{2
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                  \ | wincmd p | diffthis

" svncommand aliases that I'm used to                           {{{2
command! -nargs=* SVNAdd                VCSAdd <args>
command! -nargs=* SVNBlame              VCSAnnotate <args>
command! -nargs=? -bang SVNCommit       VCSCommit<bang> <args>
command! -nargs=* SVNDiff               VCSDiff <args>
command! -nargs=* SVNLog                VCSLog <args>
command! -nargs=0 SVNRevert             VCSRevert <args>
command! -nargs=* SVNStatus             VCSStatus <args>
command! -nargs=0 SVNUpdate             VCSUpdate <args>
command! -nargs=* SVNVimDiff            VCSVimDiff <args>

command! -nargs=* BZRVimDiff            VCSVimDiff <args>

" :CW                                                           {{{2
command! CW             botright cw

" Highlight group debugging                                     {{{2
function! s:SynAttrs(id)
  return ""
    \ . (synIDattr(a:id, "font") != "" ? ' font:' . synIDattr(a:id, "font") : "")
    \ . (synIDattr(a:id, "fg") != ""  ? ' fg:' . synIDattr(a:id, "fg") : "")
    \ . (synIDattr(a:id, "bg") != ""  ? ' bg:' . synIDattr(a:id, "bg") : "")
    \ . (synIDattr(a:id, "sp") != ""  ? ' sp:' . synIDattr(a:id, "sp") : "")
    \ . (synIDattr(a:id, "bold") ? " bold" : "")
    \ . (synIDattr(a:id, "italic") ? " italic" : "")
    \ . (synIDattr(a:id, "reverse") ? " reverse" : "")
    \ . (synIDattr(a:id, "standout") ? " standout" : "")
    \ . (synIDattr(a:id, "underline") ? " underline" : "")
    \ . (synIDattr(a:id, "undercurl") ? " undercurl" : "")
endf
function! s:ShowHighlightGroup()
  let hi = synID(line("."), col("."), 1)
  let trans = synID(line("."), col("."), 0)
  let lo = synIDtrans(hi)
  " In my experiments s:SynAttrs() always returns "" for hi and trans
  echo "hi<" . synIDattr(hi, "name") . '>'
    \ . s:SynAttrs(hi)
    \ . ' trans<' . synIDattr(trans, "name") . '>'
    \ . s:SynAttrs(trans)
    \ . ' lo<' . synIDattr(lo, "name") . '>'
    \ . s:SynAttrs(lo)
endf
function! s:ShowSyntaxStack()
  for id in synstack(line("."), col("."))
    echo printf("%-20s %s", synIDattr(id, "name"), s:SynAttrs(synIDtrans(id)))
  endfor
endf
command! ShowHighlightGroup call s:ShowHighlightGroup()
command! ShowSyntaxStack call s:ShowSyntaxStack()

" :NoLCD                                                        {{{2
command! NoLCD          exe 'cd '.getcwd()

endif " has("user_commands")

"
" Keyboard macros                                               {{{1
"

" Digraphs                                                      {{{2

if has("digraphs")
  digraph -- 8212               " em dash
  digraph `` 8220               " left double quotation mark
  digraph '' 8221               " right double quotation mark
  digraph ,, 8222               " double low-9 quotation mark
endif

" Remember columns when jumping to marks                        {{{2
map             '               `

" Undo in insert mode                                           {{{2
" make it so that if I accidentally press ^W or ^U in insert mode,
" then <ESC>u will undo just the ^W/^U, and not the whole insert
" This is documented in :help ins-special-special, a few pages down
inoremap <C-W> <C-G>u<C-W>
inoremap <C-U> <C-G>u<C-U>

" */# search in visual mode (from www.vim.org)                  {{{2

" Atom \V sets following pattern to "very nomagic", i.e. only the backslash
" has special meaning.
" As a search pattern we insert an expression (= register) that
" calls the 'escape()' function on the unnamed register content '@@',
" and escapes the backslash and the character that still has a special
" meaning in the search command (/|?, respectively).
" This works well even with <Tab> (no need to change ^I into \t),
" but not with a linebreak, which must be changed from ^M to \n.
" This is done with the substitute() function.
" See http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>
vnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>

" Diffget/diffput in visual mode                                {{{2

vmap            \do             :diffget<CR>
vmap            \dp             :diffput<CR>

" S-Insert pastes                                               {{{2
map!            <S-Insert>      <MiddleMouse>

" .vimrc editing                                                {{{2
set wildcharm=<C-Z>
map             ,e              :e $HOME/.vim/vimrc<CR>
map             ,s              :source $HOME/.vim/vimrc<CR>
map             ,PE             :e $HOME/.vim/plugin/<C-Z><C-Z>
map             ,IE             :e $HOME/.vim/indent/<C-Z><C-Z>
map             ,FE             :e $HOME/.vim/ftplugin/<C-Z><C-Z>
map             ,XE             :e $HOME/.vim/syntax/<C-Z><C-Z>

" snipmate snippets!
map <expr>      ,SE             ":e $HOME/.vim/snippets/".&ft."-mg.snippets\<CR>"
map             ,SS             :call ReloadAllSnippets()<CR>

" open a file in the same dir as the current one                {{{2
map <expr>      ,E              ":e ".expand("%:h")."/"
map <expr>      ,,E             ":e ".expand("%:h:h")."/"
map <expr>      ,,,E            ":e ".expand("%:h:h:h")."/"
map <expr>      ,R              ":e ".expand("%:r")."."

" close just the deepest level of folds                         {{{2
map             ,zm             zMzRzm

" Scrolling with Ctrl+Up/Down                                   {{{2
map             <C-Up>          1<C-U>
map             <C-Down>        1<C-D>
imap            <C-Up>          <C-O><C-Up>
imap            <C-Down>        <C-O><C-Down>

" Scrolling with Ctrl+Shift+Up/Down                             {{{2
map             <C-S-Up>        1<C-U><Down>
map             <C-S-Down>      1<C-D><Up>
imap            <C-S-Up>        <C-O><C-S-Up>
imap            <C-S-Down>      <C-O><C-S-Down>

" Moving around with Shift+Up/Down                              {{{2
map             <S-Up>          {
map             <S-Down>        }
imap            <S-Up>          <C-O><S-Up>
imap            <S-Down>        <C-O><S-Down>

" Navigating around windows
map             <C-W><C-W>      :q<cr>
map             <C-W><C-Up>     <C-W><Up>
map             <C-W><C-Down>   <C-W><Down>
map             <C-W><C-Left>   <C-W><Left>
map             <C-W><C-Right>  <C-W><Right>
map             <C-S-Up>        <C-W><Up>
map             <C-S-Down>      <C-W><Down>
map             <C-S-Left>      <C-W><Left>
map             <C-S-Right>     <C-W><Right>
map!            <C-S-Up>        <C-O><C-W><Up>
map!            <C-S-Down>      <C-O><C-W><Down>
map!            <C-S-Left>      <C-O><C-W><Left>
map!            <C-S-Right>     <C-O><C-W><Right>

" Switching tabs with Ctrl+Tab/etc in gvim                      {{{2
nnoremap            <F11>           :Pytest file -s<cr>
nnoremap            <F12>           :TagbarOpen<cr>
nnoremap            <C-t>           :tabnew<cr>
noremap             <C-t>           :tabnew<cr>
noremap             <F11>           :Pytest file -s<cr>
noremap             <F12>           :TagbarOpen<cr>
inoremap            <C-t>           <ESC>:tabnew<cr>

" Emacs style command line                                      {{{2
cnoremap        <C-G>           <C-C>
cnoremap        <C-A>           <Home>
cnoremap        <Esc>b          <S-Left>
cnoremap        <Esc>f          <S-Right>

" I wanted <C-K> to delete to eol, but its primary function is too useful
" and the implementation (with <C-F>) is too irritating
""cnoremap      <C-K>           <C-F>D<C-C><Right>
" although here's a non-irritating implementation
cmap            <C-K>   <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>

" Alt-Backspace deletes word backwards
cnoremap        <M-BS>          <C-W>

" Do not lose "complete all"
cnoremap        <C-S-A>         <C-A>

" Windows style editing                                         {{{2
imap            <C-Del>         <C-O>dw
imap            <C-Backspace>   <C-O>db

map             <S-Insert>      "+p
imap            <S-Insert>      <C-O><S-Insert>
vmap            <C-Insert>      "+y

" ^Z = undo
imap            <C-Z>           <C-O>u

" Function keys                                                 {{{2

" <F1> = help (default)
"-" Disable F1 -- it gets in the way of Esc on my ThinkPad
"-map           <F1>    <Nop>
"-imap          <F1>    <Nop>

" <F2> = save
map             <F2>            :update<CR>
imap            <F2>            <C-O><F2>

" <F3> = turn off search highlighting
map             <F3>            :nohlsearch<CR>
imap            <F3>            <C-O><F3>

" <S-F3> = turn off location list
map             <S-F3>            :lclose<CR>
imap            <S-F3>            <C-O><S-F3>

" <C-F3> = turn off quickfix
map             <C-F3>            :cclose<CR>
imap            <C-F3>            <C-O><C-F3>

" <F4> = next error/grep match
"" depends on plugin/quickloclist.vim
map             <F4>            :FirstOrNextInList<CR>
imap            <F4>            <C-O><F4>
" <S-F4> = previous error/grep match
map             <S-F4>          :PrevInList<CR>
imap            <S-F4>          <C-O><S-F4>
" <C-F4> = current error/grep match
map             <C-F4>          :CurInList<CR>
imap            <C-F4>          <C-O><C-F4>

""" <F5> = close location list (overriden by ImportName in .py files)
""map             <F5>            :lclose<CR>
""imap            <F5>            <C-O><F5>

" <F6> = switch files
map             <F6>            <C-^>
imap            <F6>            <C-O><F6>
" <C-F6> = toggle .c/.h (see above) or code/test (see below)

" <F7> = jump to tag/filename+linenumber in the clipboard
map             <F7>            :ClipboardTest<CR>

" <F8> = highlight identifier under cursor
" (some file-type dependent autocommands redefine it)
map             <F8>            :let @/='\<'.expand('<cword>').'\>'<bar>set hls<CR>

" <F9> = make
map             <F9>    :make<CR>
imap            <F9>    <C-O><F9>

" <F10> = quit
" (some file-type dependent autocommands redefine it)
""map           <F10>           :q<CR>
""imap          <F10>           <ESC>

" <F11> = toggle 'paste'
set pastetoggle=<F11>

" <F12> = show the Unicode name of the character under cursor
"map             <F12>           :UnicodeName<CR>
" <S-F12> = show highlight group under cursor
"map             <S-F12>         :ShowHighlightGroup<CR>
" <C-F12> = show syntax stack under cursor
"map             <C-F12>         :ShowSyntaxStack<CR>

"
" Keyboard workarounds                                          {{{1
"

" xterm keys                                                    {{{2

"   keypad                                                      {{{3
map             <Esc>[5A        <C-Up>
map             <Esc>[5B        <C-Down>
map             <Esc>[5D        <C-Left>
map             <Esc>[5C        <C-Right>
map!            <Esc>[5A        <C-Up>
map!            <Esc>[5B        <C-Down>
map!            <Esc>[5D        <C-Left>
map!            <Esc>[5C        <C-Right>

map             <Esc>[2D        <S-Left>
map             <Esc>[2C        <S-Right>
map!            <Esc>[2D        <S-Left>
map!            <Esc>[2C        <S-Right>

map             <Esc>O6A        <C-S-Up>
map             <Esc>O6B        <C-S-Down>
map             <Esc>O6D        <C-S-Left>
map             <Esc>O6C        <C-S-Right>
map!            <Esc>O6A        <C-S-Up>
map!            <Esc>O6B        <C-S-Down>
map!            <Esc>O6D        <C-S-Left>
map!            <Esc>O6C        <C-S-Right>

map             <Esc>[5H        <C-Home>
map             <Esc>[5F        <C-End>
map             <Esc>[5;5~      <C-PageUp>
map             <Esc>[6;5~      <C-PageDown>
map!            <Esc>[5H        <C-Home>
map!            <Esc>[5F        <C-End>
map!            <Esc>[5;5~      <C-PageUp>
map!            <Esc>[6;5~      <C-PageDown>

"   keypad in screen                                            {{{3
map             <Esc>O5A        <C-Up>
map             <Esc>O5B        <C-Down>
map             <Esc>O5D        <C-Left>
map             <Esc>O5C        <C-Right>
map!            <Esc>O5A        <C-Up>
map!            <Esc>O5B        <C-Down>
map!            <Esc>O5D        <C-Left>
map!            <Esc>O5C        <C-Right>

map             <Esc>O2D        <S-Left>
map             <Esc>O2C        <S-Right>
map!            <Esc>O2D        <S-Left>
map!            <Esc>O2C        <S-Right>

map             <Esc>O5H        <C-Home>
map             <Esc>O5F        <C-End>
map!            <Esc>O5H        <C-Home>
map!            <Esc>O5F        <C-End>

"   function keys                                               {{{3
map             <Esc>O5P        <C-F1>
map             <Esc>O5Q        <C-F2>
map             <Esc>O5R        <C-F3>
map             <Esc>O5S        <C-F4>
map             <Esc>[15;5~     <C-F5>
map             <Esc>[17;5~     <C-F6>
map             <Esc>[18;5~     <C-F7>
map             <Esc>[19;5~     <C-F8>
map             <Esc>[20;5~     <C-F9>
map             <Esc>[21;5~     <C-F10>
map             <Esc>[23;5~     <C-F11>
map             <Esc>[24;5~     <C-F12>
map!            <Esc>O5P        <C-F1>
map!            <Esc>O5Q        <C-F2>
map!            <Esc>O5R        <C-F3>
map!            <Esc>O5S        <C-F4>
map!            <Esc>[15;5~     <C-F5>
map!            <Esc>[17;5~     <C-F6>
map!            <Esc>[18;5~     <C-F7>
map!            <Esc>[19;5~     <C-F8>
map!            <Esc>[20;5~     <C-F9>
map!            <Esc>[21;5~     <C-F10>
map!            <Esc>[23;5~     <C-F11>
map!            <Esc>[24;5~     <C-F12>
" rxvt keys                                                     {{{2

"   keypad                                                      {{{3
map             <Esc>[a         <S-Up>
map             <Esc>[b         <S-Down>
map             <Esc>[d         <S-Left>
map             <Esc>[c         <S-Right>
map!            <Esc>[a         <S-Up>
map!            <Esc>[b         <S-Down>
map!            <Esc>[d         <S-Left>
map!            <Esc>[c         <S-Right>

map             <Esc>[2$        <S-Insert>
map             <Esc>[3$        <S-Del>
map!            <Esc>[2$        <S-Insert>
map!            <Esc>[3$        <S-Del>
" Other shifted keypad keys are used for scrollback and pasting

map             <Esc>Oa         <C-Up>
map             <Esc>Ob         <C-Down>
map             <Esc>Od         <C-Left>
map             <Esc>Oc         <C-Right>
map!            <Esc>Oa         <C-Up>
map!            <Esc>Ob         <C-Down>
map!            <Esc>Od         <C-Left>
map!            <Esc>Oc         <C-Right>

map             <Esc>[2^        <C-Insert>
map             <Esc>[3^        <C-Del>
map!            <Esc>[2^        <C-Insert>
map!            <Esc>[3^        <C-Del>
map             <Esc>[3;5~      <C-Del>
map!            <Esc>[3;5~      <C-Del>

map             <Esc>[5^        <C-PageUp>
map             <Esc>[6^        <C-Pagedown>
map             <Esc>[7^        <C-Home>
map             <Esc>[8^        <C-End>
map!            <Esc>[5^        <C-PageUp>
map!            <Esc>[6^        <C-Pagedown>
map!            <Esc>[7^        <C-Home>
map!            <Esc>[8^        <C-End>

"   numeric keypad                                              {{{3
map             <Esc>Ox         <S-Up>
map             <Esc>Or         <S-Down>
map             <Esc>Ot         <S-Left>
map             <Esc>Ov         <S-Right>
map!            <Esc>Ox         <S-Up>
map!            <Esc>Or         <S-Down>
map!            <Esc>Ot         <S-Left>
map!            <Esc>Ov         <S-Right>

map             <Esc>Op         <S-Insert>
map             <Esc>On         <S-Del>
map!            <Esc>Op         <S-Insert>
map!            <Esc>On         <S-Del>

map             <Esc>Ow         <S-kHome>
map             <Esc>Oq         <S-kEnd>
map             <Esc>Oy         <S-kPageUp>
map             <Esc>Os         <S-kPageDown>
map!            <Esc>Ow         <S-kHome>
map!            <Esc>Oq         <S-kEnd>
map!            <Esc>Oy         <S-kPageUp>
map!            <Esc>Os         <S-kPageDown>

" Ignore KP_CENTER
map             <Esc>Ou         <Nop>
map!            <Esc>Ou         <Nop>

"   function keys                                               {{{3
map             <Esc>[25~       <S-F3>
map             <Esc>[26~       <S-F4>
map             <Esc>[28~       <S-F5>
map             <Esc>[29~       <S-F6>
map             <Esc>[31~       <S-F7>
map             <Esc>[32~       <S-F8>
map             <Esc>[33~       <S-F9>
map             <Esc>[34~       <S-F10>
map             <Esc>[23$       <S-F11>
map             <Esc>[24$       <S-F12>
map!            <Esc>[25~       <S-F3>
map!            <Esc>[26~       <S-F4>
map!            <Esc>[28~       <S-F5>
map!            <Esc>[29~       <S-F6>
map!            <Esc>[31~       <S-F7>
map!            <Esc>[32~       <S-F8>
map!            <Esc>[33~       <S-F9>
map!            <Esc>[34~       <S-F10>
map!            <Esc>[23$       <S-F11>
map!            <Esc>[24$       <S-F12>

map             <Esc>[11^       <C-F1>
map             <Esc>[12^       <C-F2>
map             <Esc>[13^       <C-F3>
map             <Esc>[14^       <C-F4>
map             <Esc>[15^       <C-F5>
map             <Esc>[17^       <C-F6>
map             <Esc>[18^       <C-F7>
map             <Esc>[19^       <C-F8>
map             <Esc>[20^       <C-F9>
map             <Esc>[21^       <C-F10>
map             <Esc>[23^       <C-F11>
map             <Esc>[24^       <C-F12>
map!            <Esc>[11^       <C-F1>
map!            <Esc>[12^       <C-F2>
map!            <Esc>[13^       <C-F3>
map!            <Esc>[14^       <C-F4>
map!            <Esc>[15^       <C-F5>
map!            <Esc>[17^       <C-F6>
map!            <Esc>[18^       <C-F7>
map!            <Esc>[19^       <C-F8>
map!            <Esc>[20^       <C-F9>
map!            <Esc>[21^       <C-F10>
map!            <Esc>[23^       <C-F11>
map!            <Esc>[24^       <C-F12>

" gnome-terminal keys in Feisty                                 {{{2
map             <Esc>O1;5A      <C-Up>
map             <Esc>O1;5B      <C-Down>
map             <Esc>O1;5D      <C-Left>
map             <Esc>O1;5C      <C-Right>
map!            <Esc>O1;5A      <C-Up>
map!            <Esc>O1;5B      <C-Down>
map!            <Esc>O1;5D      <C-Left>
map!            <Esc>O1;5C      <C-Right>
map             <Esc>O1;6A      <C-S-Up>
map             <Esc>O1;6B      <C-S-Down>
map             <Esc>O1;6D      <C-S-Left>
map             <Esc>O1;6C      <C-S-Right>
map!            <Esc>O1;6A      <C-S-Up>
map!            <Esc>O1;6B      <C-S-Down>
map!            <Esc>O1;6D      <C-S-Left>
map!            <Esc>O1;6C      <C-S-Right>

" gnome-terminal keys in Gutsy                                  {{{2
map             <Esc>O1;2P      <S-F1>
map             <Esc>O1;2Q      <S-F2>
map             <Esc>O1;2R      <S-F3>
map             <Esc>O1;2S      <S-F4>
map             <Esc>[15;2~     <S-F5>
map             <Esc>[17;2~     <S-F6>
map             <Esc>[18;2~     <S-F7>
map             <Esc>[19;2~     <S-F8>
map             <Esc>[20;2~     <S-F9>
" <S-F10> is not available
map             <Esc>[23;2~     <S-F11>
map             <Esc>[24;2~     <S-F12>
map!            <Esc>O1;2P      <S-F1>
map!            <Esc>O1;2Q      <S-F2>
map!            <Esc>O1;2R      <S-F3>
map!            <Esc>O1;2S      <S-F4>
map!            <Esc>[15;2~     <S-F5>
map!            <Esc>[17;2~     <S-F6>
map!            <Esc>[18;2~     <S-F7>
map!            <Esc>[19;2~     <S-F8>
map!            <Esc>[20;2~     <S-F9>
" <S-F10> is not available
map!            <Esc>[23;2~     <S-F11>
map!            <Esc>[24;2~     <S-F12>

" <C-F1> is not available
map             <Esc>O1;5Q      <C-F2>
map             <Esc>O1;5R      <C-F3>
map             <Esc>O1;5S      <C-F4>
map             <Esc>[15;5~     <C-F5>
map             <Esc>[17;5~     <C-F6>
map             <Esc>[18;5~     <C-F7>
map             <Esc>[19;5~     <C-F8>
map             <Esc>[20;5~     <C-F9>
map             <Esc>[21;5~     <C-F10>
map             <Esc>[23;5~     <C-F11>
map             <Esc>[24;5~     <C-F12>
" <C-F1> is not available
map!            <Esc>O1;5Q      <C-F2>
map!            <Esc>O1;5R      <C-F3>
map!            <Esc>O1;5S      <C-F4>
map!            <Esc>[15;5~     <C-F5>
map!            <Esc>[17;5~     <C-F6>
map!            <Esc>[18;5~     <C-F7>
map!            <Esc>[19;5~     <C-F8>
map!            <Esc>[20;5~     <C-F9>
map!            <Esc>[21;5~     <C-F10>
map!            <Esc>[23;5~     <C-F11>
map!            <Esc>[24;5~     <C-F12>

" gnome-terminal keys in Hardy when ssh'ed into Dapper          {{{2
" also, gnome-terminal keys in Intrepid                         {{{2
map             <Esc>[1;5A      <C-Up>
map             <Esc>[1;5B      <C-Down>
map             <Esc>[1;5D      <C-Left>
map             <Esc>[1;5C      <C-Right>
map!            <Esc>[1;5A      <C-Up>
map!            <Esc>[1;5B      <C-Down>
map!            <Esc>[1;5D      <C-Left>
map!            <Esc>[1;5C      <C-Right>
map             <Esc>[1;6A      <C-S-Up>
map             <Esc>[1;6B      <C-S-Down>
map             <Esc>[1;6D      <C-S-Left>
map             <Esc>[1;6C      <C-S-Right>
map!            <Esc>[1;6A      <C-S-Up>
map!            <Esc>[1;6B      <C-S-Down>
map!            <Esc>[1;6D      <C-S-Left>
map!            <Esc>[1;6C      <C-S-Right>

"
" Autocommands                                                  {{{1
"

if has("autocmd")

" Kill visual bell! kill!                                       {{{2

au GUIEnter * set t_vb=

" Remember last position in a file                              {{{2
" see :help last-position-jump
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Autodetect filetype on first save                             {{{2
au BufWritePost * if &ft == "" | filetype detect | endif

" Gettext files                                                 {{{2

" TeX/LaTeX                                                     {{{2
function! FT_TeX()
  if v:version >= 600
    setlocal expandtab
    setlocal textwidth=78
  else
    set expandtab
    set textwidth=78
  endif

  " <F8> = start xdvi in background
  map  <buffer> <F8>    :!xdvi %:r.dvi&<CR><C-L>
  imap <buffer> <F8>    <C-O><F8>
  " <F9> = process file with LaTeX
  map  <buffer> <F9>    :!latex --src-specials % && killall -USR1 xdvi.bin 2>/dev/null<CR>
  imap <buffer> <F9>    <C-O><F9>
  " To get full benefits from --src-specials, put this in your ~/.Xresources:
  "   XDvi.editor: gvim --remote +%l %f

  " Abbreviations
  ab \b \begin
  ab \e \end
  ab \begin{e}  \begin{enumerate}
  ab \end{e}    \end{enumerate}
  ab \begin{i}  \begin{itemize}
  ab \end{i}    \end{itemize}
  ab \begin{a}  \begin{align*}
  ab \end{a}    \end{align*}
  ab \begin{eq} \begin{equation}
  ab \end{eq}   \end{equation}

  ab \i         \item
  ab \d         \documentclass[a4paper]{article}
  ab \D         \Def
  ab \f         \frac
  ab {\f        {\frac
  ab (\f        (\frac
  ab )\f        )\frac
  ab -\f        -\frac
endf

augroup TeX
  autocmd!
  autocmd FileType tex  call FT_TeX()
augroup END

" Programming in C/C++                                          {{{2
function! FT_C()
  if v:version >= 600
    setlocal formatoptions=croql
    setlocal cindent
    setlocal comments=sr:/*,mb:*,el:*/,://
    setlocal shiftwidth=4
  else
    set formatoptions=croql
    set cindent
    set comments=sr:/*,mb:*,el:*/,://
    set shiftwidth=4
  endif
endf

augroup C_prog
  autocmd!
  autocmd FileType c,cpp        call FT_C()
  autocmd BufRead,BufNewFile /home/mg/src/brogue-*/**/*.[ch]  setlocal ts=4
augroup END

" Programming in Java                                           {{{2
function! FT_Java()
  if v:version >= 600
    setlocal formatoptions=croql
    setlocal cindent
    setlocal comments=sr:/*,mb:*,el:*/,://
    setlocal shiftwidth=4
    "setlocal efm=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
  else
    set formatoptions=croql
    set cindent
    set comments=sr:/*,mb:*,el:*/,://
    set shiftwidth=4
    "set efm=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
  endif
endf

augroup Java_prog
  autocmd!
  autocmd FileType java         call FT_Java()
augroup END

" Programming in Perl                                           {{{2
function! FT_Perl()
  if v:version >= 600
    setlocal formatoptions=croql
""  setlocal smartindent
    setlocal shiftwidth=4
  else
    set formatoptions=croql
""  set smartindent
    set shiftwidth=4
  endif

  " <S-F9> = check syntax
  map  <buffer> <S-F9>  :!perl -c %<CR>
  imap <buffer> <S-F9>  <C-O><S-F9>
endf

augroup Perl_prog
  autocmd!
  autocmd FileType perl         call FT_Perl()
augroup END

" Programming in Python                                         {{{2

function! PythonFoldLevel(lineno)
  let line = getline(a:lineno)
  " XXX very primitive at the moment
  if line == ''
    let line = getline(a:lineno + 1)
    if line =~ '^\(def\|class\)\>'
      return 0
    elseif line =~ '^    \(def\|class\|#\)\>'
      return 1
    else
      let lvl = foldlevel(a:lineno + 1)
      return lvl >= 0 ? lvl : '-1'
    endif
  elseif line =~ '^\(def\|class\)\>'
    return '>1'
  elseif line =~ '^    \(def\|class\)\>'
    return '>2'
  elseif line =~ '^[^ ]' " XXX used to be [^ #]
    return 0
  elseif line =~ '^    [^ ]' " XXX used to be [^ #], why? what did I break by removing #?
    return 1
  else
    let lvl = foldlevel(a:lineno - 1)
    return lvl >= 0 ? lvl : '='
  endif
endf

function! FT_Python()
  if v:version >= 600
    setlocal formatoptions=croql
    setlocal shiftwidth=4
    setlocal softtabstop=4
    setlocal expandtab
    setlocal indentkeys-=<:>
    setlocal indentkeys-=:
    " XXX I think python's syntax file makes autoindenting work, so my hack
    " with smartindent and cinwords is obsolete.
    ""setlocal cinwords=if,else,elif,while,for,try,except,finally,def,class
    ""setlocal smartindent " but it annoys me by not shifting # comment lines
    if &foldmethod != 'diff'
      setlocal foldmethod=expr
    endif
    setlocal foldexpr=PythonFoldLevel(v:lnum)
    " I don't want [I to parse import statements and look for modules
    setlocal include=

    " I work with Pylons projects ('/foo.mako' -> templates/foo.mako) more
    " often than I press gf on dotted names (foo.bar -> foo/bar.py)
    setlocal includeexpr=substitute(v:fname,'^/','','')

    " I sometimes use ## as a comment marker
    setlocal comments+=b:##

    syn sync minlines=100

    match Error /\%>111v.\+/
    map <buffer> <F5> :call Flake8()<CR>
    map <buffer> <S-F5>    :call Pyflakes()<CR>
    map <buffer> <C-F5>  :Pytest file<CR>
    imap <buffer> <F5>   <C-O><F5>
    imap <buffer> <C-F5> <C-O><C-F5>
    map <buffer> <C-F6>  :SwitchCodeAndTest<CR>
    map <buffer> <F10>   :setlocal makeprg=pyflakes\ %\|make<CR>
  else
    set formatoptions=croql
""  set smartindent
    set shiftwidth=4
    set expandtab
  endif

  abbr _pdb import pdb; pdb.set_trace()
  abbr _main if __name__ == "__main__":<cr>    main()
  abbr _optparse parser = optparse.OptionParser("usage: %prog [options]"
  abbr improt import
endf

augroup Python_prog
  autocmd!
  autocmd FileType python       call FT_Python()
  autocmd BufRead,BufNewFile *  if expand('%:p') =~ 'ivija' | call FT_Python_Ivija() | endif
  autocmd BufRead,BufNewFile *  if expand('%:p') =~ 'schooltool' | let g:pyTestRunnerClipboardExtras='-pvc1' | let g:pyTestRunnerDirectoryFiltering = '' | let g:pyTestRunnerModuleFiltering = '' | endif
  autocmd BufRead,BufNewFile *  if expand('%:p') =~ 'cipher' | let g:pyTestRunnerClipboardExtras='-c' | endif
  autocmd BufRead,BufNewFile /var/lib/buildbot/masters/*/*.cfg  setlocal tags=/root/buildbot.tags
augroup END


augroup JS_prog
  autocmd!
  autocmd FileType javascript   map <buffer> <C-F6>  :SwitchCodeAndTest<CR>
augroup END


function! FT_Mako()
  setf html
  setlocal includeexpr=substitute(v:fname,'^/','','')
  setlocal indentexpr=
  setlocal indentkeys-={,}
  map <buffer> <C-F6>  :SwitchCodeAndTest<CR>
endf

augroup Mako_templ
  autocmd!
  autocmd BufRead,BufNewFile *.mako     call FT_Mako()
augroup END

" Zope                                                          {{{2

function! FT_XML()
  setf xml
  if v:version >= 700
    setlocal shiftwidth=2 softtabstop=2 expandtab fdm=syntax
  elseif v:version >= 600
    setlocal shiftwidth=2 softtabstop=2 expandtab
    setlocal indentexpr=
  else
    set shiftwidth=2 softtabstop=2 expandtab
  endif
endf

function! FT_Maybe_ReST()
  if glob(expand("%:p:h") . "/*.py") != ""
        \ || glob(expand("%:p:h:h") . "/*.py") != ""
    set ft=rest
    setlocal shiftwidth=4 softtabstop=4 expandtab
    map <buffer> <F5>    :ImportName <C-R><C-W><CR>
    map <buffer> <C-F5>  :ImportNameHere <C-R><C-W><CR>
    map <buffer> <C-F6>  :SwitchCodeAndTest<CR>
  endif
endf

augroup Zope
  autocmd!
  autocmd BufRead,BufNewFile *.zcml                     call FT_XML()
  autocmd BufRead,BufNewFile *.pt                       call FT_XML()
  autocmd BufRead,BufNewFile *.tt                       setlocal et tw=44 wiw=44
  autocmd BufRead,BufNewFile *.txt                      call FT_Maybe_ReST()
augroup END

" Diffs and patches                                             {{{2

function! DiffFoldLevel(lineno)
  let line = getline(a:lineno)
  if line =~ '^Index:'
    return '>1'
  elseif line =~ '^RCS file: ' || line =~ '^retrieving revision '
    let lvl = foldlevel(a:lineno - 1)
    return lvl >= 0 ? lvl : '='
  elseif line =~ '^=== ' && getline(a:lineno - 1) =~ '^$\|^[-+ ]'
    return '>1'
  elseif line =~ '^==='
    let lvl = foldlevel(a:lineno - 1)
    return lvl >= 0 ? lvl : '='
  elseif line =~ '^diff'
    return getline(a:lineno - 1) =~ '^retrieving revision ' ? '=' : '>1'
  elseif line =~ '^--- ' && getline(a:lineno - 1) !~ '^diff\|^==='
    return '>1'
  elseif line =~ '^@'
    return '>2'
  elseif line =~ '^[- +\\]'
    let lvl = foldlevel(a:lineno - 1)
    return lvl >= 0 ? lvl : '='
  else
    return '0'
  endif
endf

function! FT_Diff()
  if v:version >= 600
    setlocal foldmethod=expr
    setlocal foldexpr=DiffFoldLevel(v:lnum)
  else
  endif
endf

augroup Diffs
  autocmd!
  autocmd BufRead,BufNewFile *.patch    setf diff
  autocmd FileType diff                 call FT_Diff()
augroup END

" /root/Changelog                                               {{{2

function! FT_RootsChangelog()
  setlocal expandtab
  setlocal formatoptions=crql
  setlocal comments=b:#,fb:-
endf

augroup RootsChangelog
  autocmd!
  autocmd BufRead,BufNewFile /root/Changelog*   call FT_RootsChangelog()
augroup END

" blog posts                                                    {{{2

function! FT_MyBlog()
  setlocal sts=2 sw=2 spell ft=html
  map <buffer> <f5> :.!~/blog/blogify<cr>
  vmap <buffer> <f5> :!~/blog/blogify<cr>
  imap <buffer> <f5> <c-o><f5>
  map <buffer> <f9> :!~/blog/preview.sh<cr>
endf

augroup MyBlog
  autocmd!
  autocmd BufRead,BufNewFile ~/blog/data/*.txt  call FT_MyBlog()
  autocmd BufRead,BufNewFile ~/blog/blogify
              \ map <buffer> <F9> :wall\|setlocal makeprg=%\ --test\|make<CR>
augroup END

" BookServ dev                                                  {{{2

function! FT_BookServ_Py()
  let g:pyTestRunner = 'bin/test'
  let g:pyTestRunnerTestFiltering = "-m"
  let g:pyTestRunnerDirectoryFiltering = ""
  let g:pyTestRunnerPackageFiltering = ""
  let g:pyTestRunnerModuleFiltering = ""
  let g:pyTestRunnerClipboardExtras = ""
  let g:pyTestRunnerFilenameFiltering = " "
  setlocal path^=src/bookserv/templates,src/bookserv/public
  setlocal includeexpr=substitute(v:fname,'^/','','')
endf

augroup BookServ
  autocmd!
  autocmd BufRead,BufNewFile ~/src/bookserv/*.py        call FT_BookServ_Py()
augroup END

"
" OpenEnd dev                                                   {{{2

function! FT_OpenEnd_Py()
  let g:pyTestRunner = 'bin/test'
  let g:pyTestRunnerTestFiltering = "-k"
  let g:pyTestRunnerClipboardExtras = ""
  let g:pyTestRunnerDirectoryFiltering = " "
  let g:pyTestRunnerPackageFiltering = ""
  let g:pyTestRunnerModuleFiltering = ""
  setlocal path^=cpanel/templates,cpanel/public
  setlocal includeexpr=substitute(v:fname,'^/','','')
endf
function! FT_OpenEnd_CPanel_Py()
  let g:pyTestRunner = 'bin/test-nojs'
endf

augroup OpenEnd
  autocmd!
  autocmd BufRead,BufNewFile ~/src/openend/*.py call FT_OpenEnd_Py()
  autocmd BufRead,BufNewFile ~/src/openend/cpanel/*.py  call FT_OpenEnd_CPanel_Py()
augroup END


endif " has("autocmd")

"
" Colors                                                        {{{1
"

if $COLORTERM == "gnome-terminal"
  set t_Co=256                  " gnome-terminal supports 256 colors
  " note: doesn't work inside screen, which translates 256 colors into the
  " basic 16.
  " a better fix would be something like http://gist.github.com/636883
  " added to .bashrc
endif

if has("gui_running")
  gui                           " see :help 'background' why I need this before
  set t_vb=                     " this must be set after :gui
endif

" I want gvims to look the same as vims in my gnome-terminal (which uses Tango
" colours).  Unfortunately I need to keep switching these manually whenever I
" change the Gtk+ theme (between ones with white background and ones with dark
" background).
if !exists('colors_name')
  "colorscheme desert
  "colorscheme darklooks
endif

if has("syntax")
  syntax enable
endif

" My colour overrides

highlight NonText               ctermfg=gray guifg=gray term=standout
highlight SpecialKey            ctermfg=gray guifg=gray term=standout
highlight MatchParen            gui=bold guibg=NONE guifg=lightblue cterm=bold ctermbg=NONE
highlight SpellBad              cterm=underline ctermfg=red ctermbg=NONE
highlight SpellCap              cterm=underline ctermfg=blue ctermbg=NONE

if $TERM == "Eterm"
  highlight StatusLine          ctermfg=white ctermbg=black cterm=bold
  highlight StatusLineNC        ctermfg=white ctermbg=black cterm=NONE
  highlight VertSplit           ctermfg=white ctermbg=black cterm=NONE
endif

" Get rid of italics (they look ugly)
highlight htmlItalic            gui=NONE guifg=orange
highlight htmlUnderlineItalic   gui=underline guifg=orange

" Make error messages more readable
highlight ErrorMsg              guifg=red guibg=white

" Python doctests -- I got used to one color, then upgraded the Python
" syntax script and it changed it
highlight link Test Special

" 'statusline' contains %1* and %2*
highlight User1                 gui=NONE guifg=green guibg=black
highlight User2                 gui=NONE guifg=magenta guibg=black

" for custom :match commands
highlight Red                   guibg=red ctermbg=red
highlight Green                 guibg=green ctermbg=green

highlight Search                guifg=white guibg=black gui=NONE
highlight IncSearch             guifg=white guibg=darkseagreen gui=underline
highlight IncSearch             ctermfg=white ctermbg=red cterm=underline
highlight IncSearch             term=underline

"
" Toolbar buttons                                               {{{1
"

if !exists("did_install_mg_menus") && has("gui")
  let did_install_mg_menus = 1
  amenu 1.200   ToolBar.-Sep700-        :
  amenu 1.201   ToolBar.TrimSpaces      :%s/\s\+$//<CR>
  tmenu         ToolBar.TrimSpaces      Remove trailing whitespace
  amenu 1.202   ToolBar.ToggleHdr       <C-F6>
  tmenu         ToolBar.ToggleHdr       Switch between source and header (C/C++), or code and test (Python)
endif


" TagBar configuration
let g:tagbar_iconchars = ['▾', '▸']

" Flake8 Configuration
let g:flake8_max_line_length=110
let g:flake8_max_complexity=10
autocmd BufWritePost *.py call Flake8()
