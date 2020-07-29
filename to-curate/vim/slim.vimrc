
" Basics
" ------

set nocompatible

syntax on
filetype on


" Customizations Start Here
" -------------------------


" >" Settings/Options
" >" ----------------

set t_Co=256

set ruler
set nu

set expandtab tabstop=2 softtabstop=2 shiftwidth=2

set splitright splitbelow

set path+=**

set ignorecase smartcase
set incsearch

set showcmd

set gdefault       " -- for :s ... the default becomes: :s with the g flag --

set autoindent autowrite

set bs="indent,eol,start'

set colorcolumn=80

set confirm       " -- instead of saying can't quit cuz buffer modified, ask to save it

set nowrap nolist

set nohlsearch


" >" Keyboard Shortcuts
" >" ------------------

nnoremap <Space>w :w<cr>
nnoremap <Space>q :q<cr>

nnoremap <Space><Space> :
nnoremap <Space>1 :!
nnoremap <Space>r :r!

nnoremap <Space>l :ls<cr>
nnoremap <Space>L :ls!<cr>

nnoremap <Space>e :e 
nnoremap <Space>E :e <c-r>=expand('%:h')<cr>/
nnoremap <Space>v :vs 
nnoremap <Space>V :vs <c-r>=expand('%:h')<cr>/
nnoremap <Space>s :sp 
nnoremap <Space>S :sp <c-r>=expand('%:h')<cr>/

nnoremap col :set list!<cr>
nnoremap cow :set wrap!<cr>
nnoremap coh :set hlsearch!<cr>
nnoremap cop :set paste!<cr>
nnoremap cob :set buftype=<C-r>=(&buftype == 'nofile' ? '' : 'nofile')<cr><cr>

nnoremap > >>
nnoremap < <<

nnoremap <C-w>f :vert wincmd f<cr>
nnoremap <C-w>F :vert wincmd F<cr>

" <C-w>f -> :vert wincmd f

" >" Command Abbreviations
" >" ---------------------

cabbrev svim source ~/.vimrc
cabbrev evim vs ~/.vimrc | lcd ~/

cabbrev ebash vs ~/.bashrc | lcd ~/
cabbrev einput vs ~/.inputrc | lcd ~/



" things for newbs to learn:
"
" :h cmdline.txt
"   see: <cword>, <cWORD>, etc.
"
" :h c_%, c_#, c_#n



" ----------------------------------------------------------------------
" USE A FUNCTION TO RESET ALL OPTIONS TO MY PREFERRED DEFAULTS:
" 
" - do this instead of having individual mappings to switch them back:
"   - col " toggles list
"   - cop " toggles paste
"   - cow " toggles wrap
"   - cob " toggles buftype
"   - coh " toggles hlsearch

" - i also thought of a function called ~"toggle" that takes a search
"   term and uses it to find one of my commonly toggled options, and
"   then toggles the option between my 2 common values for that option.

" - another option is opening a new buffer that contains all the set
"   commands, and that way i can review/edit them before processing
"   the command.  Once I am satisfied, I can basically just source that
"   file to apply the desired settings.
" ----------------------------------------------------------------------


function! ResetDefaults()
  set splitright splitbelow
  set ignorecase smartcase
  set nowrap nolist
  set nohlsearch
  set number relativenumber

  set expandtab tabstop=2 softtabstop=2 shiftwidth=2
  %retab!

  set tw=80

  let l:xtra =<< trim END
    :g/./norm gwl
    :echom "done, should have reformatted those lines"
  END

  let @d=join(l:xtra + [""], "\n")

  echom "NOTE: Type @d to run extras, like applying the textwidth, etc."
endfunction

cabbrev fixopts call ResetDefaults()
cabbrev fixdefaults call ResetDefaults()
cabbrev defaults call ResetDefaults()


function! IResetDefaults()
  let l:fname = tempname()

  let l:mydefaults =<< trim END
" run :ls and get this buffer number
" go back to the buffer where you need to set the defaults
" and run -> :source #234  (if this buffer was 234)

set number relativenumber

set splitright splitbelow

set ignorecase smartcase

set nowrap nolist

set nohlsearch

" SUGGESTED: (just uncomment)
" ---------------------------

set expandtab tabstop=2 softtabstop=2 shiftwidth=2
" %retab!

set tw=80
" g/./norm gwl
END

  exe "redir > " . fname
  echo join(l:mydefaults, "\n")
  exe "redir END"
  execute('vs ' . fname)
endfunction

cabbrev ifixopts call IResetDefaults()
cabbrev ifixdefaults call IResetDefaults()
cabbrev idefaults call IResetDefaults()

