call plug#begin('~/.vim/plugged')

" color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
"Plug 'chriskempson/base16-vim'
"Plug 'nanotech/jellybeans.vim'

" Status line
Plug 'vim-airline/vim-airline' "Fancy Status Line
Plug 'vim-airline/vim-airline-themes' "Fancy Status Line
Plug 'google/vim-searchindex'

" gutter
Plug 'airblade/vim-gitgutter'
"Plug 'mhinz/vim-signify'
Plug 'w0rp/ale' "Linting
"Plug 'scrooloose/syntastic'

" Coding helps
Plug 'machakann/vim-highlightedyank' "Temporary highlighting of yanked text

"Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
"Plug 'ternjs/tern_for_vim'
Plug 'rickhowe/diffchar.vim' "Word/character level diffing
"Plug 'tpope/vim-sleuth' " detect indent style (tabs vs. spaces)

" utilities
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', "{ 'on':  'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'
"Plug 'neomake/neomake'
"Plug 'tpope/vim-vinegar'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-repeat'
"Plug 'Raimondi/delimitMate' "Auto-closing of parenthesis and stuff

" javascript
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'mtscout6/syntastic-local-eslint.vim', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
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
