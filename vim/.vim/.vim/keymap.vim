""""""""""""""""""""""""""""""""""""
"函数
"剪贴板
vmap <leader>y "+y
nnoremap <leader>p "+p
"打开最近位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 分屏窗口移动
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

""""""""""""""""""""""""""""""""""""""""""""
"快捷键配置
map S :w<CR>
map Q :q<CR>
map <leader>R :source $MYVIMRC<CR>
noremap <leader><CR> :nohlsearch<CR>
"noremap ff :NERDTreeToggle<CR>
nnoremap <C-s-tab> :PreviousBuffer<cr>
nnoremap <C-tab> :NextBuffer<cr>
nnoremap <leader>d :CloseCurrentBuffer<cr>
nnoremap <leader>D :BufOnly<cr>
nnoremap <Tab> za

"函数列表
nmap <F2> :TagbarToggle<CR>
nmap <C-Left> :vertical res -3<CR>
nmap <C-Right> :vertical res +3<CR>

"窗口大小
noremap <C-<> <C-w>5<
noremap <C->> <C-w>5>

"函数折叠
noremap zo zO

"拼写检查
map <leader>ss :set spell!<CR>
noremap <C-x> ea<C-x>s


"保存管理员权限文件
noremap <leader>S :w! sudo tee %<CR>

" commont
vnoremap <silent> gc V{:call nerdcommenter#Comment('x', 'toggle')<CR>
nnoremap <silent> gc V{:call nerdcommenter#Comment('x', 'toggle')<CR>

" vim-buffer
nnoremap <silent> <s-e> :PreviousBuffer<cr>
nnoremap <silent> <s-r> :NextBuffer<cr>
nnoremap <silent> <s-x> :CloseBuffer<cr>
nnoremap <silent> <leader>D :BufOnly<cr>

" 翻译
nmap <silent> L <Plug>Translate
vmap <silent> L <Plug>TranslateV

inoremap jk <ESC>
