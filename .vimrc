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

call plug#begin('~/.vim/plugged')

" color schemes
" Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
" Plug 'ayu-theme/ayu-vim'
" Plug 'chriskempson/base16-vim'
" Plug 'nanotech/jellybeans.vim'

Plug 'machakann/vim-highlightedyank' "Temporary highlighting of yanked text

" Status line
Plug 'vim-airline/vim-airline' "Fancy Status Line
Plug 'vim-airline/vim-airline-themes' "Fancy Status Line
Plug 'google/vim-searchindex'

" gutter
Plug 'airblade/vim-gitgutter'
" Plug 'mhinz/vim-signify'
" Plug 'w0rp/ale' "Linting
" Plug 'scrooloose/syntastic'

" Coding helps
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rickhowe/diffchar.vim' "Word/character level diffing
"Plug 'tpope/vim-sleuth' " detect indent style (tabs vs. spaces)

" utilities
" Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
" Plug 'scrooloose/nerdtree', "{ 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
"Plug 'neomake/neomake'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs' "Auto-closing of parenthis, curlies, quoutes, etc.
" Plug 'kkoomen/vim-doge'
" Plug 'easymotion/vim-easymotion'
" Plug 'justinmk/vim-sneak'

" javascript
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }
" Plug 'heavenshell/vim-jsdoc', {'for': 'javascript' }
" Plug 'jonsmithers/vim-html-template-literals', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
"Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'jxnblk/vim-mdx-js'
Plug 'elzr/vim-json', { 'for': 'json' }
"Plug 'kchmck/vim-coffee-script'
"Plug 'nikvdp/ejs-syntax'
Plug 'alvan/vim-closetag'

" typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" css and preprocessors
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'chrisbra/Colorizer'
"Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
"Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
"Plug 'groenewege/vim-less', { 'for': 'less' }
"Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }

" Snipz
Plug 'SirVer/ultisnips'

" On-demand loading
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Open a file in github
Plug 'k0kubun/vim-open-github'

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Add plugins to &runtimepath
call plug#end()


" vim-repeat on these plugins:
" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" ---------------------------------------------------------------------------------
" #Look
" ---------------------------------------------------------------------------------
" Color Scheme
set number
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set t_ZH=[3m
set t_ZR=[23m
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
colorscheme gruvbox
set background=dark

" Help me see what highlight group is under the cursor
command! WhatIsThis echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"

set signcolumn=yes
hi clear SignColumn
hi GruvboxRedSign guibg=NONE ctermbg=NONE
hi GruvboxGreenSign guibg=NONE ctermbg=NONE
hi GruvboxYellowSign guibg=NONE ctermbg=NONE
hi GruvboxBlueSign guibg=NONE ctermbg=NONE
hi GruvboxPurpleSign guibg=NONE ctermbg=NONE
hi GruvboxAquaSign guibg=NONE ctermbg=NONE

hi clear DiffDelete
hi DiffDelete guibg=NONE guifg=#963e3e
hi clear DiffAdd
hi DiffAdd guibg=#314021 guifg=NONE
hi clear DiffChange
hi DiffChange guibg=#2d3b42 guifg=NONE
hi clear Search
hi Search guibg=#374f5a
hi clear DiffText
hi DiffText guibg=#302020
hi HighlightedyankRegion guibg=#4e90af guifg=white

hi htmlArg guifg=#fabd2f gui=italic
hi jsxAttrib guifg=#fabd2f gui=italic

"for some reason in typescript files, javascriptLineComment isn't being linked to comment
hi link javascriptLineComment comment

map <leader>. :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"Formatting
set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set shiftwidth=2                " use indents of 2 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=2                   " an indentation every four columns
set softtabstop=2               " let backspace delete indent
" set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" set matchpairs+=<:>             " match, to be used with %
" set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
set backspace=indent,eol,start
" set lazyredraw                  " redraw only when we need to

" Remove trailing whitespaces and ^M chars
" autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Misc
set laststatus=2
set title                       " change the title of the terminal tab
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to

" Highlight problematic whitespace
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.

" vim-json hides quotes, but the indent-shift is annoying. This turns that off
let g:vim_json_syntax_concealcursor = 'nc'

" netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_fastbrowse = 0 "Allows netrw buffers to close. See https://github.com/tpope/vim-vinegar/issues/13

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=a

"Airline settings
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '•', '-']
let g:airline_section_x = airline#section#create_right(['filetype'])
" let g:airline#extensions#obsession#enabled = 1
" let g:airline#extensions#obsession#indicator_text = '★'
let g:airline#extension#coc#enabled = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline_section_x='filetype'

"Syntastic Options
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" "syntax highlighting consistency:
" " Set filetype=typescript.tsx (required by coc-tsserver)
" " Set syntax as typescriptreact (for default vim ts syntax)
" " Set the same for js, jsx, ts, tsx so highlighting is consistent
" autocmd BufNewFile,BufRead *.tsx,*.ts
"       \ set filetype=typescript.tsx |
"       \ set syntax=typescriptreact

"Gitgutter Options
 let g:gitgutter_override_sign_column_highlight = 0
 let g:gitgutter_sign_added              = '┃'
 let g:gitgutter_sign_modified           = '│'
 let g:gitgutter_sign_modified_removed   = '│'
 let g:gitgutter_sign_removed            = '×͢'

"CloseTag options
" Enable auto close tags with <tag|>
" Skip with <leader>>
let g:closetag_filetypes = 'html,typescript.tsx'
let g:closetag_close_shortcut = '<leader>>'

" Colorizer Options
let g:colorizer_auto_filetype='css,html,typescript.tsx'
" let g:colorizer_use_virtual_text = 1
let g:colorizer_disable_bufleave = 1

" AutoPairs options
let g:AutoPairsMapSpace=0
let g:AutoPairsMultilineClose=0

" Sneak options
" map f <Plug>Sneak_s
" map F <Plug>Sneak_S

" ---------------------------------------------------------------------------------
" #Control
" ---------------------------------------------------------------------------------
set hidden "Hide buffers instead  of closing them
set confirm "Confirm instead of failing when stuff's unsaved
set mouse=a "Use the Mouse
if !has("nvim")
    "set clipboard=exclude:.* "Kill unnamed yank mapping to clipboard
    " set ttymouse=xterm2 "Needed to drag splits in tmux
endif
let mapleader=' ' "Use the space as the leader key
set ttyfast "Fast scrolling with mouse (removed in nvim)

"Editor...
set updatetime=100
set virtualedit=onemore "Allow for cursor beyond last character
set splitbelow
set splitright
set diffopt+=vertical
" set winheight=10
" set winminheight=3
" set scrolljump=5                " lines to scroll when cursor leaves screen
" set scrolloff=3                 " minimum lines to keep above and below cursor
set wildmenu
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
let g:highlightedyank_highlight_duration=300

"Search
set incsearch                   " Show search results as you type
set hlsearch                    " Hilight search results
set showmatch                   " Show search results as I type
set ignorecase
set smartcase
" set wildignorecase

"Cycling errors
" command! Lnext try | lnext | catch | lfirst | catch | endtry
" command! Lprev try | lprev | catch | llast | catch | endtry
" cabbrev ln Lnext
" cabbrev lp Lprev

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
set viewoptions=folds,cursor
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
" if has("nvim")
"     tmap <Space>hj <C-\><C-n><C-W>hj
"     tmap <Space>hk <C-\><C-n><C-W>hk
"     tmap <Space>kj <C-\><C-n><C-W>kj
"     tmap <Space>kk <C-\><C-n><C-W>kk
"     tmap jj <C-\><C-n>
"     tmap kk <C-\><C-n>
"     tmap hh <C-\><C-n>
" endif

"Easier moving/resizing in windows
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>l <C-W>l
map <leader>h <C-W>h

map <silent> <C-h> <C-W>8<
map <silent> <C-l> <C-W>8>
map <silent> <C-j> :res +3<cr>
map <silent> <C-k> :res -3<cr>

nnoremap <leader>u :tabprevious<CR>
nnoremap <leader>i :tabnext<CR>
nnoremap <silent> <C-t> :tabnew .<CR>

"The following two lines conflict with moving to top and bottom of the screen
"If you prefer that functionality, comment them out.
map <S-H> gT
map <S-L> gt
map <silent><S-T>T :tabnew<cr>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

"Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"clearing highlighted search
nmap <silent><leader>/ :noh<CR>

"buffer navigation
nmap <silent><leader>b :Buffers<CR>
nmap <silent><leader>vb :vs<cr>:Buffers<CR>
nmap <silent><leader>s :Rg<CR>
nmap <silent><leader>vs :vs<cr>:Rg<CR>
nmap <silent><leader>o :Files<CR>
nmap <silent><leader>vo :vs<cr>:Files<CR>
nmap <silent><leader>g :GFiles?<CR>

" moving lines of code around

" Normal mode
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Error navigation
nmap <silent><leader>e <Plug>(coc-diagnostic-prev)
nmap <silent><leader><S-E> <Plug>(coc-diagnostic-prev)

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Keep splits when I close files
nmap <leader>w :call KeepSplitClose(0)<cr>

function! KeepSplitClose(saveFirst)
  if (a:saveFirst == 1)
      w!
  endif
  let bufferToDelete = bufnr("%")
  let newBuffer = bufnr("#")
  if ((newBuffer != -1) && (newBuffer != bufferToDelete) && buflisted(newBuffer))
      exe "b".newBuffer
  else
      bnext
  endif

  if (bufnr("%") == bufferToDelete)
      new
  endif
  exe "bd".bufferToDelete
endfunction

"//TODO Learn this to memory
" Some helpers to edit mode
" http://vimcasts.org/e/14
" cnoremap %% <C-R>=expand('%:h').'/'<cr>
" map <leader>ew :e %%<cr>
" map <leader>es :sp %%<cr>
" map <leader>ev :vsp %%<cr>
" map <leader>et :tabe %%<cr>

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
" vim-styled-components has issues if it doesn't read the file from the
" beginning all the time.
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

"Syntastic Options
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 2
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exe = 'npm run lint --'
"let g:syntastic_error_symbol = "\u2717"
"let g:syntastic_warning_symbol = "\u2717"

"Ale Options
" let g:ale_sign_error = '=>'
" let g:ale_sign_warning = '->'

" let g:ale_fixers = {
" \ 'css' : ['prettier'],
" \ 'javascript': ['trim_whitespace', 'eslint' ],
" \ 'json': ['trim_whitespace', 'prettier'],
" \ 'html': ['prettier'],
" \ 'markdown': ['prettier'],
" \ 'vim' : ['trim_whitespace'],
" \ 'yaml': ['prettier']
" \ }
"
" let g:ale_linters = {'javascript': ['eslint']}

"Neomake options
"autocmd! BufWritePost,BufEnter * Neomake
"let g:neomake_open_list = 0
"let g:neomake_warning_sign = {
"  \ 'text': '✗',
"  \ 'texthl': 'SyntasticWarningSign',
"  \ }
"let g:neomake_error_sign = {
"  \ 'text': '✗',
"  \ 'texthl': 'Error',
"  \ }
"let g:neomake_javascript_enabled_makers = ['eslint']

"JSX Options
"let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"JsDoc options
"let g:jsdoc_allow_input_prompt=1
"let g:jsdoc_input_description=1
"let g:jsdoc_enable_es6=1
"let g:javascript_plugin_jsdoc = 1

"ultisnips options
let g:UltiSnipsExpandTrigger="<c-cr>" "This needs to not be tab, so as not to conflict with coc
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"completion options

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


"deoplete options
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#auto_complete_delay = 0
"let g:deoplete#sources#ternjs#docs = 1
"let g:deoplete#file#enable_buffer_path=1
"let g:echodoc_enable_at_startup=2
"let g:echodoc#type="virtual"

" Hide preview window after typing
autocmd CompleteDone * pclose

"javascript-libraries-syntax
"let g:used_javascript_libs = 'react,chai,underscore'

" Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

nnoremap <Leader>p :CocCommand prettier.formatFile<CR>
nnoremap <Leader>af :CocCommand eslint.executeAutoFix<CR>

" Prettier no-workie for mdx. Thanks to @joeycozza for this power-up
nnoremap <Leader><Leader>p :silent %!prettier --stdin --stdin-filepath % --trailing-comma es5 --no-semi --single-quote --print-width 100<CR>

" ---------------------------------------------------------------------------------
" #iTerm
" ---------------------------------------------------------------------------------
" Change cursor shape between insert and normal mode in iTerm2.app
" if $TERM_PROGRAM =~ "iTerm"
"     if exists('$TMUX')
"         let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"         let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
"         let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"         let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"         autocmd VimEnter * : silent exec "!printf '\033Ptmux;\033\033]50;CursorShape=0\007\033\\'"
"         autocmd VimLeave * : silent exec "!printf '\033Ptmux;\033\033]50;CursorShape=1\007\033\\'"
"     else
"         let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"         let &t_SR = "\<Esc>]51;CursorShape=2\x7"
"         let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"         autocmd VimEnter * : silent exec "!printf '\033]50;CursorShape=0\x7'"
"         autocmd VimLeave * : silent exec "!printf '\033]50;CursorShape=1\x7'"
"     endif
" endif

" ---------------------------------------------------------------------------------
" #Finish
" ---------------------------------------------------------------------------------
" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" FZF Layout
let g:fzf_layout = { 'window': { 'width': 0.70, 'height': 0.8} }
let $FZF_DEFAULT_OPTS="--reverse " " top to bottom

" nnoremap <silent> <Leader>f :execute 'Files ' . <SID>fzf_root()<CR>
function! s:fzf_root()
  let l:path = finddir('.git', expand('%:p:h').';')
  return fnamemodify(substitute(l:path, '.git', '', ''), ':p:h')
endfunction


command! -bang -nargs=* Grep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
