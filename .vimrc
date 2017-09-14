"---------------------------------------------------------------------------------
"TABLE OF CONTENTS
"
"   #Bootstrap ......................... Startup
"   #Look .............................. Look & Feel
"   #Control ........................... Mouse, windowing, search, etc
"   #State ............................. Undo, swap, views
"   #Mappings .......................... Keyboard an other mappings
"   #Syntax ............................ Syntax highlighting and checking options
"   #Finish ............................ Final steps (.vimrc.local, etc)
"
"---------------------------------------------------------------------------------


" ---------------------------------------------------------------------------------
" #Bootstrap
" ---------------------------------------------------------------------------------
set nocompatible
set encoding=utf-8

" load plugins from vundle
source ~/.vim/plugins.vim


" ---------------------------------------------------------------------------------
" #Look
" ---------------------------------------------------------------------------------
" Color Scheme
set number
let g:solarized_termcolors=256
set background=dark
color solarized
hi clear SignColumn
hi SyntasticWarningSign ctermfg=214 guifg=#ffaf00 "Yellow warnings

"Formatting
set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set shiftwidth=2                " use indents of 2 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=2                   " an indentation every four columns
set softtabstop=2               " let backspace delete indent
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set matchpairs+=<:>             " match, to be used with %
set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
set backspace=indent,eol,start
set lazyredraw                  " redraw only when we need to

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Misc
set laststatus=2
set title                       " I don't really know that this is doing anything
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to

" Highlight problematic whitespace
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.

"Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '•', '-']
let g:airline_section_x = airline#section#create_right(['filetype'])
let g:airline_theme='powerlineish'

"Syntastic Options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"Signify Options
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_add               = '+'
let g:signify_sign_change            = '•'
let g:signify_sign_delete            = '-'

" ---------------------------------------------------------------------------------
" #Control
" ---------------------------------------------------------------------------------
set mouse=a "Use the Mouse
if !has("nvim")
    "set clipboard=exclude:.* "Kill unnamed yank mapping to clipboard
    set ttymouse=xterm2 "Needed to drag splits in tmux
endif
let mapleader=' ' "Use the space as the leader key
set ttyfast

"Editor...
set virtualedit=onemore "Allow for cursor beyond last character
set splitbelow
set splitright
set diffopt+=vertical
set winheight=10
set winminheight=3
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set wildmenu
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.

"Search
set incsearch                   " Show search results as you type
set hlsearch                    " Hilight search results
set showmatch                   " Show search results as I type
set ignorecase
set smartcase
set wildignorecase

"Cycling errors
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry
cabbrev ln Lnext
cabbrev lp Lprev

" ---------------------------------------------------------------------------------
" #State
" ---------------------------------------------------------------------------------
"Persistent undos
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo
    set undoreload=10000
endif
set history=1000

" Backups
set backup
set backupdir=~/.vim/backup

" Persistent views
set viewdir=~/.vim/views
au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)

" Session directory
set directory=~/.vim/swap

" ---------------------------------------------------------------------------------
" #Mappings
" ---------------------------------------------------------------------------------
"Easier escapes to keep us on home-row
imap jj <esc>
imap kk <esc>
imap hh <esc>

"Terminal mode version (nvim)
if has("nvim")
    tmap <Space>hj <C-\><C-n><C-W>hj
    tmap <Space>hk <C-\><C-n><C-W>hk
    tmap <Space>kj <C-\><C-n><C-W>kj
    tmap <Space>kk <C-\><C-n><C-W>kk
    tmap jj <C-\><C-n>
    tmap kk <C-\><C-n>
    tmap hh <C-\><C-n>
endif

"Easier moving/resizing in windows
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>l <C-W>l
map <leader>h <C-W>h

map <silent> <C-j> :res +3<cr>
map <silent> <C-k> :res -3<cr>
map <silent> <C-l> <C-W>8>
map <silent> <C-h> <C-W>8<

"Tab Navigation
"inoremap <C-m> <Esc>:tabnext<CR>
"inoremap <C-n> <Esc>:tabprevious<CR>
"inoremap <C-t> <Esc>:tabnew .<CR>

nnoremap <C-m> :tabnext<CR>
nnoremap <C-n> :tabprevious<CR>
nnoremap <C-t> :tabnew .<CR>
"map <silent><leader>K :tabnext<cr>
"map <silent><leader>J :tabprevious<cr>
"map <silent><leader>T :tabnew .<cr>
"The following two lines conflict with moving to top and bottom of the screen
"If you prefer that functionality, comment them out.
map <S-H> gT
map <S-L> gt
map <silent><S-T>T :tabnew<cr>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Break line under cursor (opposite of 'J' key to join lines)
map K i<CR><Esc>

"Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"clearing highlighted search
nmap <leader>/ :silent noh<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Error navigation
nmap <silent><leader>e :Lnext<cr>

"//TODO Learn this to memory
" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Easier horizontal scrolling
map zl zL
map zh zH

" Fix the placement of the cursor on escape
inoremap <silent> <Esc> <C-O>:stopinsert<CR>
" ---------------------------------------------------------------------------------
" #Syntax
" ---------------------------------------------------------------------------------
"Syntastic Options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exe = 'npm run lint --'
let g:syntastic_error_symbol = "\u2717"
let g:syntastic_warning_symbol = "\u2717"

"Neomake options
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_open_list = 0
let g:neomake_warning_sign = {
  \ 'text': '✗',
  \ 'texthl': 'SyntasticWarningSign',
  \ }
let g:neomake_error_sign = {
  \ 'text': '✗',
  \ 'texthl': 'Error',
  \ }
let g:neomake_javascript_enabled_makers = ['eslint']

"JSX Options
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" ---------------------------------------------------------------------------------
" #iTerm
" ---------------------------------------------------------------------------------
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        autocmd VimEnter * : silent exec "!printf '\033Ptmux;\033\033]50;CursorShape=0\007\033\\'"
        autocmd VimLeave * : silent exec "!printf '\033Ptmux;\033\033]50;CursorShape=1\007\033\\'"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_SR = "\<Esc>]50;CursorShape=2\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
        autocmd VimEnter * : silent exec "!printf '\033]50;CursorShape=0\x7'"
        autocmd VimLeave * : silent exec "!printf '\033]50;CursorShape=1\x7'"
    endif
endif

" ---------------------------------------------------------------------------------
" #Finish
" ---------------------------------------------------------------------------------
" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
