		"========My Vim Configuration========"

"basic{{{
set number                  "设置行号
set relativenumber 	    "相对行号
syntax on                   "语法高亮
set cursorline              "突出显示当前行
let mapleader="\<space>"    "使用空格作为先导
set foldenable              "启动折叠
set foldmethod=marker       "marker的折叠模式
set nocompatible            "不启用vi
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set fileencoding=utf-8
set encoding=utf-8
set timeoutlen=500
set autoindent
set expandtab
set clipboard+=unnamedplus
let g:c_syntax_for_h = 1    " *.h filetype is c not cpp
set exrc
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>i
inoremap <Right> <ESC>:echoe "Use l"<CR>i
inoremap <Up>    <ESC>:echoe "Use k"<CR>i
inoremap <Down>  <ESC>:echoe "Use j"<CR>i

augroup yankGrp
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank()
augroup END
"}}}

"keymap {{{
nnoremap <silent> <Leader>vr :exe 'edit '.stdpath('config').'/init.vim'<CR>
nnoremap <silent> <Leader>so :exe 'so '.stdpath('config').'/init.vim'<CR>
nnoremap <silent> <Leader>pi :exe 'edit '.stdpath('config').'/lua/plugins.lua'<CR>
nnoremap <silent> <Leader>ls :exe 'edit '.stdpath('config').'/lua/lsp/init.lua'<CR>
nnoremap <Leader>bd :call CheckDelete()<CR>
nnoremap <Leader>bw :w<CR>
nnoremap <Leader>hc :noh<CR>
nnoremap <Leader>w  *N
nnoremap <Leader>ra :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>ps :call ProfileStart()<CR>
nnoremap <leader>pt :profile stop
nnoremap <leader>fp :call FoldPair()<CR>
function! CheckDelete()"{{{
    if &modified
        write
        bd
    else
        bd
    endif
endfunction"}}}
function! ProfileStart()
    profile start profile.log
    profile func *
    profile file *
endfunction
function! FoldPair()
    let l:high=line(".")
    normal %
    let l:low=line(".")
    normal %
    if l:high > l:low
        let l:tmp = l:low
        let l:low = l:high
        let l:high = l:tmp
    endif
    exec l:high.",".l:low."fold"
endfunction

"}}}

"plugin{{{
:lua require('plugins')
"}}}

" input methor
function! SetUsLayout() ""
  silent !qdbus org.kde.keyboard /Layouts setLayout us > /dev/null
endfunction
autocmd InsertLeave * call SetUsLayout()
let g:tex_flavor = "latex"
