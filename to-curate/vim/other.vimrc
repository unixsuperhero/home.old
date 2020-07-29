syntax on
filetype plugin on                                " Enable loading filetype plugins
filetype indent on                                " Enable loading indentation plugins

if $VIM_PLUGINS != 'NO'
  runtime! autoload/pathogen.vim
  if exists('g:loaded_pathogen')
    execute pathogen#infect('~/.vimbundles/{}', '~/.vim/bundle/{}')
  endif
endif

let g:netrw_browse_split = 1  " netRW: Open files in a split window

set t_Co=256
set ruler
set ignorecase smartcase
set expandtab shiftwidth=2 tabstop=2 softtabstop=2
set nowrap nolist
set nostartofline
set splitright splitbelow
set visualbell
set confirm
set gdefault
set hidden
set incsearch
set laststatus=2
set nohlsearch
set showcmd
set number
set linebreak
set backspace=indent,eol,start
set nrformats=octal,hex,alpha
set scrolloff=4
set sidescrolloff=2
set showmatch
set matchtime=2
set modeline modelines=5
set history=1000                                  " Remember up to 1000 'colon' commmands and search patterns
set wildmenu
set wildmode=list:longest,full

set equalprg=bc                                   " cmd to use when you press = in visual mode
set mouse=a
set t_RV=                                         " Don't request terminal version string (for xterm)
set updatecount=50                                " Write swap file to disk after every 50 characters
set enc=utf-8                                     " Use UTF-8 as the default buffer encoding
"set shortmess=filnxtToO                          " this is the default value, changed it to avoid the hit-enter message
set viminfo='200,\"100,/9000,:9000,n~/.viminfo    " Remember things between sessions
set backupskip=/tmp/*,/private/tmp/*"
set diffopt=filler,iwhite,vertical
set switchbuf=useopen,split

set spellfile=~/.vim/words.utf8.add
"set formatprg=par\ -w60re

" finally adding new option changes (it's been a long time)
" current date and time is 2018-02-07 23:28:46
set fileignorecase wildignorecase

cabbrev HDIR <c-r>=expand('$HOME')<cr><c-r>=Eatchar('\_\s')<cr>
cabbrev HD <c-r>=expand('$HOME')<cr><c-r>=Eatchar('\_\s')<cr>
cabbrev sothis source <c-r>=expand('%')<cr>
cabbrev sourcethis source <c-r>=expand('%')<cr>

if has('persistent_undo')
  set undofile
  set undodir=~/.vim/tmp//,~/.vim/undo_files//,~/.vim//,/tmp//
endif

" vimrc specific autocmds, so that they can be deleted them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

augroup END

  " makeprgs ---------------------------------------------------------
au FileType ruby       setlocal makeprg=`rbenv\ which\ ruby`\ -c\ %
au FileType ruby       nmap ,x <plug>(xmpfilter-run)
au FileType ruby       nmap ,m <plug>(xmpfilter-mark)
au FileType eruby      setlocal makeprg=rails-erb-check\ %
au FileType haml       setlocal makeprg=haml\ -c\ %
au FileType sh         setlocal makeprg=bash\ -n\ %
au FileType cucumber   setlocal makeprg=bundle\ exec\ cucumber\ %
au FileType json       setlocal makeprg=jshint\ %
au FileType javascript setlocal makeprg=jshint\ %
au FileType fish       compiler fish
"au FileType help       exe "au BufEnter <buffer> set winminwidth=80 | set winwidth= | set winminwidth=20"
au BufNewFile,BufRead,BufReadPost */Gemfile setlocal makeprg=bundle

"au FileType ruby     nmap ,R :exe "nmap ,r :!rspec " . expand("%") . "\<cr\>"<cr>
"au FileType ruby     nmap ,R :exe "nmap ,r :!rspec " . expand("%") . "\<cr\>"<cr>
"au FileType ruby     nmap ,T :silent exe "nmap ,t :!echo 'bundle exec rspec " . expand("%") . " \\\| sed -n \"/FAILED/p;/ contained:/p;/ were:/p;/[0-9] example/p;/^[[:space:]]*[0-9][0-9]*)/,/:[0-9][0-9]*:/p;/debug_start/,/debug_end/p\"' \\\| pbcopy \<cr\>\<C-L\> \| nmap ,l :exe \"silent !echo 'bundle exec rspec \" . expand(\"%\") . \":\" . line(\".\") . \" \\\| sed -n \\\"/FAILED/p;/ contained:/p;/ were:/p;/[0-9] example/p;/^[[:space:]]*[0-9][0-9]*)/,/:[0-9][0-9]*:/p;/debug_start/,/debug_end/p\\\"' \\\| pbcopy\"\<cr\>\<C-L\>"<CR>
au FileType ruby     nmap ,T :silent exe "nmap ,t :w \\\|silent !echo 'bundle exec rspec " . expand("%") . " \\\| sed -n \"1,3p;/FAILED/p;/ contained:/p;/ were:/p;/[0-9] example/p;/^[[:space:]]*[0-9][0-9]*)/,/:[0-9][0-9]*:/p;/debug_start/,/debug_end/p\"' \>tmp/test_commands\<cr\>\<C-L\> \| nmap ,l :exe \"w \\\|silent !echo 'bundle exec rspec \" . expand(\"%\") . \":\" . line(\".\") . \" \\\| sed -n \\\"1,3p;/FAILED/p;/ contained:/p;/ were:/p;/[0-9] example/p;/^[[:space:]]*[0-9][0-9]*)/,/:[0-9][0-9]*:/p;/debug_start/,/debug_end/p\\\"' \>tmp/test_commands\"\<cr\>\<C-L\>"<CR>
au FileType ruby     nmap ,C :silent exe "nmap ,t :w \\\|silent !echo 'bundle exec rspec " . expand("%") . "' \>tmp/test_commands\<cr\>\<C-L\> \| nmap ,l :exe \"w \\\|silent !echo 'bundle exec rspec \" . expand(\"%\") . \":\" . line(\".\") . \"' \>tmp/test_commands\"\<cr\>\<C-L\>"<CR>
au FileType ruby     nmap ,R :silent exe "nmap ,t :w\\\|silent !echo 'rspec " . expand("%") . "' \>tmp/test_commands\<cr\>\<C-L\> \| nmap ,l :exe \"w\\\|silent !echo 'rspec \" . expand(\"%\") . \":\" . line(\".\") . \"' \>tmp/test_commands\"\<cr\>\<C-L\>"<CR>
au FileType ruby     nmap ,d :silent !echo 'rake docs:v2:build' >tmp/test_commands<cr><C-l>
" au FileType ruby     nmap ,g :silent !echo 'rake docs:v2:generate' >tmp/test_commands<cr><C-l>

  " equalprgs (for formatting)
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ %

au FileType markdown   setlocal makeprg=if\ which\ pandoc\ \&>/dev/null;\ then\ pandoc\ %\ >%.html;\ else\ markdown\ %;\ fi
au FileType markdown   setlocal tw=80
au FileType markdown   hi markdownCode   ctermfg=15 ctermbg=2
au FileType markdown   hi markdownCodeDelimiter cterm=bold ctermfg=1 ctermbg=240

au FileType vim   hi vimLineComment cterm=bold ctermfg=16 ctermbg=9

  " bin/notes ---------------------------------------------------------
autocmd BufNewFile,BufRead */notes/* set ft=notes
      " \ if &ft =~# '^\%(markdown\)$' |
      " \   set ft=notes |
      " \ else |
      " \   setf notes |
      " \ endif
au! FileType notes
au FileType notes   setlocal makeprg=markdown\ %
au FileType notes   setlocal tw=80
au FileType notes   nmap ,s :w\|!git add %;git commit -m 'autocommitting %'<cr>

  " bin/task  ---------------------------------------------------------
autocmd BufNewFile,BufRead */tasks/* setlocal tw=60
autocmd BufNewFile,BufRead */tasks/* nmap ,q :wqa<cr>

augroup help_autocmds
  au! FileType help
  au FileType help hi clear helpExample
  au FileType help hi helpExample term=bold cterm=bold ctermfg=4 ctermbg=9
augroup END

augroup diff_autocmds
  au! FileType diff
  au FileType diff hi diffAdded term=NONE cterm=NONE
augroup END

au FileType ruby       setlocal makeprg=`rbenv\ which\ ruby`\ -c\ %

" Abbreviations

func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

" Rails

" cabbrev espec e <c-r>=expand('%:s@app/\zsviews@controllers@:s@/[^/]\+\(_controller.rb\)\@<!$@_controller.rb@:s/app/spec/:s/\ze\.rb$/_spec/')<cr>
" cabbrev sspec sp <c-r>=expand('%:s@app/\zsviews@controllers@:s@/[^/]\+\(_controller.rb\)\@<!$@_controller.rb@:s/app/spec/:s/\ze\.rb$/_spec/')<cr>
" cabbrev vspec vs <c-r>=expand('%:s@app/\zsviews@controllers@:s@/[^/]\+\(_controller.rb\)\@<!$@_controller.rb@:s/app/spec/:s/\ze\.rb$/_spec/')<cr>

cabbrev rake !rake
cabbrev testrake !rake RAILS_ENV=test<m-b><Left>

cabbrev migrate !rake db:migrate<cr>
cabbrev testmigrate !rake db:migrate RAILS_ENV=test<cr>

cabbrev espec e <c-r>=expand('%:s/app/spec/:s/\ze\.rb$/_spec/')<cr>
cabbrev sspec sp <c-r>=expand('%:s/app/spec/:s/\ze\.rb$/_spec/')<cr>
cabbrev vspec vs <c-r>=expand('%:s/app/spec/:s/\ze\.rb$/_spec/')<cr>

cabbrev eapp e <c-r>=expand('%:s/spec/app/:s/_spec\ze\.rb$//')<cr>
cabbrev sapp sp <c-r>=expand('%:s/spec/app/:s/_spec\ze\.rb$//')<cr>
cabbrev vapp vs <c-r>=expand('%:s/spec/app/:s/_spec\ze\.rb$//')<cr>

"" Date Related


iab curdt    <c-r>=strftime('%Y%m%d%H%M%S')<cr><c-r>=Eatchar('\s')<cr>
iab fmtdt    %Y%m%d%H%M%S<c-r>=Eatchar('\s')<cr>
iab cur_dt    <c-r>=strftime('%Y-%m-%d %H:%M:%S')<cr><c-r>=Eatchar('\s')<cr>
iab fmt_dt    %Y-%m-%d %H:%M:%S<c-r>=Eatchar('\s')<cr>

iab cdate    <c-r>=strftime('%Y%m%d')<cr><c-r>=Eatchar('\s')<cr>
iab ctime    <c-r>=strftime('%H%M%S')<cr><c-r>=Eatchar('\s')<cr>
iab fdate    %Y%m%d<c-r>=Eatchar('\s')<cr>
iab ftime    %H%M%S<c-r>=Eatchar('\s')<cr>
iab c_date    <c-r>=strftime('%Y-%m-%d')<cr><c-r>=Eatchar('\s')<cr>
iab c_time    <c-r>=strftime('%H:%M:%S')<cr><c-r>=Eatchar('\s')<cr>
iab f_date    %Y-%m-%d<c-r>=Eatchar('\s')<cr>
iab f_time    %H:%M:%S<c-r>=Eatchar('\s')<cr>

ab cur_time      =strftime("%Y-%m-%d %H:%M:%S")
ab cur_timestamp =strftime("%s")
ab cur_epoch     =strftime("%s")

ab cur_Y   =strftime("%Y")
ab cur_y   =strftime("%y")
ab cur_m   =strftime("%m")
ab cur_d   =strftime("%d")

ab cur_H   =strftime("%H")
ab cur_M   =strftime("%M")
ab cur_S   =strftime("%S")



" /Time Formats

cabbrev einit e ~/.config/nvim/init.vim
cabbrev sinit sp ~/.config/nvim/init.vim
cabbrev vinit vs ~/.config/nvim/init.vim
cabbrev soinit so ~/.config/nvim/init.vim

cabbrev ehii e ~/.config/nvim/plugin/h.vim
cabbrev shii sp ~/.config/nvim/plugin/h.vim
cabbrev vhii vs ~/.config/nvim/plugin/h.vim
cabbrev sohii so ~/.config/nvim/plugin/h.vim

cabbrev evim e ~/.vimrc
cabbrev evimrc e ~/.vimrc
cabbrev svim sp ~/.vimrc
cabbrev svimrc sp ~/.vimrc
cabbrev vvim vs ~/.vimrc
cabbrev vvimrc vs ~/.vimrc
cabbrev sovim so ~/.vimrc
cabbrev sovimrc so ~/.vimrc
" cabbrev vimrc vs ~/.vimrc
cabbrev ezsh e ~/.zshrc
cabbrev ezshrc e ~/.zshrc
cabbrev szsh sp ~/.zshrc
cabbrev szshrc sp ~/.zshrc
cabbrev vzsh vs ~/.zshrc
cabbrev vzshrc vs ~/.zshrc
" cabbrev zshrc vs ~/.zshrc

cabbrev etmux e ~/.tmux.conf
cabbrev stmux sp ~/.tmux.conf
cabbrev vtmux vs ~/.tmux.conf

cabbrev Expand <c-r>=expand('')<left><left><c-r>=Eatchar('\s')<cr>
" Editing files in same directory

cabbrev subv vs <c-r>=expand('%:h')<cr>/<c-r>=Eatchar('\s')<cr>
cabbrev subs sp <c-r>=expand('%:h')<cr>/<c-r>=Eatchar('\s')<cr>
cabbrev sube e <c-r>=expand('%:h')<cr>/<c-r>=Eatchar('\s')<cr>

cabbrev vsub vs <c-r>=expand('%:h')<cr>/<c-r>=Eatchar('\s')<cr>
cabbrev ssub sp <c-r>=expand('%:h')<cr>/<c-r>=Eatchar('\s')<cr>
cabbrev esub e <c-r>=expand('%:h')<cr>/<c-r>=Eatchar('\s')<cr>

cabbrev safeil <c-r>=system('ilstart ' . expand('%'))<cr>,$il!/<C-r>=Eatchar('\s')<cr>
cabbrev sil <c-r>=system('ilstart ' . expand('%'))<cr>,$il!/<C-r>=Eatchar('\s')<cr>

cabbrev this <c-r>=expand('%')<cr>
cabbrev thish <c-r>=expand('%:h')<cr>
cabbrev thist <c-r>=expand('%:t')<cr>
cabbrev thisr <c-r>=expand('%:r')<cr>
cabbrev thise <c-r>=expand('%:e')<cr>
cabbrev thisp <c-r>=expand('%:p')<cr>

" Setting the makeprg

cabbrev fixmp set mp=ruby\ -c\ %
cabbrev mprb set mp=ruby\ -c\ %

cabbrev isruby set ft=ruby
cabbrev isrb set ft=ruby

" Turn off modifiable and readonly

cabbrev fixro set modifiable noreadonly
cabbrev fixedit set modifiable noreadonly

cabbrev editable set modifiable noreadonly
cabbrev editme set modifiable noreadonly
cabbrev editthis set modifiable noreadonly

" convert tabs to spaces for files that need it

cabbrev fixtab exe('set et sw=2 sts=2 ts=2') \| exe('%retab')
cabbrev fixtabs exe('set et sw=2 sts=2 ts=2') \| exe('%retab')


" Do stuff to the current file

cabbrev clean_ag exe('0r!echo') \| exe('%s@^\([^:]*:\)\d\d*:.*\n\ze\1\@!@&\r@e') \| exe('%s@^\s*\n\zs\([^:]*:\)\ze\d\d*:@&\r&@e') \| exe('%s@^[^:]*:\ze\d\d*:@  @e')

cabbrev shme !<c-r>=expand('%:.:s@^\([^\/]*\)$@./\1@')<cr>
cabbrev shthis !<c-r>=expand('%:.:s@^\([^\/]*\)$@./\1@')<cr>
cabbrev runme !<c-r>=expand('%:.:s@^\([^\/]*\)$@./\1@')<cr>
cabbrev runthis !<c-r>=expand('%:.:s@^\([^\/]*\)$@./\1@')<cr>

cabbrev sothis source <c-r>=expand('%')<cr>
cabbrev sourcethis source <c-r>=expand('%')<cr>

cabbrev llthis !ls -l <c-r>=expand('%')<cr>
cabbrev rmthis !rm -v <c-r>=expand('%')<cr>
cabbrev modthis !chmod +x <c-r>=expand('%')<cr>;ls -l <c-r>=expand('%')<cr>

cabbrev llthish !ls -l <c-r>=expand('%:h')<cr>
cabbrev ll !ls -l

" cabbrev man vnew \| set buftype=nofile \| r!man  \| plain<left><left><left><left><left><left><left><left><C-R>=Eatchar('\s')<CR>
cabbrev pager vnew \| set buftype=nofile \| r! \| plain<M-b><M-b><M-b><left><C-R>=Eatchar('\s')<CR>
cabbrev gstatus Gstatus \| wincmd J
cabbrev gst Gstatus \| wincmd J

cabbrev V vert
cabbrev vh vert h

cabbrev VI '<,'><c-r>=Eatchar('\s')<cr>

cabbrev aar argadd
cabbrev aany argadd **/**/**<Left><Left><Left><Left><C-r>=Eatchar('\s')<CR>
cabbrev vall vert sall
cabbrev vnext vert snext
cabbrev vprev vert sprevious

cabbrev enotes e notes \| setl buftype=nofile
cabbrev vnotes vs notes \| setl buftype=nofile
cabbrev snotes sp notes \| setl buftype=nofile

cabbrev wnotes exe('vs notes') \| exe('wincmd J') \| exe('set buftype=') \| exe('w') \| exe('set buftype=nofile') \| exe('q')

" cabbrev vnote  vnew \| setl buftype=nofile
" cabbrev snote new \| setl buftype=nofile
cabbrev noteme setl buftype=nofile
cabbrev notethis setl buftype=nofile

cabbrev nonoteme setl buftype=
cabbrev nonotethis setl buftype=

cabbrev w!! w ! sudo tee "%"

cabbrev goog <c-u>!google

" hi CursorLine cterm=bold term=bold ctermbg=235 ctermfg=7
" hi CursorColumn cterm=bold term=bold ctermbg=235 ctermfg=7
" hi LineNr term=underline ctermfg=black ctermbg=white guifg=black

cabbrev vb vert sb

" cabbrev ef FZF -m
" cabbrev vsf FZF -m


" INSERT MODE ABBREVIATIONS:

iab poro_template class PoroName<cr>class << self<cr>end<cr><cr>attr_accessor :something<cr>def initialize(something)<cr>@something = something<cr>end<cr>end<cr><esc>

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif


function! Sequence(pat) range
  let x=1
  exe a:firstline . "," . a:lastline . "g" . a:pat . "s" . a:pat . "\\=x/ | let x=x+1"
endfunction

fun! SetJoshColors()
  let g:match_hi_index = 0
  let g:match_highlight_groups = {}
  let g:hi_group_names = []
  for row in [3, 7, 9, 10, 11, 13, 14, 15]
    for col in [0, 1, 4, 5, 8]
      let g:match_hi_index = g:match_hi_index + 1

      let group_name = printf('Josh%03d', g:match_hi_index)
      call insert(g:hi_group_names, group_name, len(g:hi_group_names))

      let g:match_highlight_groups[group_name] = [row, col]
      exe('highlight clear ' . group_name)
      exe('hi ' . group_name . ' term=bold cterm=bold ctermfg=' . col . ' ctermbg=' . row)

      let group_name2 = printf('Josh%03d', g:match_hi_index + 40)
      call insert(g:hi_group_names, group_name2, len(g:hi_group_names))

      let g:match_highlight_groups[group_name2] = [col, row]
      exe('highlight clear ' . group_name2)
      exe('hi ' . group_name2 . ' term=bold cterm=bold ctermfg=' . row . ' ctermbg=' . col)
    endfor
  endfor
endfun!

au BufNewFile,BufRead * call SetJoshColors()

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

command! -nargs=+ Match call Match(<f-args>)
command! NoMatches call clearmatches()
function! Match(...)
  if ! exists('g:match_color_index')
    let g:match_color_index = 0
  endif

  let index = 0
  let g:match_highlight_groups = {}
  let group_names = []
  for row in [3, 7, 9, 10, 11, 13, 14, 15]
    for col in [0, 1, 4, 5, 8]
      let index = index + 1

      let group_name = printf('Josh%03d', index)
      call insert(group_names, group_name, len(group_names))

      let g:match_highlight_groups[group_name] = [row, col]
      exe('highlight clear ' . group_name)
      exe('hi ' . group_name . ' term=bold cterm=bold ctermfg=' . col . ' ctermbg=' . row)

      let group_name = printf('Josh%03d', index + 40)
      call insert(group_names, group_name, len(group_names))

      let g:match_highlight_groups[group_name] = [col, row]
      exe('highlight clear ' . group_name)
      exe('hi ' . group_name . ' term=bold cterm=bold ctermfg=' . row . ' ctermbg=' . col)
    endfor
  endfor

  let g:match_color_index = (g:match_color_index + 1) % len(group_names)
  let group_name = group_names[g:match_color_index]

  for pat in a:000
    let pat = substitute(pat, '^/*', '', '')
    let pat = substitute(pat, '/*$', '', '')
    call matchadd(group_name, pat)
  endfor
endfunction
cabbrev mat Match
ca nomat NoMatches

fu! PrintReg(id)
  echom substitute(getreg(a:id), '\_\s*$', '', '')
endfu
fu! GetReg(id)
  return substitute(getreg(a:id), '\_\s*$', '', '')
endfu
command! -nargs=1 PrintReg call PrintReg(<q-args>)
command! -nargs=1 ShowReg call PrintReg(<q-args>)
command! -nargs=1 GetReg call GetReg(<q-args>)
cabbrev prreg PrintReg
cabbrev printreg PrintReg
cabbrev showreg PrintReg
cabbrev regval PrintReg
cabbrev regvalue PrintReg
cabbrev getreg GetReg

function! Scratch(...)
  let dest = expand('$HOME') . '/' . 'scratch'
  if ! isdirectory(dest)
    call mkdir(dest, 'p')
  endif

  if a:0 > 0
    for file in a:000
      exe('vs ' . dest . '/' . file)
    endfor
  else
    let file = strftime('%Y%m%d%H%M%S') . '.md'
    exe('vs ' . dest . '/' . file)
  endif
endfunction
command! -nargs=* Scratch call Scratch(<f-args>)

command! -complete=shellcmd -complete=file -complete=dir -nargs=* Todo call Todo(<q-args>)
function! Todo(...)
  let dest = expand('$HOME') . '/' . 'todo/'
  let fdest = dest
  if ! isdirectory(dest)
    call mkdir(dest, 'p')
  endif

  echom string([a:0, a:000])
  if a:0 > 0
    for name in a:000
      if name == ''
        let name = 'todo.md'
      endif
      let name = substitute(name, '\([.]md\)\?$', '.md', '')
      if match(name,'/') != -1
        let extradir = substitute(name, '/\+[^/]*$', '/', '')
        let fdest = dest . extradir
      endif
      if ! isdirectory(fdest)
        call mkdir(fdest, 'p')
      endif
      exe('vs ' . dest . name)
    endfor
  endif
endfunction
cabbrev todo Todo

command! -complete=shellcmd -complete=file -complete=dir -nargs=+ CaptureOutput call CaptureOutput(<q-args>)
function! CaptureOutput(cmd)
  redir => capturedoutput
  silent execute a:cmd
  redir END
  silent put=capturedoutput
endfunction

function! Mkdir()
  let path = expand("%:p:h")
  if len(glob(path)) == 0
    echo "Making directory: " . path . " it doesn't exist."
    call mkdir(path, "p")
  else
    echo "Directory already exists..."
  endif
endfunction


" Zoom / Restore window.
function! s:ZoomBuffer() abort
  let t:zoom_winrestcmd = winrestcmd()
  resize
  vertical resize
  let t:zoomed = 1
endfunction

function! s:UnZoomBuffer() abort
  if exists('t:zoom_winrestcmd')
    execute t:zoom_winrestcmd
  endif
  let t:zoomed = 0
endfunction

function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
      call s:UnZoomBuffer()
    else
      call s:ZoomBuffer()
    endif
endfunction

command! ZoomToggle call s:ZoomToggle()
command! UnZoomBuffer call s:UnZoomBuffer()
nnoremap <silent> <Space>z :ZoomToggle<CR>
nnoremap <silent> <Space>Z :UnZoomBuffer<CR>

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap ,z :call SynStack()<CR>





"""""" HERO FILE


    function! ChRole(fromname,toname) range
      let split_from_name = split(a:fromname, '.\@<=[A-Z]\@=')
      let joined_from_name = tolower(join(split_from_name, '_'))
      let split_to_name = split(a:toname, '.\@<=[A-Z]\@=')
      let joined_to_name = tolower(join(split_to_name, '_'))
      exe(a:firstline . ',' . a:lastline . 's/' . a:fromname . '/' . a:toname . '/gce')
      exe(a:firstline . ',' . a:lastline . 's/' . joined_from_name . '/' . joined_to_name . '/gce')
    endfunction
    command! -range -nargs=+ ChangeUserRole <line1>,<line2>call ChRole(<f-args>)
    cabbrev chrole ChangeUserRole

    command! -range -nargs=0 HeroNoteSave <line1>,<line2>call NoteSave(<f-args>)
    function! NoteSave() range
      let stamp=strftime("%Y%m%d%H%M%S")
      exe a:firstline . "," . a:lastline . "!note save"
    endfunction

    command! -nargs=+ LocalVsOldfile call LocalVsplitMatchingOldfilePartialFilename(<f-args>)
    function! LocalVsplitMatchingOldfilePartialFilename(pattern, ...)
      echom 'CHECKING a:pattern => "' . a:pattern . '"'
      if(exists('a:1'))
        echom 'CHECKING a:1  => "' . a:1  . '"'
      endif

      let matching_files = []

      for the_oldfile in v:oldfiles
        if( match(glob(the_oldfile), '^' . glob(getcwd())) == -1)
          continue
        endif

        if( match(the_oldfile, a:pattern) != -1 )
          call add(matching_files, the_oldfile)
        endif
      endfor

      if(len(matching_files) > 4)
        echom 'THE LENGTH OF matching_files is => ' . len(matching_files)
        echom 'List of matching files:'
        for ofile in matching_files
          echom '  ' . ofile
        endfor
        echom 'Do you want to open all of the following files into splits?'
        let openall_answer = inputlist(['1. Yes', '2. No'])
        if(openall_answer == 1)
          for matching_file in matching_files
            if(exists('a:1') && len(a:1) > 0)
              echom '[DRY RUN] would have executed: => vs "' . matching_file . '"'
            else
              echom 'running command => vs "' . matching_file . '"'
              exe('vs ' . matching_file)
            endif
          endfor
        endif
      elseif(len(matching_files) >= 1)
        for matching_file in matching_files
          if(exists('a:1') && len(a:1) > 0)
            echom '[DRY RUN] would have executed: => vs "' . matching_file . '"'
          else
            echom 'running command => vs "' . matching_file . '"'
            exe('vs ' . matching_file)
          endif
        endfor
      else
        return -1
      endif
    endfunction
    cabbrev lvf LocalVsOldfile

    command! -nargs=+ VsOldfile call VsplitMatchingOldfilePartialFilename(<f-args>)
    function! VsplitMatchingOldfilePartialFilename(...)
      echom 'argcount (a:count) => "' . a:0 . '"'
      echom 'all extra args => '
      let i = 0
      for earg in a:000
        let i = i + 1
        echom '  ' . i . ': '. '"' . earg . '"'
      endfor

      let matching_files = []
      let add_the_file = 1

      for the_oldfile in v:oldfiles
        let add_the_file = 1

        for pat in a:000
          if( add_the_file == 1 )
            if( match(the_oldfile, pat) == -1 )
              let add_the_file = 0
            endif
          endif
        endfor

        if( add_the_file == 1 )
          call add(matching_files, the_oldfile)
        endif
      endfor

      if(len(matching_files) > 4)
        echom 'THE LENGTH OF matching_files is => ' . len(matching_files)
        echom 'List of matching files:'
        for ofile in matching_files
          echom '  ' . ofile
        endfor
        echom 'Do you want to open all of the following files into splits?'
        let openall_answer = inputlist(['1. Yes', '2. No'])
        if(openall_answer == 1)
          for matching_file in matching_files
            echom 'running command => vs "' . matching_file . '"'
            exe('vs ' . matching_file)
          endfor
        endif
      elseif(len(matching_files) >= 1)
        for matching_file in matching_files
          echom 'running command => vs "' . matching_file . '"'
          exe('vs ' . matching_file)
        endfor
      else
        return -1
      endif
    endfunction
    cabbrev vf VsOldfile

    cabbrev safeil <c-r>=system('ilstart ' . expand('%'))<cr>,$il!/<C-r>=Eatchar('\s')<cr>

"""""" END HERO FILE

function! s:IListPrompt(pattern)
  let pat = a:pattern
  if strlen(pat) > 0
    if matchstr(pat, "^/") != "/"
      let pat="/" . pat
    endif
    if matchstr(pat, "/$") != "/"
      let pat = pat . "/"
    endif
    let v:errmsg = ""
    exe "ilist! " . pat
    if strlen(v:errmsg) == 0
      let nr = input("Which one: ")
      if nr =~ '\d\+'
        exe "ijump! " . nr . pat
      endif
    endif
  endif
endfunction "tagsrch.txt:673

command! -nargs=+ IListPrompt call <SID>IListPrompt(<q-args>)
ca ilp IListPrompt

colorscheme monokai
" set background=light

hi! link linenr conditional

ca struct <c-r>=system('ilstart ' . expand('%'))<cr>,$il!/<C-r>=Eatchar('\s')<cr>\v<(class\|module\|def\|private\|protected)<space>

function! RunTests(...)
  let in_test_file = match(expand("%"), '_spec.rb\(:\d\d*\)*$') != -1

  if in_test_file
    let t:hero_rspec_file = expand("%")
    let t:hero_rspec_line = line('.')
  end

  if !exists("t:hero_rspec_file")
    return
  end

  let cmd=':silent' . ' '

  if exists(':Dispatch')
    let cmd .= 'Dispatch bundle exec rspec' . ' ' . t:hero_rspec_file
  elseif exists('~/bin/beatest')
    let cmd .= '!' . expand('~/bin/beatest') . ' ' . t:hero_rspec_file
  else
    let cmd .= '!bundle exec rspec' . ' ' . t:hero_rspec_file
  endif

  if a:0
    let cmd .= ':' . t:hero_rspec_line
  endif

  echom "Running Tests Using: " . cmd

  exe(cmd)

endfunction

let mapleader=' '

nm <leader>so<leader> :so %<cr>

map Q gq

nm <c-j> <c-e>
nm <c-k> <c-y>

" Mappings that resemble their :command-mode commands:
" ----------------------------------------------------

nm <leader>bn :bn<cr>
nm <leader>bp :bp<cr>
nm <leader>bf :bf<cr>
nm <leader>bl :bl<cr>
nm <leader>so :so %<cr>
nm <leader>bn :bn<cr>
nm <leader>bn :bn<cr>
nm <leader>bn :bn<cr>
nm <leader>bn :bn<cr>

nnoremap <leader>te :tabe<space>
nnoremap <leader>Te :tabe<space><c-r>=expand('%:h')<cr>/
nnoremap <leader>tE :tabe<space><c-r>=expand('%:h')<cr>/
nnoremap <leader>tn :tabn<cr>
nnoremap <leader>tp :tabp<cr>


" Other Mappings
" --------------

nnoremap gf :vs <cfile><CR>
nnoremap  :vert stjump<CR>
vnoremap < <gv  " visual shifting (does not exit Visual mode)
vnoremap > >gv
nnoremap > >>
nnoremap < <<
nnoremap j gj
nnoremap k gk
nnoremap K kJ

nnoremap ,x yyp!!bash<cr>
vnoremap ,x "xyO<esc>mmgv!bash<cr>`mP

nnoremap ,r yyp!!ruby<cr>
vnoremap ,r "xyO<esc>mmgv!ruby<cr>`mP

nnoremap ,c :vert wincmd <C-]><CR>
" nnoremap ,s :w\|!git add %;git commit -m 'autocommitting %'<cr>
nnoremap ,s :w\|!cd "<c-r>=expand('%:h')<cr>"; git add "<c-r>=expand('%:t')<cr>"; git commit -m "autocommitting <c-r>=expand('%:t')<cr>"<cr>
nnoremap ,q :wqa<cr>
nnoremap ,gst :!git status -s<cr>
nnoremap ,gd :!git diff<cr>

" inspired by vim-unimpaired

nmap coB :set buftype=<cr>
nmap coL :set cursorline!<cr>
nmap cob :set buftype=<c-r>=&buftype == 'nofile' ? '' : 'nofile'<cr><cr>
nmap cog :set gdefault!<cr>
nmap coh :set hlsearch!<cr>
nmap col :set list!<cr>
nmap com :set modifiable!<cr>
nmap con :set number!<cr>
nmap cop :set paste!<cr>
nmap cor :set readonly!<cr>
nmap cow :set wrap!<cr>

" Bash/Shell Commands use ',' (comma) as <leader>
let mapleader=','

" OLD -- IGNORE THESE
" # !!! nnoremap <leader>f :call RunTests()<cr>
" # !!! nnoremap <leader>l :call RunTests(1)<cr>

nnoremap <leader>p :!pwd<cr>
nnoremap <leader>pwd :!pwd<cr>
nnoremap <leader>cwd :!pwd<cr>
nnoremap <leader>ls :!ls -AFG <C-r>=expand('%:p:h').'/'<cr><cr>
nnoremap <leader>Ls :!ls -AFG<Space>
nnoremap <leader>ll :!ls -AFGl <C-r>=expand('%:p:h').'/'<cr><cr>
nnoremap <leader>Ll :!ls -AFGl<Space>
nnoremap <leader>ld :!ls -AGd <C-r>=expand('%:p:h').'/'<cr>*/<cr>
nnoremap <leader>Ld :!ls -AGd <C-r>=expand('%:p:h').'/'<cr>*/<Space>
nnoremap <leader>lld :!ls -AGld <C-r>=expand('%:p:h').'/'<cr>*/<cr>
nnoremap <leader>Lld :!ls -AGld <C-r>=expand('%:p:h').'/'<cr>*/<Space>
nnoremap <leader>mkdir :!mkdir -pv<Space>
nnoremap <leader>mdir :!mkdir -pv<Space>

" --------------
" <Nul> Mappings
" --------------
" <Nul> == <C-Space>
"
" (in the cmd editor: "<C-k><C-Space>" == "<Nul>"

"" normal mode
nnoremap <Nul>x :!<c-r>=expand('%:p')<cr><cr>
nnoremap <Nul>r :source <c-r>=expand('$HOME')<cr>/.vimrc<cr>
nnoremap <Nul>s :source <c-r>=expand('%')<cr><cr>

" call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <Nul>e :<C-u>Unite -start-insert file_rec<CR>

nnoremap <Nul>lc :vnew +r!ls\ -CAFG\ %:p:h/<cr>'[
nnoremap <Nul>ls :vnew +r!ls\ -1AFG\ %:p:h/<cr>'[
nnoremap <Nul>ll :vnew +r!ls\ -lAFG\ %:p:h/<cr>'[
nnoremap <Nul>ld :vnew +r!find\ <c-r>=expand('%:p:h')<cr>\ -maxdepth\ 1\ -type\ d<cr>'[
nnoremap <Nul>md :!mkdir -pv %:h<cr>
nnoremap <Nul>- v$r-
nnoremap <Nul>t :!h list add<Space>

"" command mode

cabbrev Rh <c-r>=expand('$HOME')<cr>/<c-r>=Eatchar('\_\s')<cr>
cabbrev Rsv app/views/shared/<c-r>=Eatchar('\_\s')<cr>
cabbrev Rc app/controllers/<c-r>=Eatchar('\_\s')<cr>
cabbrev Rv app/views/<c-r>=Eatchar('\_\s')<cr>
cabbrev Rm app/models/<c-r>=Eatchar('\_\s')<cr>
cabbrev Rd db/migrate/<c-r>=Eatchar('\_\s')<cr>
cabbrev Rr config/routes.rb

cabbrev Jh <c-r>=expand('$HOME')<cr>/<c-r>=Eatchar('\_\s')<cr>
cabbrev Jsv app/views/shared/<c-r>=Eatchar('\_\s')<cr>
cabbrev Jc app/controllers/<c-r>=Eatchar('\_\s')<cr>
cabbrev Jv app/views/<c-r>=Eatchar('\_\s')<cr>
cabbrev Jm app/models/<c-r>=Eatchar('\_\s')<cr>
cabbrev Jd db/migrate/<c-r>=Eatchar('\_\s')<cr>
cabbrev Jr config/routes.rb<c-r>=Eatchar('\_\s')<cr>





fun! RbChomp(str)
  return substitute(a:str, '\_\s*$', '', '')
endfun

fun! UserSelectsFromList(items)
  if type(a:items) == v:t_list
    let list = extend(['Select color:'], a:items)
  else
    let list = add(['Select color:'], a:items)
  endif
  let answer = inputlist(list)
  echom
  echom 'user selected: ' . string(answer)
  return answer
endfun




" -------------------------
" Git - Common Git Commands
" -------------------------

nnoremap <leader>gst :!git status -s<cr>
nnoremap <leader>Gst :!git status -s<Space>
nnoremap <leader>gss :!git status -s \| sed 's/...//;s/.* -> //'<cr>
nnoremap <leader>Gss :!git status -s \| sed 's/...//;s/.* -> //'<Space>
nnoremap <leader>gaf :!git add %<cr>
nnoremap <leader>Gaf :!git status -s<cr>:!git add --all<Space>
nnoremap <leader>gaa :!git add --all<cr>
nnoremap <leader>Gaa :!git add --all<Space>
nnoremap <leader>gai :!git add -i<cr>
nnoremap <leader>Gai :!git add -i<Space>
nnoremap <leader>gc :!git commit -m ""<Left>
nnoremap <leader>gb :!git branch<cr>
nnoremap <leader>Gb :!git branch<Space>
nnoremap <leader>gd :!git diff<cr>
nnoremap <leader>Gd :!git diff<Space>
nnoremap <leader>gdf :!git diff %<cr>
nnoremap <leader>Gdf :!git diff %<Space>
nnoremap <leader>gdt :!git diff %<cr>
nnoremap <leader>Gdt :!git diff %<Space>
nnoremap <leader>gdc :!git diff --cached<cr>
nnoremap <leader>Gdc :!git diff --cached<Space>
nnoremap <leader>gbr :!git branch -r<cr>
nnoremap <leader>Gbr :!git branch -r<Space>
nnoremap <leader>gr :!git remote<cr>
nnoremap <leader>Gr :!git remote<Space>
nnoremap <leader>grv :!git remote -v<cr>
nnoremap <leader>Grv :!git remote -v<Space>
nnoremap <leader>glod :!git log --oneline --decorate<cr>
nnoremap <leader>Glod :!git log --oneline --decorate<Space>
nnoremap <leader>glog :!git log --oneline --decorate --name-status<cr>
nnoremap <leader>Glog :!git log --oneline --decorate --name-status<Space>
nnoremap <leader>gllr :!git log --oneline --decorate --left-right<Space>
nnoremap <leader>Gllr :!git log --oneline --decorate --left-right<Space>
nnoremap <leader>gpH :!git push origin HEAD<cr>
nnoremap <leader>GpH :!git push origin HEAD<Space>
nnoremap <leader>gpo :!git push origin master<cr>
nnoremap <leader>Gpo :!git push origin master<Space>
nnoremap <leader>gph :!git push heroku HEAD:master<cr>
nnoremap <leader>Gph :!git push heroku HEAD:master<Space>

" TODO: CHECK LATER
" nnoremap <leader>gs  :!git status -s<cr>

" nnoremap <leader>gd  :!git diff %
" nnoremap <leader>gD  :!git diff %<cr>

" nnoremap <leader>ga  :!git add %
" nnoremap <leader>gA  :!git add %<cr>
" nnoremap <leader>gc  :!git commit -m ''<left>

" nnoremap <leader>gb  :!git branch<cr>
" nnoremap <leader>grb  :!git branch -r<cr>
" TODO: END TODO

" VIM Ex/Command-mode Commands use <Space> as <leader>
let mapleader=' '

nnoremap <leader><leader> :
vnoremap <leader><leader> :
nnoremap <leader>; :
vnoremap <leader>; :

nnoremap <leader>1 :!
nnoremap <leader>2 :exe('norm yyp[ ] ')<cr>!!bash
nnoremap <leader>3 :%!bash
nnoremap <leader>5 :%
nnoremap <leader>% :%

vnoremap <leader>1 !
vnoremap <leader>2 !bash
vnoremap <leader>3 !bash
vnoremap <leader>5 :w !bash

nnoremap <leader>h2 :exe('norm yyp[ ] ')<cr>!!bash<cr>z<cr><C-y><C-y><C-y>
nnoremap <leader>h3 :%!bash<cr>
nnoremap <leader>h5 :%w !bash<cr>

vnoremap <leader>h2 !bash<cr>
vnoremap <leader>h3 !bash<cr>

vnoremap <leader>1 !

nnoremap <leader>f; q:
vnoremap <leader>f; q:
nnoremap <leader>f: q:
vnoremap <leader>f: q:

nnoremap <leader>c :w ~/pbcopy \| :!open ~/pbcopy<cr>
vnoremap <leader>c :w ~/pbcopy \| :!open ~/pbcopy<cr>
nnoremap <leader>C :.w ~/pbcopy \| :!open ~/pbcopy<cr>

nnoremap <leader>x :%w !
vnoremap <leader>x :w !
nnoremap <leader>X :.w !

nnoremap <leader>hx :%!bash<cr>
vnoremap <leader>hx !bash<cr>
nnoremap <leader>hX :.!bash<cr>

nm <leader>k :set mp?<cr>
nm <leader>gk :set mp=''<Left>
nm <leader>K :make<cr>

nm <leader>r :!rspec <C-r>%<cr>
nm <leader>R :!rspec <C-r>%:<C-r>=line('.')<cr><cr>

" nm <leader>m :exe('s/^\s*#\s*\zs\ze/\r/e \| yank p \| undo \| norm @p')<cr>
" nm <leader>hv :exe('s/^\s*#\s*\zs\ze/\r/e \| yank p \| norm @p')<cr>
" nm <leader>hV :exe('s/^\s*#\s*\zs\ze/\r/e \| yank p \| vnew \| set buftype=nofile \| norm @p')<cr>
nm <leader>hv :exe('y \| put \| s/^\(\s#\)*\s*//e \| d z \| norm @z')<cr>
nm <leader>hV :exe('y \| put \| s/^\(\s#\)*\s*//e \| d z \| vnew \| set buftype=nofile \| norm @z')<cr>

nm <leader>hb :exe('s/^\s*#\s*\zs\ze/\r/e \| yank p \| undo \| put p \| .!bash')<cr>
" nm <leader>hbb :exe('s/^\s*#\s*\zs\ze/\r/e \| yank p \| undo \| put p \| .!bash')<cr>
" nm <leader>hbw :exe('s/^\s*#\s*\zs\ze/\r/e \| yank p \| undo \| put p \| .!bash')<cr>

nm <leader>hB :exe('s/^\s*#\s*\zs\ze/\r/e \| yank p \| undo \| vnew \| set buftype=nofile \| 1put p \| 1d \| 1!bash')<cr>
" nm <leader>hbv :exe('s/^\s*#\s*\zs\ze/\r/e \| yank p \| undo \| vnew \| put p \| .!bash \| set buftype=nofile')<cr>
" nm <leader>hbp :exe('s/^\s*#\s*\zs\ze/\r/e \| yank p \| undo \| vnew \| put p \| .!bash \| set buftype=nofile')<cr>

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>
nnoremap <leader>e :e<space>
nnoremap <leader>s :sp<space>
nnoremap <leader>v :vs<space>
nnoremap <leader>E :e<space><c-r>=expand('%:h')<cr>/
nnoremap <leader>S :sp<space><c-r>=expand('%:h')<cr>/
nnoremap <leader>V :vs<space><c-r>=expand('%:h')<cr>/

nnoremap <leader>a :!ag ''<left>


" overwrite <leader>l from rspec.vim
nnoremap <leader>l  :ls<cr>
nnoremap <leader>ls  :ls<cr>
nnoremap <leader>b  :ls<cr>:b<space>

" Hero: Jump To Next Git Conflict

nnoremap <leader>hgc  :exe('/^[<>=]\{7}/')<cr>
nnoremap <leader>hgC  :exe('?^[<>=]\{7}?')<cr>


    " Key mappings

    "" Normal Mode

    nmap gf :vert wincmd f<CR>
    nmap gF :vert wincmd F<CR>


    " set mapleader to space

    let mapleader=' '

    " Hero: Jump To Next Git Conflict

    nnoremap <leader>hgc  :exe('/^[<>=]\{7}/')<cr>
    nnoremap <leader>hgC  :exe('?^[<>=]\{7}?')<cr>

    " hero

    " Hero Notes

    "" Open a note from the timestamp only

    nm <leader>hon :vs ~/hero/notes/.index/<cword>.hdoc<cr>

    "" Open a bg window for importing a bunch of notes

    nnoremap <leader>ni  :!tbg 'note import'<cr>
    nnoremap <leader>hni :!tbg 'note import'<cr>

    nnoremap <leader>ns :HeroNoteSave<cr>
    vnoremap <leader>ns :HeroNoteSave<cr>

    nnoremap <leader>hns :HeroNoteSave<cr>
    vnoremap <leader>hns :HeroNoteSave<cr>

    nnoremap <leader>hns :HeroNoteSave<cr>
    vnoremap <leader>hns :<c-u>'<,'>HeroNoteSave<cr>

    nnoremap <leader>hnd o--- next note ---<cr>

    nnoremap <leader>hncp o #hero #h #todo #projectfile<esc>0i
    nnoremap <leader>hncn o #hero #todo #notes<esc>0i

    nnoremap <leader>hno mm$F'vi'"fy`m:e <c-r>f<cr>
    nnoremap <leader>hne mm$F'vi'"fy`m:e <c-r>f<cr>
    nnoremap <leader>hnh mm$F'vi'"fy`m:sp <c-r>f<cr>
    " nnoremap <leader>hnv :norm $vT "iy0:vs <c-r>i<cr>
    nnoremap <leader>hnv mm$F'vi'"fy`m:vs <c-r>f<cr>

    let mapleader=' '







cabbrev sothis source <c-r>=expand('%')<cr>

hi diffAdded term=bold cterm=bold ctermbg=35 ctermfg=0
hi diffRemoved term=bold cterm=bold ctermbg=124 ctermfg=15
" packadd! matchit





" Useful Functions
" Extract into a separate lib or plugin later
" and maybe even publish it online



 function! MatchingLnums(pattern)
   let lnums = []
   let sline = 0
   while 1
     call cursor(sline + 1, 1)
     let lnum = search(a:pattern,'zW')

     if lnum > sline
       call insert(lnums, lnum, len(lnums))
     else
       break
     endif

     let sline = lnum
   endwhile

   return lnums
 endfunction


function! ReplaceWithLineNum(ptrn) range
  echom printf('a:firstline: "%s"', a:firstline)
  echom printf('a:lastline: "%s"', a:lastline)
  let [cline, offset] = [line('.'), a:firstline - 1]
  echom printf('cline: "%s"', cline)
  echom printf('offset: "%s"', offset)
  for num in range(a:firstline,a:lastline)
    call setline(num, substitute(getline(num), a:ptrn, num-offset, 'g'))
  endfor
endfunction

function! FlipMatrix(arr,...)
  for idx in range(0,a:0 - 1)
    if ! exists("arr[idx]")
      call add(a:arr, [])
      " let a:arr[idx] = []
    endif
    call add(a:arr[idx], a:000[idx])
  endfor
  return a:arr
endfunction

function! PrintVVars()
  let columns = []
  let columns = FlipMatrix(columns, 'v:beval_bufnr',       'v:ctype',             'v:foldend',           'v:null',              'v:shell_error',       'v:t_string'        )
  let columns = FlipMatrix(columns, 'v:beval_col',         'v:dying',             'v:foldlevel',         'v:oldfiles',          'v:statusmsg',         'v:termresponse'    )
  let columns = FlipMatrix(columns, 'v:beval_lnum',        'v:errmsg',            'v:foldstart',         'v:operator',          'v:swapchoice',        'v:testing'         )
  let columns = FlipMatrix(columns, 'v:beval_text',        'v:errors',            'v:hlsearch',          'v:option_new',        'v:swapcommand',       'v:this_session'    )
  let columns = FlipMatrix(columns, 'v:beval_winid',       'v:exception',         'v:insertmode',        'v:option_old',        'v:swapname',          'v:throwpoint'      )
  let columns = FlipMatrix(columns, 'v:beval_winnr',       'v:false',             'v:key',               'v:option_type',       'v:t_bool',            'v:true'            )
  let columns = FlipMatrix(columns, 'v:char',              'v:fcs_choice',        'v:lang',              'v:prevcount',         'v:t_channel',         'v:val'             )
  let columns = FlipMatrix(columns, 'v:charconvert_from',  'v:fcs_reason',        'v:lc_time',           'v:profiling',         'v:t_dict',            'v:version'         )
  let columns = FlipMatrix(columns, 'v:charconvert_to',    'v:fname',             'v:lnum',              'v:progname',          'v:t_float',           'v:vim_did_enter'   )
  let columns = FlipMatrix(columns, 'v:cmdarg',            'v:fname_diff',        'v:mouse_col',         'v:progpath',          'v:t_func',            'v:warningmsg'      )
  let columns = FlipMatrix(columns, 'v:cmdbang',           'v:fname_in',          'v:mouse_lnum',        'v:register',          'v:t_job',             'v:windowid'        )
  let columns = FlipMatrix(columns, 'v:completed_item',    'v:fname_new',         'v:mouse_win',         'v:scrollstart',       'v:t_list'                                 )
  let columns = FlipMatrix(columns, 'v:count',             'v:fname_out',         'v:mouse_winid',       'v:searchforward',     'v:t_none'                                 )
  let columns = FlipMatrix(columns, 'v:count1',            'v:folddashes',        'v:none',              'v:servername',        'v:t_number'                               )
  let list = []
  let list = extend(list, columns[0])
  let list = extend(list, columns[1])
  let list = extend(list, columns[2])
  let list = extend(list, columns[3])
  let list = extend(list, columns[4])
  let list = extend(list, columns[5])
  for item in list
    exe('echom "' . item . ' => " . string(' . item . ')')
  endfor
endfunction


" call PrintVVars()

fun! RunIfExecutable(...)
  if match(getfperm(expand('%')),'x') != -1
    system(expand('%:p'))
  else
    system('chmod +x ' . expand('%:p'))
    if match(getfperm(expand('%')),'x') != -1
      system(expand('%:p'))
    else
      system('sudo chmod +x ' . expand('%:p'))
      system(expand('%:p'))
    endif
  endif
endfun

fun! PwdFzf(vimcmd,...)
  try
    if finddir('.git','.;')
      let file = system('git ls-files | selecta')
    else
      let file = system('find .* * -type f | selecta')
    endif
  catch /Vim:Interrupt/
    redraw!
    return
  endtry

  redraw!
  exec a:vimcmd . ' ' . file
endfun

command! -nargs=* Pfzf call PwdFzf(<f-args>)
cabbrev vf Pfzf vs
cabbrev sf Pfzf sp
cabbrev ef Pfzf e

fun! FileFzf(...)
  try
    if a:0 == 0
      let file = system('find .* * -type f | selecta')
    else
      let expanded = []
      for dir in a:000
        call add(expanded, expand(dir))
      endfor
      let file = system('find ' . join(expanded, ' ') . ' -type f | selecta')
    end
  catch /Vim:Interrupt/
    redraw!
    return
  endtry

  redraw!
  return RbChomp(file)
endfun

command! -nargs=* FileFzf call FileFzf(<q-args>)
cnoremap <Nul>ff <c-r>=FileFzf()<cr>
cnoremap <Nul>Ff <c-r>=FileFzf(
cnoremap <Nul>fF <c-r>=FileFzf(

fun! DirFzf(...)
  try
    if a:0 == 0
      let file = system('find .* * -type d | selecta')
    else
      let file = system('find ' . join(a:000, ' ') . ' -type d | selecta')
    end
  catch /Vim:Interrupt/
    redraw!
    return
  endtry

  redraw!
  return RbChomp(file)
endfun

command! -nargs=* DirFzf call DirFzf(<q-args>)
cnoremap <Nul>fd ('call DirFzf()')<cr>

fun! GstFilter(...)
  if a:0 == 0
    echom 'hi'
    for f in systemlist('git status -s | sed "s/...//;s/.* -> //"')
      echom f
    endfor
  else
    echom 'hielse'
    echom string(a:000)
    let filterstr = []
    for ptrn in a:000
      call add(filterstr, 'v:val =~ ' . string(ptrn))
    endfor
    let fltr = join(filterstr, ' || ')
    let list = filter(systemlist('git status -s | sed "s/...//;s/.* -> //"'), fltr)
    for f in list
      echom f
    endfor
  endif
endfun

command! -nargs=* Gss call GstFilter(<f-args>)
cabbrev gss <c-u>Gss

fun! CmdList(cmd)
  return systemlist(a:cmd)
endfun

command! -nargs=* Clist call CmdList(<args>)
cabbrev clist <c-u>Clist

fun! ArgList(cmd,...)
  let list = a:cmd
  if type(list) != v:t_list
    let list = systemlist(list)
  else
    let fltrs = []
    if a:0 > 0
      for fltr in fltrs
        call add(fltrs, 'v:val =~ ' . string(fltr))
      endfor
      let list = filter(list, join(fltrs, ' || '))
    endif
  endif
  return join(list, ' ')
endfun

command! -nargs=* Alist call ArgList(<args>)
cabbrev alist <c-u>Alist

fun! PrintList(cmd,...)
  let list = a:cmd
  if type(list) != v:t_list
    let list = systemlist(list)
  else
    let fltrs = []
    echom string(a:000)
    if a:0 > 0
      for fltr in a:000
        call add(fltrs, 'v:val =~ ' . string(fltr))
      endfor
      let list = filter(list, join(fltrs, ' || '))
    endif
  endif
  echom 'vvvv Printing List: vvvv'
  for ln in list
    echom ln
  endfor
  return list
endfun

command! -nargs=* Plist call PrintList(<args>)
cabbrev plist <c-u>Plist

fun! LConcat(...)
  let clist = []
  for lst in a:000
    if type(lst) != v:t_list
      let clist = extend(clist, [lst])
    else
      let clist = extend(clist, lst)
    endif
  endfor

  return clist
endfun


nnoremap <Nul>v :source! ~/vim_source_file.vim<CR>



fun! CmdFzf(cmd)
  try
    let file = system(a:cmd . ' | selecta')
  catch /Vim:Interrupt/
    redraw!
    return
  endtry

  redraw!
  return RbChomp(file)
endfun

command! -nargs=1 Cfz call CmdFzf(<q-args>)
cabbrev cf <c-r>=CmdFzf('')<left><Left><c-r>=Eatchar('\s')<cr>

fun! CompletionList(ptrn,type)
  return getcompletion(a:ptrn, a:type)
endfun

fun! Pfun(cmd)
  execute 'vnew +0put=a:cmd'
  silent norm cob
endfun
command! -nargs=1 Pfun call Pfun(<q-args>)
cabbrev pfun Pfun
cabbrev pexp Pfun
cabbrev pexpr Pfun
cabbrev p= Pfun

fun! Pcmd(cmd)
  execute "vnew +0put=execute(" . EscapeCmd(a:cmd,'space','string') . ")"
  silent norm cob
endfun
command! -nargs=1 Pcmd call Pcmd(<q-args>)
cabbrev pcmd Pcmd
cabbrev p: Pcmd

fun! Pvim(vim)
  " let svim = EscapeCmd(a:vim,'space')
  execute 'vnew +0put=' . a:vim
  silent norm cob
endfun
command! -nargs=1 Pvim call Pvim(<q-args>)
cabbrev pvim Pvim
cabbrev P: Pvim

fun! Pexe(exe)
  let sexe = EscapeCmd(a:exe,'string')
  execute 'vnew +0put=execute(' . sexe . ')'
  silent norm cob
endfun
command! -nargs=1 Pexe call Pexe(<q-args>)
cabbrev pex Pexe
cabbrev pexe Pexe

fun! EscapeCmd(str,...)
  let nstr = a:str
  for esc in a:000
    if esc =~? 'str\%[ing]' || esc =~? '[sd]\?quote'
      let nstr = string(nstr)
    end
    if esc == 'space'
      let nstr = substitute(nstr, '\s', '\\&', 'g')
    end
  endfor
  return nstr
endfun

fun! Psh(cmd)
  execute "vnew"
  execute "0put=" . string('ESC_CMD $> ') . ' . ' . EscapeCmd(a:cmd,'space','string')
  execute "put=system(" . EscapeCmd(a:cmd,'string') . ")"
  execute "1"
  silent norm cob
endfun
command! -nargs=1 Psh call Psh(<q-args>)
cabbrev psh Psh
cabbrev p! Psh

fun! LsComp(ptrn,type)
  execute 'vnew +0put=getcompletion(a:ptrn,a:type)'
  silent norm cob
endfun
command! -nargs=+ Lsc call LsComp(<f-args>)
cabbrev lsc Lsc

fun! LsCompTypes()
  let comp_types = [
        \ "augroup","buffer","behave","color","command","compiler","cscope","dir",
        \ "environment","event","expression","file","file_in_path","filetype","function","help",
        \ "highlight","history","locale","mapping","menu","messages","option","packadd",
        \ "shellcmd","sign","syntax","syntime","tag","tag_listfiles","user","var"
        \ ]
  let d = len(comp_types) / 4
  let maxlen = max(map(copy(comp_types), {k,v -> len(v)}))

  echom 'maxlen => ' . maxlen
  for row in range(0,d-1)
    let line = []
    for col in range(0,3)
      let line = extend(line, [printf('  %-' . maxlen . 's  ', comp_types[row + (col * d)])])
    endfor
    echo join(line, ' ')
  endfor
endfun
command! -nargs=0 LscTypes call LsCompTypes()
cabbrev lsct LscTypes
cabbrev lsctypes LscTypes

fun! VarType(var)
  let vtypes = [ 'number' , 'string' , 'func' , 'list' , 'dict' , 'float' , 'bool' , 'none' , 'job' , 'channel' ]
  echo vtypes[type(a:var)]
  return vtypes[type(a:var)]
endfun
command! -nargs=1 VarType call VarType(<args>)
cabbrev vtype VarType
cabbrev vartype VarType
cabbrev gettype VarType

fun! LsHelpComp(ptrn)
  call LsComp(a:ptrn,'help')
endfun
command! -nargs=+ Lshelp call LsHelpComp(<f-args>)
cabbrev lsh Lshelp
cabbrev lshelp Lshelp
cabbrev hsearch Lshelp

" fun! HelpSearch(ptrn,...)
"   call LsComp(a:ptrn,'help')
" endfun
"
" fun! HelpFunSearch(ptrn)
"   call HelpSearch(a:ptrn . '()')
" end
"
" command! -nargs=+ Hsearch call HelpSearch(<f-args>)
" cabbrev hsearch Hsearch

fun! LineFzf(...) range

  if a:0 == 0
    let file = getline(a:firstline,a:lastline)
  else
    let file = getline(a:firstline,a:lastline)
    for ptrn in a:000
      let file = filter(file, "v:val =~ '" . ptrn . "'")
    endfor
  endif
  redraw!
  for f in file
    echom 'line: ' . f
  endfor
endfun

fun! RbRange(...) range
  ruby <<OWARI
  class VimFunctionWithRange
    def self.run
      new(buffer: Vim::Buffer.current, fline: Vim::evaluate(%[a:firstline]), lline: Vim::evaluate(%[a:lastline]), filters: Vim::evaluate('a:000'))
    end

    attr_accessor :buffer, :fline, :lline, :original_lline, :filters, :olines, :lines
    def initialize(buffer: Vim::Buffer.current, fline: Vim::evaluate('a:firstline'), lline: Vim::evaluate('a:lastline'), filters: [])
      @buffer, @fline, @lline, @original_lline = [buffer, fline, lline, lline]
      @olines = fline.upto(lline).map{|ln| [ln,buffer[ln]] }.to_h
      @lines = fline.upto(lline).map{|ln| [ln,buffer[ln]] }.to_h
      @filters = filters
      @lline -= 1
      @filtered_lines = []
      filters.each{|ptrn| re = Regexp.new(ptrn, ?i); @filtered_lines.concat(@lines.select{|lnum,line| re.match(line).is_a?(MatchData) }.values).uniq! }
      puts({lineslen: @lines.length, flineslen: @filtered_lines.length})
      puts @filtered_lines.sort
    end
  end
  VimFunctionWithRange.run
OWARI
endfun
command! -nargs=* -range=% RubyRange <line1>,<line2>call RbRange(<f-args>)
cabbrev rbr RubyRange



fun! HideQuotes(str)
  return substitute(substitute(a:str,"'",'|S|','g'),'"','|D|','g')
endfun

fun! ShowQuotes(str)
  return substitute(substitute(a:str,'|S|',"'",'g'),'|D|','"','g')
endfun

fun! Qarg(arg)
  execute 'put=a:arg'
endfun
command! -nargs=1 Qarg call Qarg(<q-args>)
cabbrev qarg Qarg

" Don't need this function anyore
" just do this instead:
" :put=getcompletion('v:*','help')

" fun! Vfun(cmd)
"   let is_fun = v:false
"   if a:cmd =~ '^\w\+(.*)$'
"     let is_fun = v:true
"     execute('let g:vfun_str = execute(' . a:cmd . ')')
"     " echo 'vfun1 => ' . string(g:vfun_val1)
"     " echo 'vfun2 => ' . string(g:vfun_val2)
"     " let g:vfun_val = g:vfun_val2
"   else
"     let g:vfun_str = execute(a:cmd)
"   endif
"
"   if is_fun == v:true
"     echo 'a:cmd was a function call'
"   endif
"   echo 'g:vfun_str = ' . string(g:vfun_str)
"
"   let g:vfun_val = eval(g:vfun_str)
"   echo 'g:vfun_val = ' . string(g:vfun_val)
"
"   " v:var
"   " v:key
"   " v:val
"   " v:char
"   " v:lang
"   " v:true
"   " v:lnum
"   " v:null
"   " v:none
"   " v:t_job
"   " v:dying
"   " v:false
"   " v:count
"   " v:ctype
"   " v:t_func
"   " v:t_bool
"   " v:t_list
"   " v:t_TYPE
"   " v:t_none
"   " v:t_dict
"   " v:errmsg
"   " v:cmdarg
"   " v:errors
"   " v:count1
"   " v:lc_time
"   " v:t_float
"   " v:foldend
"   " v:version
"   " v:testing
"   " v:cmdbang
"   " v:t_number
"   " v:t_string
"   " v:fname_in
"   " v:register
"   " v:operator
"   " v:windowid
"   " v:hlsearch
"   " v:oldfiles
"   " v:progpath
"   " v:swapname
"   " v:progname
"   " v:t_channel
"   " v:beval_col
"   " v:fname_new
"   " v:mouse_col
"   " v:mouse_win
"   " v:fname_out
"   " v:foldlevel
"   " v:foldstart
"   " v:prevcount
"   " v:exception
"   " v:statusmsg
"   " v:profiling
"   " v:beval_text
"   " v:option_new
"   " v:fcs_reason
"   " v:mouse_lnum
"   " v:fname_diff
"   " v:beval_lnum
"   " v:option_old
"   " v:fcs_choice
"   " v:warningmsg
"   " v:folddashes
"   " v:swapchoice
"   " v:throwpoint
"   " v:insertmode
"   " v:servername
"   " v:mouse_winid
"   " v:beval_winid
"   " v:shell_error
"   " v:beval_bufnr
"   " v:option_type
"   " v:beval_winnr
"   " v:swapcommand
"   " v:scrollstart
"   " v:this_session
"   " v:vim_did_enter
"   " v:termresponse
"   " v:searchforward
"   " v:charconvert_to
"   " v:completed_item
"   " v:charconvert_from
"
"   echo '....'
"   echo '....'
"
"   let g:vfun_var = eval(g:vfun_val)
"   echo 'type(g:vfun_var) => ' . type(g:vfun_var)
"   echo 'g:vfun_var => ' . string(g:vfun_var)
"
"   echo '....'
"   echo '....'
"   echo '....'
"   echo '....'
"   echo '....'
"
"   return g:vfun_val
" endfun
" command! -nargs=1 Vfun call Vfun(<q-args>)
" cabbrev vfun Vfun

silent echo ':h eval.txt'
silent echo "1276 Note how execute() is used to execute an Ex command.  That's ugly though."

function! GetAllSnippets()
  call UltiSnips#SnippetsInCurrentScope(1)
  let list = []
  for [key, info] in items(g:current_ulti_dict_info)
    let parts = split(info.location, ':')
    call add(list, {
      \"key": key,
      \"path": parts[0],
      \"linenr": parts[1],
      \"description": info.description,
      \})
  endfor
  return list
endfunction

set runtimepath+=~/vim.local

command! -nargs=1 -complete=file Hcmd :vs ~/subcommands/h-<q-args>
command! -nargs=1 -complete=file Scmd :vs ~/subcommands/h-<q-args=

cabbrev hcmd Hcmd
cabbrev scmd Scmd

" function! XikiLaunch()
"   ruby << EOF
"
"     xiki_dir = ENV['XIKI_DIR']
"     ['core/ol', 'vim/line', 'vim/tree'].each {|o| load \"#{xiki_dir}/lib/xiki/#{o}.rb\"}
"     include Xiki
"
"     line = Line.value
"     next_line = Line.value 2
"
"     indent = line[/^ +/]
"     command = \"xiki '#{line}'\"
"     result = `#{command}`
"     Tree << result
" EOF
" endfunction

imap <silent> <2-LeftMouse> <C-c>:call XikiLaunch()<CR>i
nmap <silent> <2-LeftMouse> :call XikiLaunch()<CR>
imap <silent> <C-CR> <C-c>:call XikiLaunch()<CR>i
nmap <silent> ,x :call XikiLaunch()<CR>
imap <silent> <C-@> <C-c>:call XikiLaunch()<CR>i
nmap <silent> <C-@> :call XikiLaunch()<CR>

au FileType markdown hi markdownCode ctermfg=black

runtime autoload/h.vim

