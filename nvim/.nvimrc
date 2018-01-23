call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
call plug#end()

set nocompatible
set encoding=utf-8
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.config/nvim/undodir


" statusline config
set laststatus=2
set t_Co=256

" theme config
set background=dark
"colo badwolf

set cursorline

" tab behavior
"TODO: do I need all of these?
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab
set smarttab

filetype plugin indent on
set visualbell
syntax enable

" don't set cwd to open file's dir
"set noautochdir

" bash-like filename completion
set wildmode=longest,list,full
set wildmenu

"""
"" Autocommands and groups
"""

" with autowrite, will save any buffer that 
" is switched away from (like tabbing to a new window)
"augroup AutoWrite
"    autocmd! BufLeave * :update
"augroup END
"set autowrite

" python-specific
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END

" when vimrc is reloaded, vim-airline bugs out
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC | AirlineRefresh
    autocmd BufWritePost $MYVIMRC AirlineRefresh
augroup END " }

"REMOVED because the InsertLeave caused lag when hitting Esc
" omnicomplete
"augroup vimrc_autocmds
"    autocmd!
"    " If you prefer the Omni-Completion tip window to close when a selection is
"    " made, these lines close it on movement in insert mode or when leaving
"    " insert mode
"    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"augroup end
"

""" 
"" OS-specific configuration
"""
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " delete key behavior in osx
    set backspace=indent,eol,start
  endif
endif


"""
"" Keymaps
"""
" Ctrl-p togglegles passste mode
set pastetoggle=<c-p>

" open nerd in cwd
"nnoremap <leader>nt :NERDTree .<CR>

"" toggle set number
nnoremap <leader>sn :set number!<CR>

"" close the current buffer but don't close the window
nnoremap <leader>bb :bp<bar>sp<bar>bn<bar>bd<CR>

"" insert pdb brkpt
" TODO: is it possible to check if ipdb is installed, and use it instead?
nnoremap <leader>pdb oimport pdb; pdb.set_trace()<esc>
nnoremap <leader>ipdb oimport ipdb; ipdb.set_trace()<esc>

"" make \g to go to definition
"nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

"" edit/save vimrc changes
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

" forced disable of arrow key in insert and normal modes.
" note that, in paste mode, these mappings are not applied.
" ref: http://vimdoc.sourceforge.net/htmldoc/map.html#map_return
" this only works partially, as YCM remaps up and down.
" TODO: figure out how to override YCM mappings
"inoremap <Left> <NOP>
"inoremap <Right> <NOP>
"inoremap <Up> <NOP>
"inoremap <Down> <NOP>
"" unsure if the following are necessary
"" inoremap OD <nop>
"" inoremap OC <nop>
"" inoremap OA <nop>
"" inoremap OB <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"nnoremap <up> <nop>
"nnoremap <down> <nop>


"""
"" Plugin Configuration
"""

"" YouCompleteMe
" ctags notes:
"   brew install ctags-exuberant
"   ctags -R --fields=+l .
"let g:ycm_collect_identifiers_from_tags_files = 0 " ctags been giving me issues
"let g:ycm_use_ultisnips_completer = 0 
"let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_complete_in_comments = 0
"let g:ycm_complete_in_strings = 0
"let g:ycm_filetype_whitelist = { 'python':1 } " only use YCM for python
"let g:ycm_min_num_of_chars_for_completion = 2 " default of 2 is annoying
"let g:ycm_min_num_of_chars_for_completion = 99 " effectively disable identifier completion
"let g:ycm_auto_trigger = 0
" trying some shit out
"let g:ycm_add_preview_to_completeopt = 0
"set completeopt-=preview
"let g:ycm_autoclose_preview_window_after_completion=1

" disable ycm autocompletion unti I can figure out why it tries to match
" function params
"let g:ycm_auto_trigger = 0
"autocmd CompleteDone * pclose
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1
"" NERDTree
"let NERDTreeChDirMode=0
" show bookmarks automatically
"let NERDTreeShowBookmarks=1
" start nerdtree if vim is opened with no files specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close window if nerdtree is the only buffer
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"" vim-airline
let g:airline_powerline_fonts = 1

"" vim-airline-tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#syntastic#enabled = 1

"" syntastic
"let g:syntastic_always_populate_loc_list = 1
" I dont like the loclist popping up.
" instead, use :lopen and :lclose to see the violations
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_quiet_messages = { 
"    \ "regex": '\m\[E501]' }
"let g:syntastic_python_checkers = ['flake8']
"set timeout " Do time out on mappings and others
"set timeoutlen=700 " Wait {num} ms before timing out a mapping
"
"" When you’re pressing Escape to leave insert mode in the terminal, it will by
"" default take a second or another keystroke to leave insert mode completely
"" and update the statusline. This fixes that. I got this from:
"" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
"if !has('gui_running')
"    set ttimeoutlen=10
"    augroup FastEscape
"        autocmd!
"        au InsertEnter * set timeoutlen=0
"        au InsertLeave * set timeoutlen=1000
"    augroup END
"endif
