" enable vim features instead of strict vi compatibility
set nocompatible

" do not wrap long lines; have them scroll off the side
set nowrap

" try to detect the filetype
filetype on

" enable syntax highlighting
syntax on

" enable loading the plugin file for specific file types
filetype plugin on

" enable loading the indent file for specific file types
filetype indent on

" tell vim it's OK to use 256 colors at the terminal
set t_Co=256

" show matching brackets and parens
set showmatch

" don't bother redrawing during macros and such
"set lazyredraw

" use pop-up menu for tab completion of filenames
set wildmenu

" sync syntax highlighting in a 5000-line window
" syntax sync minlines=5000

" sync syntax highlighting from the start of the file
syntax sync fromstart

" do not make backup~ files
set nobackup
set nowritebackup

" set character encoding to UTF-8
set encoding=utf-8

" show 3 lines above or below cursor when scrolling
set scrolloff=3

" show insert, replace, or visual mode in last line
set showmode

" show command in last line
set showcmd

" highlight the line the cursor is on
" set cursorline " leave off for now; ugly when listing hidden chars

" turn on line numbers
set number

" flash screen on bell
set visualbell

" assumes fast connection
set ttyfast

" show line and column number
set ruler

" every window gets a status line
set laststatus=2

" switch off search pattern highlighting
set nohlsearch

" make command line one line high
set ch=1

" turn off mouse pointer when typing begins
set mousehide

" put mouse in command-line mode, so mouse clicks don't move cursor
set mouse=c

" set molokai_dark color scheme
colorscheme molokai_dark

" set leader to comma
let mapleader = ","

" local leader to backslash. (local leader is used for only specific file
" types)
let maplocalleader = "\\"

" Searching
" ------------
" Highlight matches in search
set hlsearch

" Turn off search highlight when done
nnoremap <Leader><Space> :nohlsearch<CR>

" Listing unprintable chars
" ------------
" Change vertical split character from a bar to a space
" (so note that trailing space here is significant)
set fillchars+=vert:\ 

" Show spaces and tabs; to turn off for copying, use `:set nolist`
set listchars=tab:→\ ,space:·,trail:·,nbsp:·

" Default to listing hidden chars
set list

" Toggle listing hidden chars
nnoremap <Leader><CR> :set list!<CR>

" Status Line
" ------------
" %< means truncate on the left if too long
" %F is full path to the file we are editing
set statusline=%<%F

" %m shows [+] if the file is modified but not saved
set statusline+=%m

" %r shows [RO] if a file is read-only
set statusline+=%r

" %h shows [Help] if we are in a help buffer
set statusline+=%h

" %w shows [Preview] if we are in a preview window
set statusline+=%w

" separation point between the left and right items
set statusline+=%=

" prints the fileformat; that is, the kind of newline (one of unix, dos or mac)
" (If you type `:set fileformat?`, vim will tell you the current file format)
set statusline+=%{&fileformat}

" a literal forward slash
set statusline+=/

" %Y shows the filetype, such as VIM or HTML or GO
set statusline+=%Y

" %l shows the line number, and %8l uses 8 left-padded spaces to do so
set statusline+=%8l

" a literal comma
set statusline+=,

" %v shows the virtual column number;
" instead of counting a tab as one char, it counts it as the number
" of spaces it uses in the display
" %-8v leaves 8 spaces to the right to do so
set statusline+=%-8v

" disable recording macros: I hit this key accidentally too often
nnoremap q <Nop>

" Window Manipulation
" -------------------
" Note to self:
" :resize will resize a horizontal split, *and* you can give it
" relative lines, like :resize +5 or :resize -5
" :vertical resize can be used for vertical splits.

" remap window switching to leader then navigation letter
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>l <C-W><C-L>
nnoremap <Leader>h <C-W><C-H>

" remap window equal resizing to leader equals
nnoremap <Leader>= <C-W><C-=>

" when opening horizontal splits, place cursor in new split
set splitbelow

" when opening vertical splits, place cursor in new split
set splitright

function DestroyButKeepWindow()
  " get the number of the buffer we will close
  let l:current_bufnum = bufnr('%')
  " open a new empty buffer in this window
  enew
  " destroy the original buffer
  execute "bdelete " . l:current_bufnum
endfunction

" Make :Bd call the window closer
command Bd call DestroyButKeepWindow()

" Explore
" -------
" Note to self:
" :Explore brings up explorer
" :Sexplore brings up explorer in a horizontal split
" :Vexplore brings up explorer in a vertical split

" Remove explorer banner
let g:netrw_banner = 0

" Ruby
" ----
augroup filetype_ruby
  autocmd!
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal expandtab
augroup END

" Golang
" ------
augroup filetype_golang
  " when we use :make, autosave file; used by vim-go
  set autowrite

  autocmd!
  autocmd FileType go setlocal shiftwidth=2
  autocmd FileType go setlocal tabstop=2
  autocmd FileType go setlocal softtabstop=0
  autocmd FileType go setlocal noexpandtab
  "autocmd FileType go nmap <Leader>d <Plug>(go-def-vertical)
  "autocmd FileType go nmap <Leader>D <Plug>(go-doc-vertical)
  "autocmd FileType go nmap <Leader>b <Plug>(go-doc-browser)
  "autocmd FileType go nmap <Leader>i <Plug>(go-implements)
  "autocmd FileType go nmap <Leader>n <Plug>(go-info)
  "autocmd FileType go nmap <Leader>r <Plug>(go-rename)
augroup END
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
"These next two were too invasive, so I disabled them.
"let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
"This next one was too distracting (but cool!); just use :GoInfo
"let g:go_auto_type_info = 1

" Use j and k to navigate up and down autocomplete,
" at the expense of not being able to type j and k
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

au BufNewFile,BufRead Jenkinsfile* setf groovy
au BufNewFile,BufRead *.groovy setf groovy
