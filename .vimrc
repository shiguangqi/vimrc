" {{{
" DesCRiption: shiguangqi
" Created Date: 2012-05-04
" Last Changed: 2012-12-13 
" Author:      shiguangqi
" Version:     0.3
"}}}
let performance_mode=0
"function
function! MySys()
    if has("win32")
        return "win32"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction

" Sets how many lines of history VIM has to remember
set history=700
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
set number
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" => Colors and Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
if MySys()=="unix"
  if v:version<600
      if filereadable(expand("$VIM/syntax/syntax.vim"))
          syntax on
      endif
  else
      syntax on
  endif
else
  syntax on
endif

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso8859-1,gbk,default,latin

if has("gui_running")
set guioptions-=m
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
set guioptions-=t

  if MySys()=="win32"
      "start gvim maximized
      if has("autocmd")
          au GUIEnter * simalt ~x
      endif
  endif
  "let psc_style='cool'
  if v:version > 601
      "colorscheme ps_color
      "colorscheme default
      colorscheme desert 
    set guifont=Consolas:h10
  endif
else
  if v:version > 601
      "set background=dark
      colorscheme default " desert
      "colorscheme desert "elflord
    set guifont=Consolas:h10
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetype
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"Format the statusline
" Nice statusbar
if performance_mode
else
  set laststatus=2
  set statusline=
  "set statusline+=%2*%-3.3n%0*/ " buffer number
  set statusline+=%f/ " file name
  set statusline+=%1*%h%m%r%w%0* " flags
  set statusline+=%2*0x%-8B " current char
"set statusline+=%-8O
set statusline+=%-8b
  set statusline+=%-14.(%l,%c%V%)/%5p%% " offset
  set statusline+=%= " right align
  set statusline+=%0*[
  if v:version >= 600
      set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
      set statusline+=%{&encoding}, " encoding
  endif
  set statusline+=%{&fileformat}]%1* " file format
  if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
      set statusline+=/ %{VimBuddy()} " vim buddy
  endif

"    " special statusbar for special windows
"    if has("autocmd")
"        au FileType qf
"                    / if &buftype == "quickfix" |
"                    / setlocal statusline=%2*%-3.3n%0* |
"                    / setlocal statusline+=/ /[Compiler/ Messages/] |
"                    / setlocal statusline+=%=%2*/ %<%P |
"                    / endif
"
"        fun! FixMiniBufExplorerTitle()
"            if "-MiniBufExplorer-" == bufname("%")
"                setlocal statusline=%2*%-3.3n%0*
"                setlocal statusline+=/[Buffers/]
"                setlocal statusline+=%=%2*/ %<%P
"            endif
"        endfun
"
"        if v:version>=600
"            au BufWinEnter *
"                        / let oldwinnr=winnr() |
"                        / windo call FixMiniBufExplorerTitle() |
"                        / exec oldwinnr . " wincmd w"
"        endif
"    endif
"
"    " Nice window title
"    if has('title') && (has('gui_running') || &title)
"        set titlestring=
"        set titlestring+=%f/ " file name
"        set titlestring+=%h%m%r%w " flags
"        set titlestring+=/ -/ %{v:progname} " program name
"    endif
endif

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
      hi statusline guibg=peru
  elseif a:mode == 'r'
      hi statusline guibg=blue
  else
      hi statusline guibg=red
  endif
endfunction
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=#9932CC guifg=white
hi statusline guibg=#696969 guifg=#B8860B

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]
map <leader>sp [
map <leader>sa zg
map <leader>s? z=

"Fast reloading of the .vimrc
map <silent> <leader>ss :source $HOME/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :e $HOME/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source $VIM/.vimrc 

" autoload _vimrc
autocmd! bufwritepost .vimrc source %

" use chinese help
set helplang=cn

" NERDTree
map <F10> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => Plugin configuration

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" taglist
let Tlist_Show_One_File = 1 
let Tlist_Exit_OnlyWindow = 1 
let Tlist_Use_Right_Window = 1 
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 0
let Tlist_Compact_Format = 0
let Tlist_Display_Prototype = 0
let Tlist_Display_Tag_Scope = 1
let Tlist_Enable_Fold_Column = 0
"let Tlist_Exit_OnlyWindow = 0
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Inc_Winwidth = 0
map <silent> <F9> :TlistToggle<cr> 

"map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
"imap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" 
" required! 
Bundle 'gmarik/vundle'
Bundle 'taglist.vim'
Bundle 'scrooloose/nerdtree'

filetype plugin indent on     " required!
