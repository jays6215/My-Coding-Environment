" rabbit125 vim setting
" Modify at 2016-10-08 17:43:23 +08:00
" Refs
" http://homepage.ntu.edu.tw/~r02921014/paste_to_vimrc.txt
" http://yslinlinuxrc.googlecode.com/svn-history/r28/trunk/.vimrc

    " Digraph setting {{{
        if has("multi_byte")
            "echo "339"
            digraph oe 339
        elseif &encoding == "iso-8859-15"
            "echo "189"
            digraph oe 189
        endif
    " }}}

    " File encodings {{{
        set       encoding=utf-8
        setglobal fileencoding=utf-8
        set       fileencoding=utf-8
        "set       termencoding=big5
        set       fileencodings=utf-8,big5,ucs-bom,cp950,sjis,latin1
        set       fileformats=unix,dos
        set       guifont=-misc-fixed-medium-r-normal-*-18-120-100-100-c-90-iso10646-1
        set       guifontwide=-misc-fixed-medium-r-normal-*-18-120-100-100-c-180-iso10646-1
    " }}}

    " Initail color settings {{{
        "autocmd BufEnter * colorscheme default
        "autocmd BufEnter *.py  colorscheme molokai
        "autocmd BufEnter *.cpp colorscheme dante         " red right margin
        "autocmd BufEnter *.cpp colorscheme darkburn      " too colorless
        "autocmd BufEnter *.cpp colorscheme candycode     " red right margin, no current underline
        "autocmd BufEnter *.cpp colorscheme 256-jungle    " no 'line' on the top
        "autocmd BufEnter *.c   colorscheme 256-jungle    " no 'line' on the top
        colorscheme default
    " }}}

    " Key mappings {{{

        " cmd\mode | Normal | Visual | Operator Pending | Insert Only | Command Line |
        " :map     |      y |      y |                y |             |              |
        " :nmap    |      y |        |                  |             |              |
        " :vmap    |        |      y |                  |             |              |
        " :omap    |        |        |                y |             |              |
        " :map!    |        |        |                  |           y |            y |
        " :imap    |        |        |                  |           y |              |
        " :cmap    |        |        |                  |             |            y |

        " special chars: different from terminal and pietty
        map  [1~ <Home>
        map  OH  <Home>
        map! [1~ <Home>
        map! OH  <Home>
        map  [4~ <End>
        map  OF  <End>
        map! [4~ <End>
        map! OF  <End>

        map  [1;5D  <C-Left>
        map  [D     <C-Left>
        map! [1;5D  <C-Left>
        map! [D     <C-Left>
        map  [1;5C  <C-Right>
        map  [C     <C-Right>
        map! [1;5C  <C-Right>
        map! [C     <C-Right>

        map  [1;3D  <A-Left>
        map! [1;3D  <A-Left>
        map  [1;3C  <A-Right>
        map! [1;3C  <A-Right>

        " common key-char matching: Same key chars
        " special chars: different from terminal and pietty
        set <PageUp>=[5~
        set <PageDown>=[6~
        set <Del>=[3~
        set <Left>=OD
        set <Right>=OC
        set <BS>=

        " number mapping for the right number keyboard
        map <Esc>Oq 1
        map <Esc>Or 2
        map <Esc>Os 3
        map <Esc>Ot 4
        map <Esc>Ou 5
        map <Esc>Ov 6
        map <Esc>Ow 7
        map <Esc>Ox 8
        map <Esc>Oy 9
        map <Esc>Op 0
        map <Esc>On .
        map <Esc>Oo /
        map <Esc>Oj *
        map <Esc>Ok +
        map <Esc>Om -
        map <Esc>OM <CR>

        map! <Esc>Oq 1
        map! <Esc>Or 2
        map! <Esc>Os 3
        map! <Esc>Ot 4
        map! <Esc>Ou 5
        map! <Esc>Ov 6
        map! <Esc>Ow 7
        map! <Esc>Ox 8
        map! <Esc>Oy 9
        map! <Esc>Op 0
        map! <Esc>On .
        map! <Esc>Oo /
        map! <Esc>Oj *
        map! <Esc>Ok +
        map! <Esc>Om -
        map! <Esc>OM <CR>

        " tab-page selection
        map g1 :tabn 1<CR>
        map g2 :tabn 2<CR>
        map g3 :tabn 3<CR>
        map g4 :tabn 4<CR>
        map g5 :tabn 5<CR>
        map g6 :tabn 6<CR>
        map g7 :tabn 7<CR>
        map g8 :tabn 8<CR>
        map g9 :tabn 9<CR>
        map g0 :tabn 10<CR>
        map gc :tabnew<CR>
        map gn :tabn<CR>
        map gp :tabp<CR>

        " make Page Up/Down to the middle
        map  <PageUp>   <PageUp>zz
        imap <PageUp>   <PageUp><Esc>zzi
        map  <PageDown> <PageDown>zz
        imap <PageDown> <PageDown><Esc>zzi

        " select all: ctrl + a
        map  <C-a> ggVG
        imap <C-a> <Esc>ggVGi

        " quick saving: ctrl + s in ~/.shrc stty -ixon
        map  <C-s> :w<CR>
        imap <C-s> <ESC>:w<CR>i

        " tabpage settings
        " fix tabline, always on
        set showtabline=2
        " GUI pure-text tabline
        set guioptions-=e
        " Known width char, use two column width to show it
        set ambiwidth=double
        " use '...' to replace to too long tabline
        let tabEllipsis ='...'
        " user difined tabpage
        set tabline=%!MyTabLine()

        " left/right tabpage changing: ctrl + left / right
        map  <C-Left>  :tabp<CR>
        "imap <C-Left>  <Esc>:tabp<CR>i
        map  <C-Right> :tabn<CR>
        "imap <C-Right> <Esc>:tabn<CR>i

        " relocate/move tab page: alt + left / right
        map  <A-Left>  :tabm -1<CR>
        "imap <A-Left>  <Esc>:tabm -1<CR>i
        map  <A-Right> :tabm +1<CR>
        "imap <A-Right> <Esc>:tabm +1<CR>i

        "map [5~ :tab
        " [5;5~ = ctrl + PageUp in terminal
        "map [6~ :tabp<CR>
        " [6;5~ = ctrl + PageDown in terminal
        "map <C-PageUp>   :tabp<CR>
        "map <C-PageDown> :tabn<CR>

        " new tabpage: ctrl + n
        " stop for short-cut: ctrt + t
        "map  <C-t> :tabnew<CR>
        "imap <C-t> <ESC>:tabnew<CR>i
        map  <C-n> :tabnew<CR>
        "imap <C-n> <ESC>:tabnew<CR>i

        " open file: ctrl + o
        map  <C-o> :tabe 
        imap <C-o> <ESC>:tabe 

        " new tabpage(2): ctrl + p
        "map  <C-p> :tabnext<CR>
        "imap <C-p> <ESC>:tabnext<CR>i

        " close file: ctrl + w
        "map  <C-w> :tabclose<CR>
        map  <C-w> :q<CR>
        imap <C-w> <ESC>:q<CR>i
        "map  <C-W> :q!<CR>
        "imap <C-W> <ESC>:q!<CR>

        " return editing
        map  <C-z> u
        imap <C-z> <ESC>ui

        " copy line: ctrl + d
        imap <C-d> <Esc>ddPP<CR>iOA
        map  <C-d> ddPP<CR>OA

        " copy the text in visual mode
        map <C-c> "+y<CR>


        " search for visually selected text: ctrl + f
        " http://vim.wikia.com/wiki/Search_for_visually_selected_text
        "map <C-F> /
        "vnoremap // y/<C-R>"<CR>

        " split left / right screen: ctrl + p
        "map <C-p> :vsp 
        " split up / down screen: shift + p
        "map <S-P> :sp 

        " 上下分割螢幕

        " shift by tab key: tab & shift + tab
        map  <Tab> >>
        "imap <Tab> <Esc>>>i
        map  <S-Tab> <<
        imap <S-Tab> <Esc><<i

        " rename file in VIM: F2
        map <F2> :Rename 
        map [12~ :Rename 

        " remoce windows's newline char: F3
        " :%s/\r//g // ok
        " :%s/^M//g // fail
        " could also use "tr" in linux command to remove "^M" char
        " cat oldfile | tr -d '\r' > newfile
        map <F3>   :%s/\r//g<CR>
        map [13~ :%s/\r//g<CR>

        " replace tab char in the file: F4
        map <F4>   :retab<CR>
        map [14~ :retab<CR>

        " reload file & refresh unchanged files : F5
        map <F5> :edit<CR>
        set autoread

        " open/close taglist: F6
        map <F6> :TlistToggle<CR>
        " taglist_46 settings: for vin 6.0 up
        " auto close taglist while closing the last file
        let Tlist_Exit_OnlyWindow = 1
        " showing one taglist file for current file
        let Tlist_Show_One_File = 1
        " focus on taglist filw while open
        let Tlist_GainFocus_On_ToggleOpen = 1
        " show taglist on the right
        let Tlist_Use_Right_Window = 1
        " taglist width
        let Tlist_WinWidth = 45

        " toggle code paste mode: F7
        nnoremap <F7> :set invpaste paste?<CR>
        set pastetoggle=<F7>

        " insert date line: F8
        "map  <F8>   :read !date<CR>
        "imap <F8>   <Esc>:read !date<CR>i
        map  <F8>   :read !date +"\%Y-\%m-\%d \%H:\%M:\%S \%:z"<CR>
        imap <F8>   <Esc>:read !date +"\%Y-\%m-\%d \%H:\%M:\%S \%:z"<CR>i
        "map [19~  <Esc>:read !date<CR>

        """ ctags settings
        " [20;5~ = C-F9
        " [20~   = F9
        " shortcut for save ctags at local dir: F9
        map <F9>   :!ctags -R -h ".h.c.cpp.cc.java" --c++-kinds=+px --fields=+iaS --extra=+q .<CR><CR>
        " [path error] shortcut for save ctags at global dir: ctrl + F9
        map [20;5~ :!ctags -R -h ".h.c.cpp.cc.java" --c++-kinds=+px --fields=+iaS --extra=+q -f ~/.vim/stdtags<CR><CR>
        " open the definition in a new tab: ctrl + \
        map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
        " ctags file setting
        set tags+=~/.vim/stdtags,tags,.tags,../tags
        " some shortcuts:
        " Ctrl + ]: jump into variable/function based on your current curser
        " Ctrl + t or Ctrl + o: return back (no mapping currently)

        " search and highlight but do not jump, three ways for chooses
        " switch # and * --> #:search forwards, *:search backwards
        " http://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump

        " enhance copy the highlighted word (and save into clipboard register by '+' and paste by '"+p')
        " work well with highlight by mouse (and paste by middle click)
        " http://stackoverflow.com/questions/4620672/copy-and-paste-content-from-one-file-to-another-file-in-vi
        " http://vim.wikia.com/wiki/Word_under_cursor_for_command
        " http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text

        "nnoremap * #``
        "nnoremap * :keepjumps normal! #``<CR>
        nnoremap * *#"*yiw

        "nnoremap # *``
        "nnoremap # :keepjumps normal! *``<CR>
        nnoremap # #*"+*yiw

        " save & show full path of current file: F10
        map <F10> :call EasyCopyFilePath()<CR>

        " show related Function name to current line: ctrl + F12
        map [23;5~ :call ShowFuncName()<CR>
        map <C-F12> :call ShowFuncName()<CR>

    " }}}

    " Settings for specific files {{{

        " for files named *.c / *.cpp / *.py, use program's indent
        autocmd BufNewFile,BufRead *.c   set cindent
        autocmd BufNewFile,BufRead *.cpp set cindent
        autocmd BufNewFile,BufRead *.py  set cindent

        " for files named *.c / *.cpp / *.py, use autoindent to match line above
        autocmd BufNewFile,BufRead *.c   set autoindent
        autocmd BufNewFile,BufRead *.cpp set autoindent
        autocmd BufNewFile,BufRead *.py  set autoindent

        " for files named *.c / *.cpp / *.py, use smart indent
        autocmd BufNewFile,BufRead *.c   set smartindent
        autocmd BufNewFile,BufRead *.cpp set smartindent
        autocmd BufNewFile,BufRead *.py  set smartindent

        " use tab char in Makefile
        " use command :verbose set expandtab? to confirm
        autocmd FileType make setlocal noexpandtab

        " use C++'s autocompletion
        set nocp
        " C++ path adding
        set path+=/usr/include/c++/4.9.3

        autocmd InsertLeave * if pumvisible() == 0|pclose|endif

        " ctrl + n to show the matched term list, press enter to apply such term you want to add

        " if no screen, use color term
        if ($TERM == "vt100")
            " XTERM-Color / screen
            set t_Co=8
            set t_AF=[1;3%p1%dm
            set t_AB=[4%p1%dm
        endif

        " the initail screen after exiting file
        if ($TERM == "vt100")
            " SecureCRT versions prior to 6.1.x do not support 4-digit DECSET
            "     let &t_ti = "\<Esc>[?1049h"
            "     let &t_te = "\<Esc>[?1049l"
            " Use 2-digit DECSET instead
            let &t_ti = "\<Esc>[?47h"
            let &t_te = "\<Esc>[?47l"
        endif

    " VIM's controlling settings }}}

        " show file sub-name
        filetype on
        filetype plugin on
        "filetype indent on

        " set not compatible to VI
        set nocompatible
        " set no-bomb in utf-8 file
        set nobomb
        " open mouse mode
        "set mouse=a
        " middle mouse key
        "map <S-Insert> <MiddleMouse>

        " save 200 vim's commands
        set history=200
        " show the matched VIM's command list
        set wildmenu
        " auto complete the VIM's longest matched commands
        set wildmode=longest:list,full
        " let following file not apply auto complete
        set wildignore=*.o,*.class,*.piyc

        " keep a backup file
        set backup
        " set the directory for backup file
        "set backupdir=~/tmp,.,/var/tmp/vi.recover,/tmp
        set backupdir=~/.backup
        " ...
        set directory=~/tmp,/var/tmp/vi.recover,/tmp,.

        " crontabs must be edited in place
        au BufRead /tmp/crontab* :set backupcopy=yes
        " use system clipboard to save no-name variables(@", @+ or @*)
        "set clipboard=unnamed
        " for VIM >=7.3.74, automatically use the + buffer (the system clipboard) by default
        set clipboard=unnamedplus
        " read / write a .viminfo file, don't store more
        set viminfo='20,\"50
        " let VIM remember the location in last editing
        au BufReadPost * if line("'\"") > 0|if line("'\"")
        \ <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
        " not generate .nu file
        " undofile: put the undo information into file..
        set noundofile
        " max undo size
        set undolevels=1000

    " }}}

    " Screen settings {{{

        " tile for VIM window's top bar
        set title

        " use syntax hightlight
        syntax   on
        " use 256 color
        "set t_Co=256
        " use dark color background, another is 'light'
        set background=dark

        " showing multiple lines for a long line(wrap) or not(nowrap)
        set nowrap
        " use autoindent mode
        set autoindent
        " fold mode settings
        set foldmethod=syntax
        set foldlevel=10
        " to see special char
        set listchars=tab:->,trail:-
        set list  
        " allow backspacing over everything in insert mode
        set backspace=2
        " set tab size as # of spaces
        set shiftwidth=2
        " # of spces to changing into one tab char
        set tabstop=2
        " replace tab by spaces
        set expandtab
        " set the # of spaces to be deleted, which is made by tab key
        set softtabstop=2

        " prefer to show new split window at bottom side
        set splitbelow
        " prefer to show new split window at right side
        set splitright

        " status bar settings
        " show VIM current mode at left-bottom(Visual, Select, Insert)
        set showmode
        " show the typing command at light-bottom
        set showcmd
        " show the status bar(position info) at bottom
        set ruler
        " status bar location
        set laststatus=2
        " cterm-colors
        " NR-16   NR-8    COLOR NAME
        "    0      0     Black
        "    1      4     DarkBlue
        "    2      2     DarkGreen
        "    3      6     DarkCyan
        "    4      1     DarkRed
        "    5      5     DarkMagenta
        "    6      3     Brown, DarkYellow
        "    7      7     LightGray, LightGrey, Gray, Grey
        "    8      0*    DarkGray, DarkGrey
        "    9      4*    Blue, LightBlue
        "    10     2*    Green, LightGreen
        "    11     6*    Cyan, LightCyan
        "    12     1*    Red, LightRed
        "    13     5*    Magenta, LightMagenta
        "    14     3*    Yellow, LightYellow
        "    15     7*    White
        " style: underline / reverse / bold
        set statusline=%4*\ \ %8*[\ %1*%{CostomizeFullFileName(0)}%3*/%2*%{CostomizeFullFileName(1)}
        set statusline+=%8*\ \|\ %6*%{&encoding},%{&spelllang},%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}
        set statusline+=%8*\ \|\ %7*%{FileTime()}
        set statusline+=%8*\ ]\ %4*%=%0*%r
        set statusline+=%8*\ [\ %5*(%l,%5*%c)%m%8*\ \|\ %9*%p%9*%%%8*\ ]

        highlight User1  term=bold      cterm=bold,underline    ctermfg=1
        highlight User2  term=underline cterm=bold,underline    ctermfg=3
        highlight User3  term=bold      cterm=bold              ctermfg=0
        highlight User4  term=bold      cterm=reverse           ctermfg=0
        highlight User5  term=bold      cterm=bold,underline    ctermfg=2
        highlight User6  term=bold      cterm=bold,underline    ctermfg=5
        highlight User7  term=bold      cterm=bold,underline    ctermfg=4
        highlight User8  term=underline cterm=bold              ctermfg=7
        highlight User9  term=underline cterm=bold,underline    ctermfg=6

        " show line number
        " not show: :nonumber
        set number
        " width for line number
        set numberwidth=6
        "set textwidth=78
        " show the highlight for current line
        set cursorline
        " turn off highlight for current line
        "set invcursorline
        " set auto jump while typing searched term
        set incsearch
        " use highlight for searched term
        set hlsearch
        " highlight matched brackets
        set showmatch

        " color settings
        " ref: http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
        highlight LineNr                           cterm=NONE            ctermfg=Grey        ctermbg=NONE
        highlight CursorLineNr                     cterm=bold,reverse    ctermfg=DarkGreen   ctermbg=NONE
        highlight CursorLine                       cterm=bold                                ctermbg=DarkBlue
        highlight ColorColumn                                            ctermbg=Blue
        highlight TabLineSel   term=bold,underline cterm=bold,underline  ctermfg=Gray        ctermbg=DarkRed
        highlight TabLine      term=bold           cterm=bold
        highlight Comment                          cterm=bold
        highlight Search       term=bold           cterm=bold,reverse    ctermfg=Yellow      ctermbg=None
        highlight clear TabLineFill

        " color for margin line
        " Right margin & After-margin area
        "set colorcolumn=80
        "let &colorcolumn="80,".join(range(120,999),",")

        " plugin config
        let g:indent_guides_auto_colors = 0
        let g:indent_guides_guide_size  = 1
        "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
        "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
        "hi IndentGuidesOdd  guibg=red   ctermbg=3
        "hi IndentGuidesEven guibg=green ctermbg=4
        highlight IndentGuidesOdd  ctermbg=8
        highlight IndentGuidesEven ctermbg=12

    " }}}

    " Specials {{{

        " Notes for useful commands
        " :set nowrap                // showing one line with over-width strings
        " :map                       // looking shortcut setting
        " :IndentGuidesToggle        // Ext-function: Toggles the indent guides
        " :so color_demo.vim         // Ext-script: Showing avaliable color highlightings
        " gf / ctrl + 6              // go into/back from file, open the file located by current line
        " :! COMMAND                 // executing TERMINAL COMMAND, will return to terminal

    " }}}

    " --------------------------------------------------
    " [paste mode no-paste mode switcher] {{{
    " --------------------------------------------------
    " enable in Linux: gnome-terminal / Windows: New Putty / OSX: Terminal、iterm2
    " vim command: set paste / set nopaste
    if &term =~ "xterm.*"
        let &t_ti = &t_ti . "\e[?2004h"
        let &t_te = "\e[?2004l" . &t_te
        function! XTermPasteBegin(ret)
            set pastetoggle=<Esc>[201~
            set paste
            return a:ret
        endfunction
        map <expr> <Esc>[200~ XTermPasteBegin("i")
        imap <expr> <Esc>[200~ XTermPasteBegin("")
        cmap <Esc>[200~ <nop>
        cmap <Esc>[201~ <nop>
    endif

    " --------------------------------------------------
    " [File name copying] {{{
    " --------------------------------------------------
    " save into 1.unnamed register(@", for yank, use 'p' to paste it on vim) & 2.system-level clipboard(@+, out of vim)
    " http://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
    " http://vim.wikia.com/wiki/Get_the_name_of_the_current_file
    " http://vim.wikia.com/wiki/Copy_filename_to_clipboard
    function! EasyCopyFilePath()
        let fullpath = expand("%:p")
        let visible_len = -1 * (winwidth(0) - 12) * 9 / 10
        " following two clipboard needs "+xterm_clipboard"(VIM with "+clipboard")
        " install vim with such feature
        " Ubuntu provides Vim with +clipboard: vim-gnome, vim-athena, and vim-gtx
        " Ex: $ sudo apt-get install vim-gnome
        let @* = fullpath
        let @+ = fullpath
        let @" = fullpath
        echon '  '
        echohl User5
        echon 'FILE PWD:'
        echohl User8
        echon  ' ' . fullpath[visible_len :]
        echohl None
    endfunction
    " }}}

    " --------------------------------------------------
    " [Dynamic Name for current file] {{{
    " --------------------------------------------------
    function! CostomizeFullFileName(name_part)
        let curfilename=expand("%:t")
        let curfilepath=expand("%:h")
        let visible_len = -1 * len(curfilepath)
        if winwidth(0) >= 70 + len(curfilename)
            let visible_len = -1 * (winwidth(0) - 70 - len(curfilename)) * 9 / 10
        endif
        "echo visible_len
        if a:name_part == 0
            return curfilepath[visible_len :]
        endif
        return curfilename
    endfunction
    " }}}

    " --------------------------------------------------
    " [File Time] {{{
    " --------------------------------------------------
    " show file time in status line
    " http://vim.wikia.com/wiki/Show_file_modification_time_on_status_bar
    " e.g. set statusline=%<%f%<%{FileTime()}%<%h%m%r%=%-20.(line=%03l,col=%02c%V,totlin=%L%)\%h%m%r%=%-30(,BfNm=%n%Y%)\%P\
    function! FileTime()
        let curfilename=expand("%:t")
        let curfilepath=expand('%:h')
        let fullfilename=curfilepath . '/' . curfilename
        let msg="".strftime("%Y-%m-%d %H:%M %Z", getftime(fullfilename))
        return msg
    endfunction
    " }}}<F5>

    " --------------------------------------------------
    " [Padding zero for number] {{{
    " --------------------------------------------------
    " http://stackoverflow.com/questions/4964772/string-formatting-padding-in-vim
    " PrePad('832', 4, '0') == '0823'
    function! PrePad(s,amt,...)
        if a:0 > 0
            let char = a:1
        else
            let char = ' '
        endif
        return repeat(char,a:amt - len(a:s)) . a:s
    endfunction
    " }}}

    " --------------------------------------------------
    " [Show related function name to current line] {{{
    " --------------------------------------------------
    " http://vim.wikia.com/wiki/Show_current_function_name_in_C_programs
    " http://stackoverflow.com/questions/13634826/vim-show-function-name-in-status-line
    function! ShowFuncName()
        let lnum = line(".")
        let col = col(".")
        "echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
        let located_fl = search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW')
        let head_func = getline(located_fl)
        let visible_len = -1 * (winwidth(0) - 13) * 9 / 10
        echon '  '
        if located_fl > 0
            echohl User5
            echon 'Line: ' . located_fl
            echohl User8
            echon ' ' . head_func[visible_len :]
            echohl None
            let @* = head_func
            let @+ = head_func
            let @" = head_func
        else
            echon 'Not found function header...'
        endif
        call search("\\%" . lnum . "l" . "\\%" . col . "c")
    endfun
    " }}}

    " --------------------------------------------------
    " [User difined Tabline, dynamical version] {{{
    " --------------------------------------------------
    function! MyTabLine()
        "set limit width of one tab page
        let limit_width = (winwidth(0) - 6 - 3 * tabpagenr('$') - 15 - len(''.tabpagenr().'') - len(''.tabpagenr('$').'')) / tabpagenr('$')
        let s = '%8* Line '
        let cur_no = -1
        for i in range(tabpagenr('$'))
            " set thetabpagenumber (for mouse clicks)
            "let s .= '%' . (i + 1) . 'T'
            " select the highlighting
            "if i + 1 == tabpagenr()
            "    let s .= ' %1*'
            "else
            "    let s .= ' %8*'
            "endif
            "let s .= i+1 . ':'
            "let s .= '%3*'
            let s .= ' '
            " select the highlighting
            if i + 1 == tabpagenr()
                " '%#TabLineSel#'
                let cur_no = i + 1
                let s .= '%2*'
            else
                " '%#TabLine#'
                let s .= '%*'
            endif
            " the label is made by MyTabLabel()
            let s .= '%{MyTabLabel(' . (i + 1) . ',' . (limit_width) . ')}'
            let s .= '%3* |'
         endfor
        " after the last tab fill with TabLineFill and reset tabpagenr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') == 1
            let s .= '%=%#TabLine#%999X'. '%8*[ ' . '%2*' . cur_no . '%8*/' . tabpagenr('$') . '  tab ]'
        else
            let s .= '%=%#TabLine#%999X'. '%8*[ ' . '%2*' . cur_no . '%8*/' . tabpagenr('$') . ' tabs ]'
        endif
        return s
    endfunction
    function! MyTabLabel(n,limit_len)
        let buflist   = tabpagebuflist(a:n)
        let winnr     = tabpagewinnr(a:n)
        let alist     = split(bufname(buflist[winnr - 1]),'/')
        let NoName = 1
        for ii in alist
            let shortname = ii
            let NoName = 0
        endfor
        if NoName == 1
            let shortname = '[New]'
        endif
        " http://learnvimscriptthehardway.stevelosh.com/chapters/35.html
        " http://learnvimscriptthehardway.stevelosh.com/chapters/24.html
        " http://stackoverflow.com/questions/26315925/get-usable-window-width-in-vim-script
        return shortname[:a:limit_len]
        "return shortname
        "return fnamemodify(shortname, ':t')
        "return bufname(shortname[winnr - 1])
    endfunction
    " }}}

    " --------------------------------------------------
    " [ReferenceLine] {{{
    " --------------------------------------------------
    function! ReferenceLine(t)
        let ccnum = &cc
        if ccnum == '' | let ccnum = 0 | en
        let csw = &sw
        if a:t == 'add'
            let ccnum = ccnum + csw
            exec "setl cc=".(ccnum)
        elsei a:t == 'sub'
            let ccnum = ccnum - csw
            if ccnum >= 0 | exec "setl cc=".(ccnum) | en
        en
    endfunction
    "map  . <A->>
    "map  , <A-<>
    map , <A-<>
    map . <A->>
    map <silent> <A-<> :call ReferenceLine('sub')<CR>
    map <silent> <A->> :call ReferenceLine('add')<CR>
    " }}}

    " --------------------------------------------------
    " [Rename file in VIM] {{{
    " --------------------------------------------------
    " Rename.vim  -  Rename a buffer within Vim and on the disk
    " Copyright June 2007-2011 by Christian J. Robinson <heptite@gmail.com>
    " Distributed under the terms of the Vim license.  See ":help license".
    " Usage:
    " :Rename[!] {newname}
    command! -nargs=* -complete=file -bang Rename call Rename(<q-args>, '<bang>')
    function! Rename(name, bang)
        let l:name    = a:name
        let l:oldfile = expand('%:p')
        if bufexists(fnamemodify(l:name, ':p'))
            if (a:bang ==# '!')
                silent exe bufnr(fnamemodify(l:name, ':p')) . 'bwipe!'
            else
                echohl ErrorMsg
                echomsg 'A buffer with that name already exists (use ! to override).'
                echohl None
                return 0
            endif
        endif
        let l:status = 1
        let v:errmsg = ''
        silent! exe 'saveas' . a:bang . ' ' . l:name
        if v:errmsg =~# '^$\|^E329'
            let l:lastbufnr = bufnr('$')
            if expand('%:p') !=# l:oldfile && filewritable(expand('%:p'))
                if fnamemodify(bufname(l:lastbufnr), ':p') ==# l:oldfile
                    silent exe l:lastbufnr . 'bwipe!'
                else
                    echohl ErrorMsg
                    echomsg 'Could not wipe out the old buffer for some reason.'
                    echohl None
                    let l:status = 0
                endif
                if delete(l:oldfile) != 0
                    echohl ErrorMsg
                    echomsg 'Could not delete the old file: ' . l:oldfile
                    echohl None
                    let l:status = 0
                endif
            else
                echohl ErrorMsg
                echomsg 'Rename failed for some reason.'
                echohl None
                let l:status = 0
            endif
        else
            echoerr v:errmsg
            let l:status = 0
        endif
        return l:status
    endfunction
    " }}}
