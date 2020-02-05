" What... What have I done?! - Zach Gorman

" START Plugins (using Vim-Plug) {{{

call plug#begin('~/.vim/plugged')

" Some syntax highlighting, linting, and autocompletion stuff
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale' " Setup on line X
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Setup on line 235

" Appearance stuff
Plug 'ntpeters/vim-better-whitespace' " highlight trailing whitespace
Plug 'ryanoasis/vim-devicons' " Icons for NERDTree
Plug 'mhinz/vim-startify' " 'The fancy start screen for Vim'

" File explorer
Plug 'scrooloose/nerdtree'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'

" Status bar shiz
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Delimiter - auto-closes parens, quotes, brackets, etc.
Plug 'Raimondi/delimitMate'

" MarkDown stuff
" Makes alignment pretty
" (http://vimcasts.org/episodes/aligning-text-with-tabular-vim/)
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Time tracking stuff
Plug 'https://gitlab.com/code-stats/code-stats-vim.git'
Plug 'wakatime/vim-wakatime'

" fzf - https://github.com/junegunn/fzf.vim
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Spellcheck stuff
Plug 'reedes/vim-litecorrect'

call plug#end()

" END Plugins }}}

" START General Settings {{{
" A bunch of this I stole from https://github.com/alichtman/dotfiles/blob/master/.vimrc

set secure
set spelllang=en
set mouse=nv                   " Use mouse for pane selection, resizing, and cursor movement.
set nostartofline              " Don’t reset cursor to start of line when moving around.
set title                      " Show the filename in the window titlebar
set autoread                   " Autoread changed files
set clipboard=unnamed          " Enable copying to macOS clipboard
set noshowmode                 " Don't show mode under statusline w/ mode
set scrolloff=6                " Minimal num of lines to keep above/below cursor
set number                     " Enable line numbers
" set cmdheight=1              " Better display for messages
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

" Tab completion menu stuff
set wildmenu
set wildmode=full
set wildignore+=.svn,CVS,.git,*.pyc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam,*/tmp/*,*.zip,log/**,node_modules/**,target/**,tmp/**,*.rbc

" Undo stuff
set undolevels=1000
set undofile

" Use gtf to jump to files with these extensions
" set suffixesadd=.md,.c,.h,.cpp,.py,.tex

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
" 80 and 120 character guidelines
highlight ColorColumn ctermbg=lightgrey
set colorcolumn=80,120

" Show “invisible” characters
set list
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

" START Indentation Config {{{

set copyindent
set preserveindent
filetype plugin indent on

set expandtab     " enter spaces when tab is pressed
set tabstop=2     " use 4 spaces to represent tab
set softtabstop=2
set shiftwidth=2  " number of spaces to use for auto indent
set autoindent    " copy indent from current line when starting a new lineet noexpandtab

" END Indentation Config }}}

" START mappings {{{

" Map Esc twice to write file
nnoremap <Esc><Esc> :w<CR>

" Move the current line above or below
" These mappings also take a count, so 2]e moves the current line 2 lines below.
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" source: http://amix.dk/vim/vimrc.html

" END mappings }}}

" END General Settings }}}

" START Appearance Config {{{

set background=dark

" Purposely not using this
" set termguicolors

colorscheme gruvbox-material
let g:gruvbox_contrast_dark='dark'
"colorscheme onedark

" START Vim Dev Icons {{{

let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:webdevicons_conceal_nerdtree_brackets = 0

" END Vim Dev Icons }}}

" START Better Whitespace Config {{{

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:better_whitespace_skip_empty_lines=1
let g:show_spaces_that_precede_tabs=1

" END Better Whitespace Config }}}

" END Appearance Config }}}

" Start Airline Config {{{
" Not totally stolen from below, but mostly
" Credit: https://github.com/alichtman/dotfiles/blob/master/.vimrc

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

" Start ALE Config {{{

" Enabling both loclist and quickfix, and enabling opening the list in a vnew
let g:ale_set_loclist=1
let g:ale_set_quickfix=1
let g:ale_open_list = 1

" ALELinters for each language
let g:ale_linters = {
\     'java': ['checkstyle', 'javac'],
\     'json': ['prettier'],
\     'css': ['prettier'],
\     'html': ['prettier'],
\     'yaml': ['prettier'],
\     'markdown': ['prettier'],
\     'c': ['clang', 'clangd', 'clangtidy', 'cppcheck', 'gcc']
\}

" :ALEFix-ers for each language
let g:ale_fixers = {
\     '*': ['remove_trailing_lines', 'trim_whitespace'],
\     'java': ['google_java_format'],
\     'c': ['clang-format']
\}

" Run :ALEFix when file is saved
let g:ale_fix_on_save=1

" Only check one line at a time
"let g:ale_java_checkstyle_options = '--lines=1'

" End ALE Config }}}

" START coc.nvim config {{{
" Heavily based on: https://github.com/neoclide/coc.nvim#example-vim-configuration
" and https://github.com/alichtman/dotfiles/blob/master/.vimrc

" I personally don't use node, but figure if I ever start it'd be good for it to work
" https://github.com/neoclide/coc.nvim/issues/856
let g:coc_node_path = "/usr/local/bin/node"

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

" Use <M-space> to trigger completion.
inoremap <silent><expr> <M-space> coc#refresh()

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

" START CodeStats config {{{

" all from https://gitlab.com/code-stats/code-stats-vim

" I was gonna remove this for pushing to dotfiles, but if you want to give me
" credit for your work go ahead? I guess? lol
let g:codestats_api_key = 'SFMyNTY.V21GamFFRjBkR0ZqYTAxTVVnPT0jI05UZzRNdz09.yz-3ONv-pOoYqt1LdSngFVEBxCFTqWphjgcpXuigTz8'

let g:airline_section_x = airline#section#create_right(['tagbar', 'filetype', '%{CodeStatsXp()}'])

" END CodeStats Config }}}

" START vim-startify config {{{

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
            \ {'c': '~/notable/notes/'} ]

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
        \ '                                   End my suffering',
        \ ]

let g:startify_files_number = 8
let g:startify_update_oldfiles = 0
let g:startify_session_persistence = 1
let g:startify_session_autoload = 1

" END vim-startify config }}}

" START NERDTree Config {{{

let NERDTreeShowHidden = 1
let NERDTreeStatusline = 0

" END NERDTree Config }}}

" START Autogroups / Autocommands {{{

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
    au BufRead,BufNewFile *.c set noexpandtab
    au BufRead,BufNewFile *.h set noexpandtab
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
    autocmd VimEnter *
                \   if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \ |   PlugInstall --sync | q
                \ | endif
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

" I'm lazy and want 'macros' to just autocorrect like I set up on iOS
augroup WritingAbbreviations
    autocmd!
    autocmd BufRead,BufNewFile *.md,*.txt
        \ iabbrev tbh to be honest |
        \ iabbrev Tbh To be honest |
        \ iabbrev probz probably |
        \ iabbrev cuz because
augroup END

" END Autogroups / Autocommands }}}
