" 個人vim設定 by rabbit125
" Modify at Mon Jan 12 17:43:33 CST 2015
" Refs
" http://homepage.ntu.edu.tw/~r02921014/paste_to_vimrc.txt
" http://yslinlinuxrc.googlecode.com/svn-history/r28/trunk/.vimrc

    " digraph setting {{
        if has("multi_byte")
            "echo "339"
            digraph oe 339
        elseif &encoding == "iso-8859-15"
            "echo "189"
            digraph oe 189
        endif
    " }}

    " 檔案相關設定 {{{
        set       encoding=utf-8
        setglobal fileencoding=utf-8
        set       fileencoding=utf-8
        "set       termencoding=big5
        set       fileencodings=utf-8,big5,ucs-bom,cp950,sjis,latin1
        set       fileformats=unix,dos
        set       guifont=-misc-fixed-medium-r-normal-*-18-120-100-100-c-90-iso10646-1
        set       guifontwide=-misc-fixed-medium-r-normal-*-18-120-100-100-c-180-iso10646-1
    " }}}

    " 按鍵快捷標籤 {{{

        " 特殊字元定義: different from terminal and pietty
        map  [1~ <Home>
        map  [4~ <End>
        map  OH  <Home>
        map  OF  <End>
        imap [1~ <Home>
        imap [4~ <End>
        imap OH  <Home>
        imap OF  <End>

        map [1;5D  <C-Left>
        imap [1;5D <C-Left>
        map [D     <C-Left>
        imap [D    <C-Left>
        map [1;5C  <C-Right>
        imap [1;5C <C-Right>
        map [C     <C-Right>
        imap [C    <C-Right>

        " 共通字元: Same key chars
        set <PageUp>=[5~
        set <PageDown>=[6~
        set <Del>=[3~
        set <Left>=OD
        set <Right>=OC

        " 快選分頁
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

        " 設定Page Up/Down 當前行移至中間
        map  <PageUp>   <PageUp>zz
        imap <PageUp>   <PageUp><Esc>zzi
        map  <PageDown> <PageDown>zz
        imap <PageDown> <PageDown><Esc>zzi

        " 全選: ctrl+a
        map  <C-a> ggVG
        imap <C-a> <Esc>ggVGi

        " 儲存檔案: ctrl+s in ~/.shrc stty -ixon
        map  <C-s> :w<CR>
        imap <C-s> <ESC>:w<CR>i

        " 分頁設定
        " 永久顯示分頁列
        set showtabline=2
        " gui 也使用純文字的 tabline
        set guioptions-=e
        " 未知寬度的字以兩個 column 顯示
        set ambiwidth=double
        " 分頁過長而被截短時，要顯示的替代文字
        let tabEllipsis ='...'
        " 設定個人分頁標頭
        set tabline=%!MyTabLine()

        " 左右切換分頁:
        " pietty ctrl + left / right
        map  [D :tabp<CR>
        "imap [D <ESC>:tabp<CR>i
        map  [C :tabn<CR>
        "imap [C <ESC>:tabn<CR>i
        " terminal ctrl + left / right
        map  [1;5D :tabp<CR>
        "imap [1;5D <ESC>:tabp<CR>i
        map  [1;5C :tabn<CR>
        "imap [1;5C <ESC>:tabn<CR>i

        "map [5~ :tabn<CR>
        " [5;5~ = ctrl+PageUp in terminal
        "map [6~ :tabp<CR>
        " [6;5~ = ctrl+PageDown in terminal
        "map <C-PageUp>   :tabp<CR>
        "map <C-PageDown> :tabn<CR>

        " 開新分頁: ctrl+t, ctrl+n
        map  <C-t> :tabnew<CR>
        imap <C-t> <ESC>:tabnew<CR>i
        map  <C-n> :tabnew<CR>
        "imap <C-n> <ESC>:tabnew<CR>i

        " 開舊檔案: ctrl+o
        map  <C-o> :tabe 
        imap <C-o> <ESC>:tabe 

        " 下一新分頁: ctrl+p
        "map  <C-p> :tabnext<CR>
        "imap <C-p> <ESC>:tabnext<CR>i

        " 關閉分頁/檔案: ctrl+w
        "map  <C-w> :tabclose<CR>
        map  <C-w> :q<CR>
        imap <C-w> <ESC>:q<CR>i
        "map  <C-W> :q!<CR>
        "imap <C-W> <ESC>:q!<CR>

        " 復原動作
        map  <C-z> u
        imap <C-z> <ESC>ui

        " 左右分割螢幕
        "map <C-p> :vsp 
        " 上下分割螢幕
        "map <S-P> :sp 

        " 上下分割螢幕

        " 行左右位移: tab & shift+tab
        map  <Tab> >>
        "imap <Tab> <ESC>>>i
        map  [Z <<
        imap [Z <ESC><<i

        " 修改檔案名稱: F2
        "map [12~ :!mv % =expand("%:h")<CR>
        "map [12~ :q \| !mv =expand("%:t ")<CR>
        map OQ :Rename 
        map [12~ :Rename 

        " 取消windows換行符號: F3
        " :%s/\r//g // ok
        " :%s/^M//g // fail
        " 在linux下也可以用tr 這個指令，來移除^M的Dos換行符號
        " cat oldfile | tr -d '\r' > newfile
        map OR   :%s/\r//g<CR>
        map [13~ :%s/\r//g<CR>

        " 取代當前檔案中的tab字元: F4
        map OS  :retab<CR>
        map [14~ :retab<CR>

        " 插入日期: ctrl+F8
        imap [19~   <ESC>:read !date<CR>iModify at 
        imap [19;5~ <ESC>:read !date<CR>iModify at 

        " 行複製: ctrl+d
        imap  <ESC>ddPP<CR>iOA
        map   ddPP<CR>OA

    " }}}

    " 其他設定 {{{

        " 設定utf-8檔案無檔首
        set nobomb

        " 讓vim記得上次最後編輯的位置
        au BufReadPost * if line("'\"") > 0|if line("'\"")
        \ <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

        " 設定C++的autocompletion
        set nocp
        filetype plugin on
        set tags=~/.vim/stdtags,tags,.tags,../tags
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif

        " 輸入對應括號時,會跳回前一個括號顯示配對的情況
        " ctrl+n set自動補完會列出待選清單
        set showmatch
        " 指令打會列出待選列表
        set wildmenu
        " 自動補完 C++
        set path+=/usr/include/c++/4.4.0

        " if no screen, use color term
        if ($TERM == "vt100")
            " XTERM-Color / screen
            set t_Co=8
            set t_AF=[1;3%p1%dm
            set t_AB=[4%p1%dm
        endif

        " 設定離開文件後的'初始'終端機畫面
        if ($TERM == "vt100")
            " SecureCRT versions prior to 6.1.x do not support 4-digit DECSET
            "     let &t_ti = "\<Esc>[?1049h"
            "     let &t_te = "\<Esc>[?1049l"
            " Use 2-digit DECSET instead
            let &t_ti = "\<Esc>[?47h"
            let &t_te = "\<Esc>[?47l"
        endif

        " 與vi不相容 <-> compatible
        set nocompatible

        " 儲存暫存檔 keep a backup file
        set backup
        " 設定備份檔案儲存位置
        "set backupdir=~/tmp,.,/var/tmp/vi.recover,/tmp
        set backupdir=~/.backup
        " ...
        set directory=~/tmp,/var/tmp/vi.recover,/tmp,.

    " }}}

    " 界面設定 {{{

        " 讓 Vim 設置窗口標題
        set title

        " 命令行自動補全所使用的菜單
        set wildmenu
        " 'wildchar' 命令行擴展所用的模式
        set wildmode=list:full
        " 匹配這些模式的文件不會參與自動補全
        set wildignore=*.o,*.class,*.piyc

        " 一行若是太長,則向右延伸到螢幕外邊
        "set nowrap

        " 副檔名..
        filetype on
        filetype plugin on
        "filetype indent on

        " 語法高亮
        syntax   on
        " 256 色
        set t_Co=256

        " 暗色系背景, another is 'light'
        set background=dark
        " 設定畫線高亮顯示當前列
        set cursorline
        " 高亮當前行顏色設定
        highlight CursorLine ctermbg=17

        "map [14~ :set invcursorline<CR>
        " 左下角會顯示目前的模式(Visual, Select, Insert)
        set showmode
        " 右下角顯示輸入的指令
        set showcmd
        " 右下角顯示游標行列位置
        set ruler

        "設定搜尋字串打入部份字元時就會自動跳到找到的字串"
        set incsearch
        "保留 100 個使用過的指令
        set history=100

        " 在一行開頭按退格鍵如何處理 allow backspacing over everything in insert mode
        set backspace=2
        " 設定高亮出尋找字詞
        set hlsearch

        " 開啟滑鼠功能
        "set mouse=a
        " 滑鼠中鍵
        "map <S-Insert> <MiddleMouse>

        " tab鍵縮排縮幾個空白長度
        set shiftwidth=4
        " tabstop 是當它發現有幾個空白時會換成一個 tab
        set tabstop=4
        " 空白代替tab
        set expandtab
        " 一次刪除由tab產生的空白符
        set softtabstop=4

        " 將檔案中的tab 取代成4個空白符
        ":retab

        " 文字收合,折疊設定
        set foldmethod=syntax
        set foldlevel=10

        " 對.c/.cpp/.py檔 program自動縮排
        autocmd BufNewFile,BufRead *.c   set cindent
        autocmd BufNewFile,BufRead *.cpp set cindent
        autocmd BufNewFile,BufRead *.py  set cindent

        " 對.c/.cpp/.py檔 換行時會自動對齊上一行的縮排
        autocmd BufNewFile,BufRead *.c   set autoindent
        autocmd BufNewFile,BufRead *.cpp set autoindent
        autocmd BufNewFile,BufRead *.py  set autoindent

        " ...
        autocmd BufNewFile,BufRead *.c   set smartindent
        autocmd BufNewFile,BufRead *.cpp set smartindent
        autocmd BufNewFile,BufRead *.py  set smartindent

        " 對 Makefile 需要使用 Tab
        " 可以用 :verbose set expandtab? 確認
        autocmd FileType make setlocal noexpandtab

        " 自動縮排
        set ai

        " 特殊字元顯示
        set listchars=tab:->,trail:-
        set list

        " 分割窗口時新窗口在當前窗口之下
        set splitbelow
        " 新窗口在當前窗口之右
        set splitright

        " 使用剪貼板作為無名的寄存器
        set clipboard+=unnamed

        " Crontabs must be edited in place
        au BufRead /tmp/crontab* :set backupcopy=yes

        "set textwidth=78

        highlight TabLineSel term=bold,underline cterm=bold,underline ctermfg=7 ctermbg=0
        highlight TabLine    term=bold cterm=bold
        highlight clear TabLineFill

        " 狀態列設定
        " 狀態列位置, 當最近的窗口有狀態行時提示
        set laststatus=2
        " color: 0 灰 1 紅 2 綠 3 黃 4 藍 5 紫 6 青 7 白
        " style: underline / reverse / bold
        set statusline=%4*\ \ %8*[\ %1*%F
        set statusline+=%8*\ \|\ %5*%{&encoding}%8*\ \|
        set statusline+=%8*\ %7*%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}%8*\ ]
        set statusline+=%4*%=\ %8*[\ %2*(%l,%2*%c)%m%8*\ \|\ %9*%p%9*%%%8*\ ]%4*\ \ 
        highlight User4  term=bold      cterm=reverse           ctermfg=0
        highlight User8  term=underline cterm=bold              ctermfg=7
        highlight User6                                         ctermfg=7
        highlight User1  term=bold      cterm=bold,underline    ctermfg=1
        highlight User2  term=underline cterm=bold,underline    ctermfg=3
        highlight User3  term=bold      cterm=bold              ctermfg=0
        highlight User5  term=bold      cterm=bold,underline    ctermfg=2
        highlight User7  term=bold      cterm=bold,underline    ctermfg=4
        highlight User9  term=underline cterm=bold,underline    ctermfg=6

        set viminfo='20,\"50    " read/write a .viminfo file, don't store more

        " 顯示行號 關閉: nonumber
        set number
        " 調整行號數字寬
        set numberwidth=6

        " 設定 margin 顏色
        " ref: http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
        highlight ColorColumn ctermbg=236 guibg=#2c2d27
        " 設定 Right margin & after-margin
        set colorcolumn=80
        "let &colorcolumn="80,".join(range(120,999),",")

    " }}}

    " 特殊設定 {{{

        " 不產生.nu檔 <-> undofile 把撤銷信息寫入一個文件裡
        set noundofile
        " 最多可以撤銷的改變個數
        set undolevels=1000

    " }}}

    " 自動切換貼上模式
    " 可用於 Linux: gnome-terminal / Windows: 新版的 Putty / OSX: 終端機(Terminal)、iterm2
    " 若不適用 需以 :set paste / :set nopaste 切換
    if &term =~ "xterm.*"
        let &t_ti = &t_ti . "\e[?2004h"
        let &t_te = "\e[?2004l" . &t_te
        function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
        endfunction
        map <expr> <Esc>[200~ XTermPasteBegin("i")
        imap <expr> <Esc>[200~ XTermPasteBegin("")
        cmap <Esc>[200~ <nop>
        cmap <Esc>[201~ <nop>
    endif

    " 分頁標頭設定
    function MyTabLine()
        let s = ' Line '
        for i in range(tabpagenr('$'))
            " set thetabpagenumber (for  mouse clicks)
            "let s .= '%' . (i + 1) . 'T'
            let s .= ' %8*'
            let s .= i+1 . ':'
            let s .= '%3* '
            " select the highlighting
            if i + 1 == tabpagenr()
                " '%#TabLineSel#'
                let s .= '%2*'
            else
                " '%#TabLine#'
                let s .= '%3*'
            endif
            " the label is made by MyTabLabel()
            let s .= '%{MyTabLabel(' . (i + 1) . ')}'
            let s .= '%3* |'
         endfor
        " after the last tab fill with TabLineFill and reset tabpagenr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') == 1
            let s .= '%=%#TabLine#%999X'. '%8*[ ' . tabpagenr('$') . '  tab ]%  '
        else
            let s .= '%=%#TabLine#%999X'. '%8*[ ' . tabpagenr('$') . ' tabs ]%*  '
        endif
        return s
    endfunction

    function MyTabLabel(n)
        let buflist   = tabpagebuflist(a:n)
        let winnr     = tabpagewinnr(a:n)
        let alist     = split(bufname(buflist[winnr - 1]),'/')
        let shortname = ''
        let NoName = 1
        for ii in alist
            let shortname = ii
            let NoName = 0
        endfor
        if NoName == 1
            let shortname = '[No Name]'
        endif
        "return bufname(buflist[winnr - 1])
        return shortname
    endfunction

    " 檔案重新命名 in VIM
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
