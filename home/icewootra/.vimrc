" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set ttyfast							" I have a fast terminal
set hidden							" allows to put modified buffers in background
set ai								" auto indentation
set showmatch						" shows matching brackets
set ws								" wrap searches
set nu								" shows line numbers
set list
set listchars=tab:\|\  				" display when :set list
set modeline						" look for Vim commands in first and last lines in file
set noexpandtab						" keep tabs, don't change them to spaces
set nostartofline					" don't move cursor to start of line after some commands
set laststatus=2					" always display status bar on the bottom
set shm=a							" shorter messages
set so=4							" always show 7 lines above/below the cursor (while scrolling)

set backupdir=~/.vim/backup,/tmp	" place to keep backups
set directory=~/.vim/swap,/tmp		" place to keep swap files
set undodir=~/.vim/undo,/tmp		" place to keep undo files
set viewdir=~/.vim/view				" place to keep view files
set undofile						" write undo history in files
set tabstop=4						" how much spaces fit in tab?
set shiftwidth=4					" how much space to use for indentation
set background=dark					" tell Vim my terminal is black
set ignorecase						" ignore case when searching
set smartcase						" ignore case when searching only if the string being searched for is all lowercase

set history=50						" keep 50 lines of command line history
set ruler							" show the cursor position all the time
set foldcolumn=1					" so I can see open folds.
set showcmd							" display incomplete commands
set incsearch						" find matches as you type search string

set wildmenu						" Shows IMBA menu for auto completing Vim commands
set shell=bash						" Use bash as shell for external commands
set shellcmdflag=-ic				" Bashrc aliases
set tabpagemax=30					" Support up to 30 tabs

colorscheme zenburn
set bg=dark


set completeopt=longest,menuone,preview				" Omnicomplete (auto complete) options

" <C-p> doesn't type in the highlighted choice
inoremap <expr> <C-p> pumvisible() ? "\<lt>Up>" : "\<lt>C-p>"			

" <C-n> doesn't type in the highlighted choice
inoremap <expr> <C-n> pumvisible() ? "\<lt>Down>" : "\<lt>C-n>"

" use j instead of <Down>
inoremap <expr> j pumvisible() ? "\<lt>Down>" : "j"

" use k instead of <Up>
inoremap <expr> k pumvisible() ? "\<lt>Up>" : "k"

" Remove the preview window after selection
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Save/restore the view automatically
autocmd BufWritePost,BufLeave,WinLeave ?* mkview
autocmd BufWinEnter ?* silent loadview





" Plugins

" NETRW
let g:netrw_preview   = 1									" Preview vertically
let g:netrw_winsize   = 250									" Window size
let g:netrw_browsex_viewer = "xdg-open-bg"					" Open files with xdg-open in backgrund

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Change directory to the current buffer when opening files.
set autochdir


" SYNTASTIC
let g:syntastic_auto_loc_list = 1							" Show errors after checking

let g:syntastic_cpp_compiler = "clang"						" C compiler
let g:syntastic_c_compiler_options	= "-std=c11 -Wall"		" C compiler options

let g:syntastic_cpp_compiler = "clang++"					" C++ compiler
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall"	" C++ compiler options


" NERD COMMENTER
let NERDMenuMode = 0										" Turns off the menu
let NERDUsePlaceHolders = 0									" Don't use nested comments
let NERDSpaceDelims = 1										" Spaces are good!

