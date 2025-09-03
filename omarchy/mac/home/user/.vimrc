set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'christoomey/vim-tmux-navigator'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'vim-airline/vim-airline'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Plugin 'github/copilot.vim'

call vundle#end()            " required
filetype plugin on    " required
" filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Commenting blocks of code.
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType lua              let b:comment_leader = '--'
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> ,c :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,u :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab expandtab
syntax on
filetype indent on
:set autoindent

" Python indentation override to deal with synatax on + indent on issue
augroup python_indent
    autocmd!
    autocmd FileType python setlocal indentexpr=
    autocmd FileType python setlocal cindent
    autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
augroup END

" colorscheme forth
" autocmd Filetype gitcommit setlocal spell textwidth=72

"nnoremap <C-u> <C-w>k
"nnoremap <C-j> <C-w>j
"nnoremap <C-h> <C-w>h
"nnoremap <C-k> <C-w>l

" Mapping for seamless tmux-vim navigation
let g:tmux_navigator_no_mappings = 1
noremap <silent> <C-u> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-k> :<C-U>TmuxNavigateRight<cr>

" Vim tmux runner values
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
let g:VtrUseVtrMaps = 1

" Remap default leader to space
:let mapleader = "\<Space>"

" Setup visibility of tabs and traling spaces
set listchars=tab:>~,nbsp:~,trail:.
set list

" We setup line number
" :set nu

" Mapping for NERDTree open
nnoremap <Leader>nt :NERDTreeVCS<CR>

" Mapping to show a list of all maps :)
nnoremap <silent> <Leader>ml :nmap <Leader><CR>

command! Fuz call fzf#run({'sink': 'e'})
cnoreabbrev fuz Fuz

command! Gogl Commits
cnoreabbrev gogl Gogl
cnoreabbrev ag Ag
cnoreabbrev rg Rg

command! Gus GFiles?
cnoreabbrev gus Gus

nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

set mouse=a
set clipboard=unnamed

set number
highlight LineNr ctermfg=94

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" Check if running in Wayland by checking the WAYLAND_DISPLAY environment variable
" Sync yanks and deletes to Wayland clipboard while preserving the unnamed register
if !empty($WAYLAND_DISPLAY)
  augroup wayland_clipboard
    autocmd!
    autocmd TextYankPost * call system('wl-copy', @")
  augroup END
endif
