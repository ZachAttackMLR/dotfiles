" Zach's nvim config

" Will be set to either Darwin (macOS) or Linux based on what machine I'm on
let uname = substitute(system('uname'), '\n', '', '')

" Plugins (using Vim-Plug) {{{

call plug#begin('~/.local/share/nvim/plugged')

" Some syntax highlighting, linting, and autocompletion stuff
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'davidhalter/jedi-vim'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'kovetskiy/sxhkd-vim'
Plug 'sohkai/syntastic-local-solhint'
"Plug 'kosayoda/nvim-lightbulb' " TODO fix this (probably with some lspconfig
"or lsp
if uname == "Darwin"
  Plug 'rizzatti/dash.vim'
endif

" git stuff
Plug 'APZelos/blamer.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" Appearance stuff
Plug 'ntpeters/vim-better-whitespace' " highlight trailing whitespace
Plug 'ryanoasis/vim-devicons' " Icons for NERDTree
Plug 'mhinz/vim-startify' " 'The fancy start screen for Vim'
Plug 'Yggdroot/indentLine'
" Plug 'lukas-reineke/indent-blankline.nvim' "TODO get this to work

" Nvim in Firefox!
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" File explorer
Plug 'scrooloose/nerdtree'

" Themes
Plug 'sainnhe/gruvbox-material'
"Plug 'nightsense/snow'
"Plug 'chriskempson/base16-vim'
"Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.7' }
"Plug 'nerdypepper/vim-colors-plain', { 'branch': 'duotone' }
"Plug 'DankNeon/vim' "TODO: Try this out

" tmux things
Plug 'christoomey/vim-tmux-navigator'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Persistent Scratch Buffers
Plug 'mtth/scratch.vim'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Delimiter - auto-closes parens, quotes, brackets, etc.
Plug 'Raimondi/delimitMate'

" MarkDown stuff
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ferrine/md-img-paste.vim'
"
" Surrounding text
Plug 'tpope/vim-surround'

" Time tracking stuff
Plug 'https://gitlab.com/code-stats/code-stats-vim.git'
Plug 'wakatime/vim-wakatime'

" fzf
if uname == "Darwin"
  Plug '/usr/local/opt/fzf'
elseif uname == "Linux"
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'junegunn/fzf.vim'

" Spellcheck stuff
Plug 'reedes/vim-litecorrect'

call plug#end()

" END Plugins }}}

" General Settings {{{
" A bunch of this I stole from https://github.com/alichtman/dotfiles/blob/master/.vimrc

set secure
set spelllang=en
set mouse=nv                   " Use mouse for pane selection, resizing, and cursor movement.
set nostartofline              " Don’t reset cursor to start of line when moving around.
set title                      " Show the filename in the window titlebar
set autoread                   " Autoread changed files
set noshowmode                 " Don't show mode under statusline w/ mode
set scrolloff=6                " Minimal num of lines to keep above/below cursor
set number                     " Enable line numbers
set updatetime=300             " Smaller updatetime for CursorHold & CursorHoldI. Also helps CoC response time
set cursorline                 " Highlight current line
set hidden                     " Enable buffers to exist in the background
set nobackup                   " Don't keep a backup file. writebackup is enough for my purposes.
set splitbelow                 " Open new horizontal splits to the bottom
set splitright                 " And vertical splits to the right
set signcolumn=yes             " Always show signcolumns
set switchbuf=usetab           " Search first in opened windows if opening buffer
set shortmess+=c               " Don't give ins-completion-menu messages
set backspace=indent,eol,start " Make delete in insert mode behave as expected.
syntax on                      " turn on syntax highlighting within vim
set encoding=UTF-8

" Enable copying to macOS/Arch clipboard
if uname == "Darwin"
  set clipboard=unnamed
elseif uname == "Linux"
  set clipboard=unnamedplus
endif

" Tab completion menu stuff
set wildmenu
set wildmode=full
set wildignore+=.svn,CVS,.git,*.pyc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam,*/tmp/*,*.zip,log/**,node_modules/**,target/**,tmp/**,*.rbc

" Undo stuff
set undolevels=1000
set undofile

set tags=tags

" Don't treat hyphens and underscores like whitespace
set iskeyword+=-
set iskeyword+=_

" Search stuff
set showmatch          " Show matching brackets/parenthesis
set matchtime=0        " Don't blink when matching
set incsearch          " Find as you type search
set hlsearch           " Highlight search terms
set ignorecase         " Case insensitive search
set inccommand=nosplit " Show regex replacement changes as you're typing
set smartcase          " Case sensitive if we type an uppercase

" Line breaking
set wrap
set nolinebreak
set breakindent
set breakindentopt=min:40

" 99 character guideline (sorry stallman)
highlight ColorColumn ctermbg=lightgrey
set colorcolumn=99

" Show “invisible” characters
set list
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

"  Indentation Config {{{

set copyindent
set preserveindent
filetype plugin indent on

set expandtab     " enter spaces when tab is pressed
set tabstop=2     " use 2 spaces to represent tab
set softtabstop=2
set shiftwidth=2  " number of spaces to use for auto indent
set autoindent    " copy indent from current line when starting a new lineet noexpandtab

" END Indentation Config }}}

" mappings {{{

" Map Esc twice to write file
nnoremap <Esc><Esc> :w<CR>

" Map leader pdf to write and then make a pdf from the .tex file we're editing
nnoremap <leader>pdf :w <bar> !pdflatex -output-directory out % && mv -f out/%:r.pdf . && zathura %:r.pdf <cr>

" Map leader er to replace a space with a line break the join the lines
" Helps when I'm over 80 lines in LaTeX and want a break, but also a join
nnoremap <leader>er s<cr><Esc>J

" Make Y behave like C and D
nnoremap Y y$

" remap <c-a> and <c-x> (incrementing and decrementing numbers) to same thing
" but with alt
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" Move the current line above or below
" These mappings also take a count, so 2]e moves the current line 2 lines below.
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" END mappings }}}

" END General Settings }}}

" Appearance Config {{{

" Colorscheme Configs {{{

set background=dark

" Purposely not using this for gruvbox-material.
" Activate for other colorschemes (especially plain).
"set termguicolors

colorscheme gruvbox-material
let g:gruvbox_contrast_dark='dark'

" jellybeans.vim config {{{

"let g:jellybeans_overrides = {
"\    'Folded': { 'guifg': '5e6670', 'guibg': '1d2126',
"\              'ctermfg': '5e6670', 'ctermbg': '1d2126',
"\              'attr': 'italic' },
"\}
"colorscheme jellybeans
"let g:jellybeans_use_term_italics = 1
"let g:jellybeans_use_lowcolor_black = 1

" END jellybeans.vim config }}}

"colorscheme snow
"colorscheme plain
"colorscheme dank-neon

"let base16colorspace=256  " Access colors present in 256 colorspace
"colorscheme base16-black-metal

" END Colorscheme Configs }}}

" Vim Dev Icons {{{

let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
if uname == "Darwin"
  let g:WebDevIconsOS = 'Darwin'
endif
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:webdevicons_conceal_nerdtree_brackets = 0

" END Vim Dev Icons }}}

" Better Whitespace Config {{{

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:better_whitespace_skip_empty_lines=1
let g:show_spaces_that_precede_tabs=1

" END Better Whitespace Config }}}

" indentLine config {{{

let g:indentLine_concealcursor = ''
" Default is 2, and it doesn't work with 0, so 1 is a nice compromise.
let g:indentLine_conceallevel = 1
let g:indentLine_fileTypeExclude = ['md', 'tex']
let g:indentLine_bufNameExclude = ['*.tex', '*.md']

" END indentLine config }}}

" END Appearance Config }}}

" Airline Config {{{

" I change my mind about this more often than I care to admit...
" let g:airline_theme='base16_eighties'
" let g:airline_theme='violet'
" let g:airline_theme='base16_gruvbox_dark'
" let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_theme='base16_snazzy'
let g:airline_powerline_fonts = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" END Airline Config }}}

" vim-terraform Config {{{

let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" END vim-terraform Config }}}

" ALE Config {{{

" Enabling both loclist and quickfix, and enabling opening the list in a vnew
let g:ale_set_loclist=1
let g:ale_set_quickfix=1
let g:ale_open_list=1

" Added option for line length when black fixes things per work standard
let g:ale_python_black_options='--line-length 99'

" Run :ALEFix when file is saved
let g:ale_fix_on_save=1

" ALELinters for each language
" TODO: Get mypy working for python linting and/or config flake8
"     : Get eslint working for js linting
let g:ale_linters = {
\     'c': ['clangtidy', 'gcc'],
\     'cpp': ['clangtidy', 'ccls', 'cppcheck', 'cpplint'],
\     'css': ['prettier'],
\     'html': ['prettier'],
\     'java': ['checkstyle', 'javac'],
\     'javascript': ['prettier', 'eslint'],
\     'javascriptreact': ['eslint'],
\     'json': ['prettier'],
\     'markdown': ['prettier'],
\     'powershell': ['psscriptanalyzer'],
\     'python': ['pycodestyle', 'prettier'],
\     'terraform': ['fmt', 'tflint'],
\     'yaml': ['prettier']
\}

" :ALEFix-ers for each language
let g:ale_fixers = {
\     '*': ['remove_trailing_lines', 'trim_whitespace'],
\     'java': ['google_java_format'],
\     'c': ['clang-format'],
\     'cpp': ['clang-format'],
\     'powershell': ['psscriptanalyzer'],
\     'python': ['add_blank_lines_for_python_control_statements', 'autoimport', 'black', 'isort'],
\     'terraform': ['terraform']
\}

" End ALE Config }}}

" UltiSnips config {{{

" NOTE: While I tried not setting these, if you don't the defaults get mapped
" since plugins are loaded after the vimrc :(

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" END UltiSnips config }}}

" coc.nvim config {{{
" Heavily based on: https://github.com/neoclide/coc.nvim#example-vim-configuration
" and https://github.com/alichtman/dotfiles/blob/master/.vimrc

" All the CoC plugins that I use and want installed everywhere all the time :)
" TODO fix coc-eslint plugin
let g:coc_global_extensions=[
      \ 'coc-ultisnips', 'coc-json', 'coc-cfn-lint', 'coc-clangd', 'coc-css',
      \ 'coc-highlight', 'coc-html', 'coc-java', 'coc-python', 'coc-markdownlint',
      \ 'coc-powershell', 'coc-texlab', 'coc-tsserver', 'coc-vimlsp', 'coc-rust-analyzer',
      \ 'coc-yaml', 'coc-prettier', 'coc-syntax', 'coc-docker' ]

" https://github.com/neoclide/coc.nvim/issues/856
if uname == "Darwin"
  let g:coc_node_path = "/usr/local/bin/node"
elseif uname == "Linux"
  let g:coc_node_path = "/usr/bin/node"
endif

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use H to show documentation in preview window
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Mapping for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Mapping for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Mapping for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Mapping for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

"Use `:Prettier` to format current buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" END coc.nvim Config }}}}}}

" jedi-vim {{{

" Fix lagginess with large python libraries
" https://github.com/davidhalter/jedi-vim/issues/217
let g:jedi#popup_on_dot = 0

let g:jedi#documentation_command = "H"

" END jedi-vim }}}

" blamer.nvim {{{

let g:blamer_enabled = 1
let g:blamer_delay = 2500
let g:blamer_show_in_visual_modes = 0
let g:blamer_prefix = '  '
let g:blamer_date_format = '%I:%M%p %m/%d/%y'

" END scratch.vim }}}

" scratch.vim {{{

let g:scratch_persistence_file="~/.local/share/scratch_persistence_file.md"

" END scratch.vim }}}

" CodeStats config {{{

" all from https://gitlab.com/code-stats/code-stats-vim

let g:codestats_api_key =$CODESTATS_API_KEY

let g:airline_section_x = airline#section#create_right(['tagbar', 'filetype', '%{CodeStatsXp()}'])

" END CodeStats Config }}}

" vim-startify config {{{

let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   MRU']            },
            \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]

let g:startify_bookmarks = [
            \ {'a': '~/.vimrc'},
            \ {'b': '~/.zshrc'},
            \ {'c': '~/docs/notes/'} ]

let g:startify_custom_header = [
        \ '                                      ___...-----------...___',
        \ '                                  ,-``                       `-.',
        \ '                               ,`                            ,-`.',
        \ '                            ,-`                               `-``.',
        \ '                           ;                                   .-. \',
        \ '                          ;                             .-.    `-`  \',
        \ '                         ;                              `-`          \',
        \ '                        ;                                            ;',
        \ '                      ;                        ,-;-`,`.`.__          |',
        \ '                  _..;                      ,-` ;`,`.`,`.--`.        |',
        \ '                 ///;           ,-`   `. ,-`   ;` ;`,`,`_.--=:      /',
        \ '                |``:          ,`        :     ;` ;,;,,-`_.-._`.   ,`',
        \ '                |  :         ;_.-.      `.    :` ;;;`.ee.    \|  /',
        \ '                 \.`    _..-`/8o. `.     :    :! ` `:8888)   || /',
        \ '                  ||`-``    \\88o\ :     :    :! :  :`""`    ;;/',
        \ '                  ||         \"88o\;     `.    \ `. `.      ;,`',
        \ '                  /)   ___    `."`/(--.._ `.    `.`.  `-..-` ;--.',
        \ '                  \(.="""""==.. `-`     `.|      `-`-..__.-` `. `.',
        \ '                   |          `"==.__      )                    )  ;',
        \ '                   |   ||           `"=== `                   .`  .`',
        \ '                   /\,,||||  | |           \                .`   .`',
        \ '                   | |||`|` |`|`           \|             .`   _.` \',
        \ '                   | |\` |  |           || ||           .`    .`    \',
        \ '                   ` | \ ` |`  .   ``-- `| ||         .`    .`       \',
        \ '                     `  |  ` |  .    ``-.._ |  ;    .`    .`          `.',
        \ '                  _.--,;`.       .  --  ...._,`   .`    .`              `.__',
        \ '                ,`  ,`;   `.     .   --..__..--`.`    .`                __/_\',
        \ '              ,`   ; ;     |    .   --..__.._.`     .`                ,`     `.',
        \ '             /    ; :     ;     .    -.. _.`     _.`                 /         `',
        \ '            /     :  `-._ |    .    _.--`     _.`                   |',
        \ '',
        \ '                                NeoVim > VSCode > JetBrains IDEs',
        \ ]

let g:startify_files_number = 8
let g:startify_update_oldfiles = 0
let g:startify_session_persistence = 1
let g:startify_session_autoload = 1

" END vim-startify config }}}

" NERDTree Config {{{

let NERDTreeShowHidden = 1
let NERDTreeStatusline = 0
let NERDTreeWinSize    = 26

" END NERDTree Config }}}
"
" md-img-paste.vim config {{{

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'img'

" END md-img-paste.vim config }}}

" Autogroups / Autocommands {{{

" Credit: https://github.com/alichtman/dotfiles/blob/master/.vimrc
augroup AutoCloseVim
  " Clear group
  autocmd!
  " Close if quickfix is the only window open
  " https://stackoverflow.com/a/7477056
  autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix" | q | endif
  " Close vim if only thing remaining is NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" Credit: https://github.com/alichtman/dotfiles/blob/master/.vimrc
augroup MakeFoldsPersistent
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END

augroup Folding
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType java syn region foldJavadoc start=,/\*\*, end=,\*/, transparent fold keepend
                    \ | syn region foldImports start=/\(^\s*\n^import\)\@<= .\+;/ end=+^\s*$+ transparent fold keepend
                    \ | setlocal foldmethod=syntax
  autocmd FileType python,c,sh setlocal foldmethod=indent
augroup END

" Credit: https://github.com/alichtman/dotfiles/blob/master/.vimrc
augroup RestoreCursorPositionWhenOpeningFile
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
                \ endif
augroup END

" Credit: https://github.com/alichtman/dotfiles/blob/master/.vimrc
" Automatically use absolute line numbers when we’re in insert mode
" and relative numbers when we’re in normal mode.
augroup LineNumbers
    autocmd!
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
augroup END

" Credit: https://github.com/alichtman/dotfiles/blob/master/.vimrc
" Stolen cuz super helpful with c & makefile
augroup Indentation
    autocmd!
    " configure expanding of tabs for various file types
    au BufRead,BufNewFile *.py set expandtab
    au BufRead,BufNewFile *.c set expandtab
    au BufRead,BufNewFile *.h set expandtab
    au BufRead,BufNewFile Makefile* set noexpandtab
augroup END

" Credit: https://github.com/alichtman/dotfiles/blob/master/.vimrc
augroup VimStartupSequence
    autocmd!
    " If opening vim without a file arg, open startify and NERDTree
    autocmd VimEnter *
                \   if !argc()
                \ |   Startify
                \ |   NERDTree
                \ |   wincmd w
                \ | endif
    " Automatically install missing plugins
"    autocmd VimEnter *
"                \   if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"                \ |   PlugInstall --sync | q
"                \ | endif
augroup END

" Credit: https://github.com/alichtman/dotfiles/blob/master/.vimrc
" After opening a file, set working dir to the same as that file so relative
" paths will work nicely. Pairs with the set of FZF mappings below to allow
" you to access files in the parent directories.
augroup SetWorkingDirForCurrentWindow
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
augroup END

" Credit: https://github.com/alichtman/dotfiles/blob/master/.vimrc
augroup SpellcheckAndWritingTools
    autocmd!
    autocmd FileType markdown setlocal spell | call litecorrect#init()
    autocmd FileType text setlocal spell | call litecorrect#init()
    hi SpellBad cterm=underline ctermfg=red
augroup END

"augroup LightbulbPlugin
"    autocmd!
"    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
"augroup END

"TODO get this to work
" indentLines plugin sucks when you're dealing with TeX, MarkDown, etc
"augroup FixIndentLines
"  autocmd!
"  autocmd FileType tex setlocal conceallevel=0
"  autocmd FileType markdown setlocal conceallevel=0
"  autocmd FileType md setlocal conceallevel=0
"augroup END

" END Autogroups / Autocommands }}}
