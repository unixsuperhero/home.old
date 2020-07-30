
" Basics
" ------

set nocompatible

syntax on
filetype on

if $VIM_PLUGINS != 'NO'
  runtime! autoload/pathogen.vim
  if exists('g:loaded_pathogen')
    execute pathogen#infect('~/.vimbundles/{}', '~/.vim/bundle/{}')
  endif
endif


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

set bs=indent,eol,start
set nrformats=octal,hex,alpha

set scrolloff=4
set sidescrolloff=2

" set colorcolumn=80

set confirm       " -- instead of saying can't quit cuz buffer modified, ask to save it

set nowrap nolist

set nohlsearch

set showmatch matchtime=2
set modeline modelines=5
set history=1000                                  " Remember up to 1000 'colon' commmands and search patterns
set wildmenu wildmode=list:longest,full

set equalprg=bc                                   " cmd to use when you press = in visual mode
set mouse=a
set t_RV=                                         " Don't request terminal version string (for xterm)
set updatecount=50                                " Write swap file to disk after every 50 characters
set enc=utf-8                                     " Use UTF-8 as the default buffer encoding

set viminfo='200,\"100,/9000,:9000,n~/.viminfo    " Remember things between sessions
set backupskip=/tmp/*,/private/tmp/*"
set diffopt=filler,iwhite,vertical
set switchbuf=useopen,split

set spellfile=~/.vim/words.utf8.add

set fileignorecase wildignorecase

if has('persistent_undo')
  set undofile
  if ! isdirectory(expand('~') . "/.vim/tmp")
    call mkdir(expand('~') . "/.vim/tmp/josh/is/awesome","p")
  endif
  set undodir=~/.vim/tmp//,~/.vim/undo_files//,~/.vim//,/tmp//
endif

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


cabbrev V vert
cabbrev vh vert h

cabbrev VI '<,'><c-r>=Eatchar('\s')<cr>

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

" colorscheme monokai " DOES NOT EXIST RIGHT NOW
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


" imap <silent> <2-LeftMouse> <C-c>:call XikiLaunch()<CR>i
" nmap <silent> <2-LeftMouse> :call XikiLaunch()<CR>
" imap <silent> <C-CR> <C-c>:call XikiLaunch()<CR>i
" nmap <silent> ,x :call XikiLaunch()<CR>
" imap <silent> <C-@> <C-c>:call XikiLaunch()<CR>i
" nmap <silent> <C-@> :call XikiLaunch()<CR>

au FileType markdown hi markdownCode ctermfg=black

" runtime autoload/h.vim

nmap <Space>O :call execute("norm :put!=nr2char(10)" . nr2char(13))<cr>
nmap <Space>o :call execute("norm :put =nr2char(10)" . nr2char(13))<cr>

nmap <Space>K :move -2<cr>
nmap <Space>J :move +<cr>
vmap <Space>K :move -2<cr>gv
vmap <Space>J :move '>+<cr>gv


