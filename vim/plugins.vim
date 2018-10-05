call plug#begin('~/.vim/plugged')

" Look/Feel
Plug 'altercation/vim-colors-solarized' "Color scheme
Plug 'ayu-theme/ayu-vim' "New color scheme
Plug 'vim-airline/vim-airline' "Fancy Status Line
Plug 'vim-airline/vim-airline-themes' "Fancy Status Line
"Plug 'chriskempson/base16-vim'
"Plug 'nanotech/jellybeans.vim'

" utilities
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
"Plug 'scrooloose/syntastic'
Plug 'neomake/neomake'
Plug 'mhinz/vim-signify'
"Plug 'tpope/vim-vinegar'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-sleuth' " detect indent style (tabs vs. spaces)
"Plug 'Raimondi/delimitMate' "Auto-closing of parenthesis and stuff
Plug 'Valloric/YouCompleteMe' "Code completion
Plug 'rickhowe/diffchar.vim' "Word/character level diffing

" javascript
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mtscout6/syntastic-local-eslint.vim', { 'for': 'javascript' }
"Plug 'moll/vim-node', { 'for': 'javascript' }
"Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim'
"Plug 'elzr/vim-json', { 'for': 'json' }
"Plug 'kchmck/vim-coffee-script'

" css and preprocessors
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'ap/vim-css-color', { 'for': 'css' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }

" Group dependencies, vim-snippets depends on ultisnips
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', "{ 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Add plugins to &runtimepath
call plug#end()
