let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <nowait> <silent> <expr> <BS> coc#_insert_key('request', 'i-PGJzPg==', 0)
inoremap <silent> <Plug>NERDCommenterInsert :call nerdcommenter#Comment('i', "Insert")
inoremap <silent> <SNR>77_AutoPairsReturn =AutoPairsReturn()
inoremap <silent> <expr> <PageUp> coc#pum#visible() ? coc#pum#scroll(0) : "\<PageUp>"
inoremap <silent> <expr> <PageDown> coc#pum#visible() ? coc#pum#scroll(1) : "\<PageDown>"
inoremap <silent> <expr> <C-Y> coc#pum#visible() ? coc#pum#confirm() : "\"
inoremap <silent> <expr> <C-E> coc#pum#visible() ? coc#pum#cancel() : "\"
inoremap <silent> <expr> <Up> coc#pum#visible() ? coc#pum#prev(0) : "\<Up>"
inoremap <silent> <expr> <Down> coc#pum#visible() ? coc#pum#next(0) : "\<Down>"
inoremap <silent> <expr> <C-P> coc#pum#visible() ? coc#pum#prev(1) : "\"
inoremap <silent> <expr> <C-N> coc#pum#visible() ? coc#pum#next(1) : "\"
inoremap <silent> <expr> <Plug>delimitMateS-BS delimitMate#WithinEmptyPair() ? "\<Del>" : "\<S-BS>"
inoremap <silent> <Plug>delimitMateBS =delimitMate#BS()
imap <C-G>S <Plug>ISurround
imap <C-G>s <Plug>Isurround
imap <C-S> <Plug>Isurround
inoremap <nowait> <silent> <expr> <C-B> coc#float#has_scroll() ? "\=coc#float#scroll(0)\" : "\<Left>"
inoremap <nowait> <silent> <expr> <C-F> coc#float#has_scroll() ? "\=coc#float#scroll(1)\" : "\<Right>"
inoremap <silent> <expr> <C-@> coc#refresh()
inoremap <silent> <expr> <Nul> coc#refresh()
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\"
vnoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? coc#float#scroll(0) : "\"
nnoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? coc#float#scroll(0) : "\"
vnoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? coc#float#scroll(1) : "\"
nnoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? coc#float#scroll(1) : "\"
nnoremap  h
nnoremap 	 za
nnoremap <NL> j
nnoremap  k
nnoremap  l
xmap <silent>  <Plug>(coc-range-select)
nmap <silent>  <Plug>(coc-range-select)
noremap  eas
nnoremap <nowait> <silent>  :FloatermToggle
nmap  ca <Plug>NERDCommenterAltDelims
xmap  cu <Plug>NERDCommenterUncomment
nmap  cu <Plug>NERDCommenterUncomment
xmap  cb <Plug>NERDCommenterAlignBoth
nmap  cb <Plug>NERDCommenterAlignBoth
xmap  cl <Plug>NERDCommenterAlignLeft
nmap  cA <Plug>NERDCommenterAppend
xmap  cy <Plug>NERDCommenterYank
nmap  cy <Plug>NERDCommenterYank
xmap  cs <Plug>NERDCommenterSexy
nmap  cs <Plug>NERDCommenterSexy
xmap  ci <Plug>NERDCommenterInvert
nmap  ci <Plug>NERDCommenterInvert
nmap  c$ <Plug>NERDCommenterToEOL
xmap  cn <Plug>NERDCommenterNested
nmap  cn <Plug>NERDCommenterNested
xmap  cm <Plug>NERDCommenterMinimal
nmap  cm <Plug>NERDCommenterMinimal
xmap  c  <Plug>NERDCommenterToggle
nmap  c  <Plug>NERDCommenterToggle
xmap  cc <Plug>NERDCommenterComment
nmap  cc <Plug>NERDCommenterComment
nnoremap <nowait> <silent>  k :CocPrev
nnoremap <nowait> <silent>  j :CocNext
nnoremap <nowait> <silent>  s :CocList -I symbols
nnoremap <nowait> <silent>  o :CocList outline
nnoremap <nowait> <silent>  c :CocList commands
nnoremap <nowait> <silent>  e :CocList extensions
nmap  cl <Plug>NERDCommenterAlignLeft
nmap <silent>  r <Plug>(coc-codeaction-refactor-selected)
xmap <silent>  r <Plug>(coc-codeaction-refactor-selected)
nmap <silent>  re <Plug>(coc-codeaction-refactor)
nmap  qf <Plug>(coc-fix-current)
nmap  as <Plug>(coc-codeaction-source)
nmap  ac <Plug>(coc-codeaction-cursor)
nnoremap <nowait> <silent>  a :CocList diagnostics
xmap  a <Plug>(coc-codeaction-selected)
nmap  f <Plug>(coc-format-selected)
xmap  f <Plug>(coc-format-selected)
nmap  rn <Plug>(coc-rename)
noremap  S :w! sudo tee %
map  ss :set spell!
nnoremap <silent>  D :BufOnly
nnoremap  d :CloseCurrentBuffer
noremap   :nohlsearch
map  R :source $MYVIMRC
nnoremap <nowait> <silent>  p :CocListResume
vmap  y "+y
nmap <silent> - <Plug>(coc-diagnostic-prev)
nmap <silent> = <Plug>(coc-diagnostic-next)
nnoremap <silent> E :PreviousBuffer
nnoremap <silent> K :call ShowDocumentation()
vmap <silent> L <Plug>TranslateV
nmap <silent> L <Plug>Translate
map Q :q
nnoremap <silent> R :NextBuffer
xmap S <Plug>VSurround
nmap S :w
smap S :w
omap S :w
nnoremap <silent> X :CloseBuffer
omap ac <Plug>(coc-classobj-a)
xmap ac <Plug>(coc-classobj-a)
omap af <Plug>(coc-funcobj-a)
xmap af <Plug>(coc-funcobj-a)
nmap cS <Plug>CSurround
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
nnoremap ff :CocCommand explorer
xmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
xmap gS <Plug>VgSurround
nmap <silent> gh <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gc V{:call nerdcommenter#Comment('x', 'toggle')
vnoremap <silent> gc V{:call nerdcommenter#Comment('x', 'toggle')
omap ic <Plug>(coc-classobj-i)
xmap ic <Plug>(coc-classobj-i)
omap if <Plug>(coc-funcobj-i)
xmap if <Plug>(coc-funcobj-i)
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
noremap zo zO
vnoremap <silent> <Plug>(coc-explorer-key-v-ai) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-ai'])
vnoremap <silent> <Plug>(coc-explorer-key-v-ii) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-ii'])
vnoremap <silent> <Plug>(coc-explorer-key-v-al) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-al'])
vnoremap <silent> <Plug>(coc-explorer-key-v->>) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v->>'])
vnoremap <silent> <Plug>(coc-explorer-key-v-<<) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-<<'])
vnoremap <silent> <Plug>(coc-explorer-key-v-]C) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-]C'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[C) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[C'])
vnoremap <silent> <Plug>(coc-explorer-key-v-]c) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-]c'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[c) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[c'])
vnoremap <silent> <Plug>(coc-explorer-key-v-]D) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-]D'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[D) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[D'])
vnoremap <silent> <Plug>(coc-explorer-key-v-]d) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-]d'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[d) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[d'])
vnoremap <silent> <Plug>(coc-explorer-key-v-]m) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-]m'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[m) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[m'])
vnoremap <silent> <Plug>(coc-explorer-key-v-]i) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-]i'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[i) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[i'])
vnoremap <silent> <Plug>(coc-explorer-key-v-]]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-]]'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[[) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[['])
vnoremap <silent> <Plug>(coc-explorer-key-v-gb) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-gb'])
vnoremap <silent> <Plug>(coc-explorer-key-v-gf) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-gf'])
vnoremap <silent> <Plug>(coc-explorer-key-v-F) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-F'])
vnoremap <silent> <Plug>(coc-explorer-key-v-f) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-f'])
vnoremap <silent> <Plug>(coc-explorer-key-v-gd) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-gd'])
vnoremap <silent> <Plug>(coc-explorer-key-v-X) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-X'])
vnoremap <silent> <Plug>(coc-explorer-key-v-q) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-q'])
vnoremap <silent> <Plug>(coc-explorer-key-v-?) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-?'])
vnoremap <silent> <Plug>(coc-explorer-key-v-R) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-R'])
vnoremap <silent> <Plug>(coc-explorer-key-v-g.) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-g.'])
vnoremap <silent> <Plug>(coc-explorer-key-v-zh) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-zh'])
vnoremap <silent> <Plug>(coc-explorer-key-v-r) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-r'])
vnoremap <silent> <Plug>(coc-explorer-key-v-A) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-A'])
vnoremap <silent> <Plug>(coc-explorer-key-v-a) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-a'])
vnoremap <silent> <Plug>(coc-explorer-key-v-dF) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-dF'])
vnoremap <silent> <Plug>(coc-explorer-key-v-df) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-df'])
vnoremap <silent> <Plug>(coc-explorer-key-v-P) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-P'])
vnoremap <silent> <Plug>(coc-explorer-key-v-p) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-p'])
vnoremap <silent> <Plug>(coc-explorer-key-v-d[space]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-d[space]'])
vnoremap <silent> <Plug>(coc-explorer-key-v-da) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-da'])
vnoremap <silent> <Plug>(coc-explorer-key-v-dt) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-dt'])
vnoremap <silent> <Plug>(coc-explorer-key-v-dd) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-dd'])
vnoremap <silent> <Plug>(coc-explorer-key-v-y[space]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-y[space]'])
vnoremap <silent> <Plug>(coc-explorer-key-v-ya) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-ya'])
vnoremap <silent> <Plug>(coc-explorer-key-v-yt) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-yt'])
vnoremap <silent> <Plug>(coc-explorer-key-v-yy) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-yy'])
vnoremap <silent> <Plug>(coc-explorer-key-v-yn) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-yn'])
vnoremap <silent> <Plug>(coc-explorer-key-v-yp) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-yp'])
vnoremap <silent> <Plug>(coc-explorer-key-v-II) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-II'])
vnoremap <silent> <Plug>(coc-explorer-key-v-Ic) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-Ic'])
vnoremap <silent> <Plug>(coc-explorer-key-v-Il) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-Il'])
vnoremap <silent> <Plug>(coc-explorer-key-v-ic) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-ic'])
vnoremap <silent> <Plug>(coc-explorer-key-v-il) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-il'])
vnoremap <silent> <Plug>(coc-explorer-key-v-gs) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-gs'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[bs]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[bs]'])
vnoremap <silent> <Plug>(coc-explorer-key-v-t) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-t'])
vnoremap <silent> <Plug>(coc-explorer-key-v-E) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-E'])
vnoremap <silent> <Plug>(coc-explorer-key-v-s) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-s'])
vnoremap <silent> <Plug>(coc-explorer-key-v-e) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-e'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[cr]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[cr]'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[2-LeftMouse]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[2-LeftMouse]'])
vnoremap <silent> <Plug>(coc-explorer-key-v-gh) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-gh'])
vnoremap <silent> <Plug>(coc-explorer-key-v-gl) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-gl'])
vnoremap <silent> <Plug>(coc-explorer-key-v-K) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-K'])
vnoremap <silent> <Plug>(coc-explorer-key-v-J) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-J'])
vnoremap <silent> <Plug>(coc-explorer-key-v-l) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-l'])
vnoremap <silent> <Plug>(coc-explorer-key-v-h) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-h'])
vnoremap <silent> <Plug>(coc-explorer-key-v-[tab]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-[tab]'])
vnoremap <silent> <Plug>(coc-explorer-key-v-*) :call coc#rpc#request('doKeymap', ['coc-explorer-key-v-*'])
nnoremap <silent> <Plug>(coc-explorer-key-n->>) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n->>'])
nnoremap <silent> <Plug>(coc-explorer-key-n-<<) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-<<'])
nnoremap <silent> <Plug>(coc-explorer-key-n-]C) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-]C'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[C) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[C'])
nnoremap <silent> <Plug>(coc-explorer-key-n-]c) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-]c'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[c) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[c'])
nnoremap <silent> <Plug>(coc-explorer-key-n-]D) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-]D'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[D) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[D'])
nnoremap <silent> <Plug>(coc-explorer-key-n-]d) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-]d'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[d) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[d'])
nnoremap <silent> <Plug>(coc-explorer-key-n-]m) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-]m'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[m) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[m'])
nnoremap <silent> <Plug>(coc-explorer-key-n-]i) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-]i'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[i) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[i'])
nnoremap <silent> <Plug>(coc-explorer-key-n-]]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-]]'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[[) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[['])
nnoremap <silent> <Plug>(coc-explorer-key-n-gb) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-gb'])
nnoremap <silent> <Plug>(coc-explorer-key-n-gf) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-gf'])
nnoremap <silent> <Plug>(coc-explorer-key-n-F) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-F'])
nnoremap <silent> <Plug>(coc-explorer-key-n-f) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-f'])
nnoremap <silent> <Plug>(coc-explorer-key-n-gd) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-gd'])
nnoremap <silent> <Plug>(coc-explorer-key-n-X) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-X'])
nnoremap <silent> <Plug>(coc-explorer-key-n-q) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-q'])
nnoremap <silent> <Plug>(coc-explorer-key-n-?) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-?'])
nnoremap <silent> <Plug>(coc-explorer-key-n-R) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-R'])
nnoremap <silent> <Plug>(coc-explorer-key-n-g.) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-g.'])
nnoremap <silent> <Plug>(coc-explorer-key-n-zh) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-zh'])
nnoremap <silent> <Plug>(coc-explorer-key-n-r) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-r'])
nnoremap <silent> <Plug>(coc-explorer-key-n-A) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-A'])
nnoremap <silent> <Plug>(coc-explorer-key-n-a) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-a'])
nnoremap <silent> <Plug>(coc-explorer-key-n-dF) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-dF'])
nnoremap <silent> <Plug>(coc-explorer-key-n-df) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-df'])
nnoremap <silent> <Plug>(coc-explorer-key-n-P) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-P'])
nnoremap <silent> <Plug>(coc-explorer-key-n-p) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-p'])
nnoremap <silent> <Plug>(coc-explorer-key-n-d[space]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-d[space]'])
nnoremap <silent> <Plug>(coc-explorer-key-n-da) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-da'])
nnoremap <silent> <Plug>(coc-explorer-key-n-dt) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-dt'])
nnoremap <silent> <Plug>(coc-explorer-key-n-dd) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-dd'])
nnoremap <silent> <Plug>(coc-explorer-key-n-y[space]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-y[space]'])
nnoremap <silent> <Plug>(coc-explorer-key-n-ya) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-ya'])
nnoremap <silent> <Plug>(coc-explorer-key-n-yt) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-yt'])
nnoremap <silent> <Plug>(coc-explorer-key-n-yy) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-yy'])
nnoremap <silent> <Plug>(coc-explorer-key-n-yn) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-yn'])
nnoremap <silent> <Plug>(coc-explorer-key-n-yp) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-yp'])
nnoremap <silent> <Plug>(coc-explorer-key-n-II) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-II'])
nnoremap <silent> <Plug>(coc-explorer-key-n-Ic) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-Ic'])
nnoremap <silent> <Plug>(coc-explorer-key-n-Il) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-Il'])
nnoremap <silent> <Plug>(coc-explorer-key-n-ic) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-ic'])
nnoremap <silent> <Plug>(coc-explorer-key-n-il) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-il'])
nnoremap <silent> <Plug>(coc-explorer-key-n-gs) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-gs'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[bs]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[bs]'])
nnoremap <silent> <Plug>(coc-explorer-key-n-t) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-t'])
nnoremap <silent> <Plug>(coc-explorer-key-n-E) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-E'])
nnoremap <silent> <Plug>(coc-explorer-key-n-s) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-s'])
nnoremap <silent> <Plug>(coc-explorer-key-n-e) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-e'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[cr]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[cr]'])
nnoremap <silent> <Plug>(coc-explorer-key-n-o) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-o'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[2-LeftMouse]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[2-LeftMouse]'])
nnoremap <silent> <Plug>(coc-explorer-key-n-gh) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-gh'])
nnoremap <silent> <Plug>(coc-explorer-key-n-gl) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-gl'])
nnoremap <silent> <Plug>(coc-explorer-key-n-K) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-K'])
nnoremap <silent> <Plug>(coc-explorer-key-n-J) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-J'])
nnoremap <silent> <Plug>(coc-explorer-key-n-l) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-l'])
nnoremap <silent> <Plug>(coc-explorer-key-n-h) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-h'])
nnoremap <silent> <Plug>(coc-explorer-key-n-[tab]) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-[tab]'])
nnoremap <silent> <Plug>(coc-explorer-key-n-*) :call coc#rpc#request('doKeymap', ['coc-explorer-key-n-*'])
xnoremap <silent> <Plug>(coc-git-chunk-outer) :call coc#rpc#request('doKeymap', ['coc-git-chunk-outer'])
onoremap <silent> <Plug>(coc-git-chunk-outer) :call coc#rpc#request('doKeymap', ['coc-git-chunk-outer'])
xnoremap <silent> <Plug>(coc-git-chunk-inner) :call coc#rpc#request('doKeymap', ['coc-git-chunk-inner'])
onoremap <silent> <Plug>(coc-git-chunk-inner) :call coc#rpc#request('doKeymap', ['coc-git-chunk-inner'])
nnoremap <silent> <Plug>(coc-git-showblamedoc) :call coc#rpc#notify('doKeymap', ['coc-git-showblamedoc'])
nnoremap <silent> <Plug>(coc-git-commit) :call coc#rpc#notify('doKeymap', ['coc-git-commit'])
nnoremap <silent> <Plug>(coc-git-chunkinfo) :call coc#rpc#notify('doKeymap', ['coc-git-chunkinfo'])
nnoremap <silent> <Plug>(coc-git-keepboth) :call coc#rpc#notify('doKeymap', ['coc-git-keepboth'])
nnoremap <silent> <Plug>(coc-git-keepincoming) :call coc#rpc#notify('doKeymap', ['coc-git-keepincoming'])
nnoremap <silent> <Plug>(coc-git-keepcurrent) :call coc#rpc#notify('doKeymap', ['coc-git-keepcurrent'])
nnoremap <silent> <Plug>(coc-git-prevconflict) :call coc#rpc#notify('doKeymap', ['coc-git-prevconflict'])
nnoremap <silent> <Plug>(coc-git-nextconflict) :call coc#rpc#notify('doKeymap', ['coc-git-nextconflict'])
nnoremap <silent> <Plug>(coc-git-prevchunk) :call coc#rpc#notify('doKeymap', ['coc-git-prevchunk'])
nnoremap <silent> <Plug>(coc-git-nextchunk) :call coc#rpc#notify('doKeymap', ['coc-git-nextchunk'])
nnoremap <silent> <Plug>(coc-terminal-toggle) :call coc#rpc#notify('doKeymap', ['coc-terminal-toggle'])
vnoremap <silent> <Plug>(coc-codegeex-translate-keymap) :call coc#rpc#notify('doKeymap', ['coc-codegeex-translate-keymap'])
xnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
tnoremap <silent> <Plug>(fzf-normal) 
tnoremap <silent> <Plug>(fzf-insert) i
nnoremap <silent> <Plug>(fzf-normal) <Nop>
nnoremap <silent> <Plug>(fzf-insert) i
nnoremap <silent> <Plug>(accelerated_jk_k_position) :call accelerated#position_driven#command('k')
nnoremap <silent> <Plug>(accelerated_jk_j_position) :call accelerated#position_driven#command('j')
nnoremap <silent> <Plug>(accelerated_jk_gk_position) :call accelerated#position_driven#command('gk')
nnoremap <silent> <Plug>(accelerated_jk_gj_position) :call accelerated#position_driven#command('gj')
nnoremap <silent> <Plug>(accelerated_jk_k) :call accelerated#time_driven#command('k')
nnoremap <silent> <Plug>(accelerated_jk_j) :call accelerated#time_driven#command('j')
nnoremap <silent> <Plug>(accelerated_jk_gk) :call accelerated#time_driven#command('gk')
nnoremap <silent> <Plug>(accelerated_jk_gj) :call accelerated#time_driven#command('gj')
nnoremap <Plug>NERDCommenterAltDelims :call nerdcommenter#SwitchToAlternativeDelimiters(1)
xnoremap <silent> <Plug>NERDCommenterUncomment :call nerdcommenter#Comment("x", "Uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call nerdcommenter#Comment("n", "Uncomment")
xnoremap <silent> <Plug>NERDCommenterAlignBoth :call nerdcommenter#Comment("x", "AlignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call nerdcommenter#Comment("n", "AlignBoth")
xnoremap <silent> <Plug>NERDCommenterAlignLeft :call nerdcommenter#Comment("x", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call nerdcommenter#Comment("n", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAppend :call nerdcommenter#Comment("n", "Append")
xnoremap <silent> <Plug>NERDCommenterYank :call nerdcommenter#Comment("x", "Yank")
nnoremap <silent> <Plug>NERDCommenterYank :call nerdcommenter#Comment("n", "Yank")
xnoremap <silent> <Plug>NERDCommenterSexy :call nerdcommenter#Comment("x", "Sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call nerdcommenter#Comment("n", "Sexy")
xnoremap <silent> <Plug>NERDCommenterInvert :call nerdcommenter#Comment("x", "Invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call nerdcommenter#Comment("n", "Invert")
nnoremap <silent> <Plug>NERDCommenterToEOL :call nerdcommenter#Comment("n", "ToEOL")
xnoremap <silent> <Plug>NERDCommenterNested :call nerdcommenter#Comment("x", "Nested")
nnoremap <silent> <Plug>NERDCommenterNested :call nerdcommenter#Comment("n", "Nested")
xnoremap <silent> <Plug>NERDCommenterMinimal :call nerdcommenter#Comment("x", "Minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call nerdcommenter#Comment("n", "Minimal")
xnoremap <silent> <Plug>NERDCommenterToggle :call nerdcommenter#Comment("x", "Toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call nerdcommenter#Comment("n", "Toggle")
xnoremap <silent> <Plug>NERDCommenterComment :call nerdcommenter#Comment("x", "Comment")
nnoremap <silent> <Plug>NERDCommenterComment :call nerdcommenter#Comment("n", "Comment")
nnoremap <silent> <Plug>TranslateX :TranslateX
vnoremap <silent> <Plug>TranslateRV :TranslateR
nnoremap <silent> <Plug>TranslateR viw:TranslateR
vnoremap <silent> <Plug>TranslateWV :TranslateW
nnoremap <silent> <Plug>TranslateW :TranslateW
vnoremap <silent> <Plug>TranslateV :Translate
nnoremap <silent> <Plug>Translate :Translate
onoremap <silent> <Plug>(coc-classobj-a) :call CocAction('selectSymbolRange', v:false, '', ['Interface', 'Struct', 'Class'])
onoremap <silent> <Plug>(coc-classobj-i) :call CocAction('selectSymbolRange', v:true, '', ['Interface', 'Struct', 'Class'])
vnoremap <silent> <Plug>(coc-classobj-a) :call CocAction('selectSymbolRange', v:false, visualmode(), ['Interface', 'Struct', 'Class'])
vnoremap <silent> <Plug>(coc-classobj-i) :call CocAction('selectSymbolRange', v:true, visualmode(), ['Interface', 'Struct', 'Class'])
onoremap <silent> <Plug>(coc-funcobj-a) :call CocAction('selectSymbolRange', v:false, '', ['Method', 'Function'])
onoremap <silent> <Plug>(coc-funcobj-i) :call CocAction('selectSymbolRange', v:true, '', ['Method', 'Function'])
vnoremap <silent> <Plug>(coc-funcobj-a) :call CocAction('selectSymbolRange', v:false, visualmode(), ['Method', 'Function'])
vnoremap <silent> <Plug>(coc-funcobj-i) :call CocAction('selectSymbolRange', v:true, visualmode(), ['Method', 'Function'])
nnoremap <silent> <Plug>(coc-cursors-position) :call CocAction('cursorsSelect', bufnr('%'), 'position', 'n')
nnoremap <silent> <Plug>(coc-cursors-word) :call CocAction('cursorsSelect', bufnr('%'), 'word', 'n')
vnoremap <silent> <Plug>(coc-cursors-range) :call CocAction('cursorsSelect', bufnr('%'), 'range', visualmode())
nnoremap <silent> <Plug>(coc-refactor) :call       CocActionAsync('refactor')
nnoremap <silent> <Plug>(coc-command-repeat) :call       CocAction('repeatCommand')
nnoremap <silent> <Plug>(coc-float-jump) :call       coc#float#jump()
nnoremap <silent> <Plug>(coc-float-hide) :call       coc#float#close_all()
nnoremap <silent> <Plug>(coc-fix-current) :call       CocActionAsync('doQuickfix')
nnoremap <silent> <Plug>(coc-openlink) :call       CocActionAsync('openLink')
nnoremap <silent> <Plug>(coc-references-used) :call       CocActionAsync('jumpUsed')
nnoremap <silent> <Plug>(coc-references) :call       CocActionAsync('jumpReferences')
nnoremap <silent> <Plug>(coc-type-definition) :call       CocActionAsync('jumpTypeDefinition')
nnoremap <silent> <Plug>(coc-implementation) :call       CocActionAsync('jumpImplementation')
nnoremap <silent> <Plug>(coc-declaration) :call       CocActionAsync('jumpDeclaration')
nnoremap <silent> <Plug>(coc-definition) :call       CocActionAsync('jumpDefinition')
nnoremap <silent> <Plug>(coc-diagnostic-prev-error) :call       CocActionAsync('diagnosticPrevious', 'error')
nnoremap <silent> <Plug>(coc-diagnostic-next-error) :call       CocActionAsync('diagnosticNext',     'error')
nnoremap <silent> <Plug>(coc-diagnostic-prev) :call       CocActionAsync('diagnosticPrevious')
nnoremap <silent> <Plug>(coc-diagnostic-next) :call       CocActionAsync('diagnosticNext')
nnoremap <silent> <Plug>(coc-diagnostic-info) :call       CocActionAsync('diagnosticInfo')
nnoremap <silent> <Plug>(coc-format) :call       CocActionAsync('format')
nnoremap <silent> <Plug>(coc-rename) :call       CocActionAsync('rename')
nnoremap <Plug>(coc-codeaction-source) :call       CocActionAsync('codeAction', '', ['source'], v:true)
nnoremap <Plug>(coc-codeaction-refactor) :call       CocActionAsync('codeAction', 'cursor', ['refactor'], v:true)
nnoremap <Plug>(coc-codeaction-cursor) :call       CocActionAsync('codeAction', 'cursor')
nnoremap <Plug>(coc-codeaction-line) :call       CocActionAsync('codeAction', 'currline')
nnoremap <Plug>(coc-codeaction) :call       CocActionAsync('codeAction', '')
vnoremap <Plug>(coc-codeaction-refactor-selected) :call       CocActionAsync('codeAction', visualmode(), ['refactor'], v:true)
vnoremap <silent> <Plug>(coc-codeaction-selected) :call       CocActionAsync('codeAction', visualmode())
vnoremap <silent> <Plug>(coc-format-selected) :call       CocActionAsync('formatSelected', visualmode())
nnoremap <Plug>(coc-codelens-action) :call       CocActionAsync('codeLensAction')
nnoremap <Plug>(coc-range-select) :call       CocActionAsync('rangeSelect',     '', v:true)
vnoremap <silent> <Plug>(coc-range-select-backward) :call       CocActionAsync('rangeSelect',     visualmode(), v:false)
vnoremap <silent> <Plug>(coc-range-select) :call       CocActionAsync('rangeSelect',     visualmode(), v:true)
nnoremap <silent> <Plug>(startify-open-buffers) :call startify#open_buffers()
nnoremap <silent> <Plug>SurroundRepeat .
nnoremap <nowait> <silent> <C-Bslash> :FloatermToggle
xmap <silent> <C-S> <Plug>(coc-range-select)
nmap <silent> <C-S> <Plug>(coc-range-select)
vnoremap <nowait> <silent> <expr> <C-B> coc#float#has_scroll() ? coc#float#scroll(0) : "\"
vnoremap <nowait> <silent> <expr> <C-F> coc#float#has_scroll() ? coc#float#scroll(1) : "\"
nnoremap <nowait> <silent> <expr> <C-B> coc#float#has_scroll() ? coc#float#scroll(0) : "\"
nnoremap <nowait> <silent> <expr> <C-F> coc#float#has_scroll() ? coc#float#scroll(1) : "\"
noremap <C-X> eas
noremap <C->> 5>
noremap <C-lt> 5<
nmap <C-Right> :vertical res +3
nmap <C-Left> :vertical res -3
nmap <F2> :TagbarToggle
nnoremap <C-Tab> :NextBuffer
nnoremap <C-S-Tab> :PreviousBuffer
nnoremap <C-L> l
nnoremap <C-H> h
nnoremap <C-K> k
nnoremap <C-J> j
inoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? "\=coc#float#scroll(0)\" : "\<Left>"
inoremap <silent> <expr>  coc#pum#visible() ? coc#pum#cancel() : "\"
inoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? "\=coc#float#scroll(1)\" : "\<Right>"
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap <silent> <expr> 	 coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\	" : coc#refresh()
inoremap <silent> <expr>  coc#pum#visible() ? coc#pum#confirm(): "\u\\=coc#on_enter()\"
inoremap <silent> <expr>  coc#pum#visible() ? coc#pum#next(1) : "\"
inoremap <silent> <expr>  coc#pum#visible() ? coc#pum#prev(1) : "\"
imap  <Plug>Isurround
inoremap <silent> <expr>  coc#pum#visible() ? coc#pum#confirm() : "\"
inoremap <nowait> <silent> <expr> " coc#_insert_key('request', 'i-Ig==', 1)
inoremap <nowait> <silent> <expr> ' coc#_insert_key('request', 'i-Jw==', 1)
inoremap <nowait> <silent> <expr> ( coc#_insert_key('request', 'i-KA==', 1)
inoremap <nowait> <silent> <expr> ) coc#_insert_key('request', 'i-KQ==', 1)
inoremap <nowait> <silent> <expr> < coc#_insert_key('request', 'i-PA==', 1)
inoremap <nowait> <silent> <expr> > coc#_insert_key('request', 'i-Pg==', 1)
inoremap <nowait> <silent> <expr> [ coc#_insert_key('request', 'i-Ww==', 1)
inoremap <nowait> <silent> <expr> ] coc#_insert_key('request', 'i-XQ==', 1)
inoremap <nowait> <silent> <expr> ` coc#_insert_key('request', 'i-YA==', 1)
inoremap jk 
inoremap <nowait> <silent> <expr> { coc#_insert_key('request', 'i-ew==', 1)
inoremap <nowait> <silent> <expr> } coc#_insert_key('request', 'i-fQ==', 1)
let &cpo=s:cpo_save
unlet s:cpo_save
set autoread
set autowrite
set background=dark
set backspace=indent,eol,start
set backupdir=~/.cache/vim/backup//
set directory=~/.cache/vim/swap//
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
set foldlevelstart=99
set helplang=cn
set hlsearch
set ignorecase
set incsearch
set langmenu=zh_CN.UTF-8
set laststatus=2
set mouse=a
set ruler
set runtimepath=~/.vim,~/.vim/plugged/vim-surround,~/.vim/plugged/ack.vim,~/.vim/plugged/delimitMate,~/.vim/plugged/change-colorscheme,~/.vim/plugged/vim-buffer,~/.vim/plugged/vimplus-startify,~/.vim/plugged/coc.nvim,~/.vim/plugged/vim-go,~/.vim/plugged/vim-floaterm,~/.vim/plugged/nerdtree,~/.vim/plugged/vim-devicons,~/.vim/plugged/vim-airline,~/.vim/plugged/vim-airline-themes,~/.vim/plugged/indentLine,~/.vim/plugged/rainbow_parentheses.vim,~/.vim/plugged/catppuccin,~/.vim/plugged/vim-hlchunk,~/.vim/plugged/vim-translator,~/.vim/plugged/goyo.vim,~/.vim/plugged/vim-projectroot,~/.vim/plugged/tagbar,~/.vim/plugged/auto-pairs,~/.vim/plugged/nerdcommenter,~/.vim/plugged/accelerated-jk,~/.vim/plugged/vim-tmux-focus-events,~/.vim/plugged/vim-tmux-clipboard,/usr/share/vim/vimfiles,/usr/share/vim/vim91,/usr/share/vim/vimfiles/after,~/.vim/plugged/indentLine/after,~/.vim/after,~/.config/coc/extensions/node_modules/coc-explorer
set scrolloff=5
set shortmess=filnxtToOSc
set showcmd
set showtabline=2
set softtabstop=8
set statusline=%{coc#status()}%{get(b:,'coc_current_function','')}
set suffixes=.bak,~,.o,.info,.swp,.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set noswapfile
set tabline=%!airline#extensions#tabline#get()
set termencoding=utf-8
set termguicolors
set undodir=~/.cache/vim/undo//
set updatetime=300
set virtualedit=block,onemore
set wildmenu
set nowritebackup
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/dotfile
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
argglobal
%argdel
edit Startify
argglobal
let s:cpo_save=&cpo
set cpo&vim
imap <buffer> <silent> <C-G>g <Plug>delimitMateJumpMany
imap <buffer> <S-BS> <Plug>delimitMateS-BS
inoremap <buffer> <silent> <M-n> :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> <M-p> AutoPairsToggle()
inoremap <buffer> <silent> <M-b> =AutoPairsBackInsert()
inoremap <buffer> <silent> <M-e> =AutoPairsFastWrap()
inoremap <buffer> <silent> <M-'> =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> <M-"> =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> <M-}> =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> <M-{> =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> <M-]> =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> <M-[> =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> <M-)> =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> <M-(> =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> <C-H> =AutoPairsDelete()
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
nnoremap <buffer> <nowait> <silent>  :call startify#open_buffers()
nnoremap <buffer> <silent> 0 :call startify#open_buffers('15')
nnoremap <buffer> <silent> 11 :call startify#open_buffers('29')
nnoremap <buffer> <silent> 10 :call startify#open_buffers('28')
nnoremap <buffer> <silent> 16 :call startify#open_buffers('34')
nnoremap <buffer> <silent> 15 :call startify#open_buffers('33')
nnoremap <buffer> <silent> 14 :call startify#open_buffers('32')
nnoremap <buffer> <silent> 13 :call startify#open_buffers('31')
nnoremap <buffer> <silent> 12 :call startify#open_buffers('30')
nnoremap <buffer> <silent> 1 :call startify#open_buffers('16')
nnoremap <buffer> <silent> 2 :call startify#open_buffers('17')
nnoremap <buffer> <silent> 3 :call startify#open_buffers('18')
nnoremap <buffer> <silent> 4 :call startify#open_buffers('19')
nnoremap <buffer> <silent> 5 :call startify#open_buffers('20')
nnoremap <buffer> <silent> 6 :call startify#open_buffers('21')
nnoremap <buffer> <silent> 7 :call startify#open_buffers('22')
nnoremap <buffer> <silent> 8 :call startify#open_buffers('23')
nnoremap <buffer> <silent> 9 :call startify#open_buffers('24')
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> â =AutoPairsBackInsert()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
nnoremap <buffer> <expr> N 'j '[v:searchforward].'N'
nnoremap <buffer> <nowait> <silent> e :call startify#open_buffers('11')
nnoremap <buffer> <nowait> <silent> i :enew | startinsert
nnoremap <buffer> j j
nnoremap <buffer> k k
nnoremap <buffer> <expr> n ' j'[v:searchforward].'n'
nnoremap <buffer> <nowait> <silent> q :call startify#open_buffers('36')
nnoremap <buffer> <nowait> <silent> <2-LeftMouse> :call startify#open_buffers()
nnoremap <buffer> <nowait> <silent> <Insert> :enew | startinsert
noremap <buffer> <silent> <M-n> :call AutoPairsJump()
noremap <buffer> <silent> <M-p> :call AutoPairsToggle()
imap <buffer> <silent> g <Plug>delimitMateJumpMany
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
noremap <buffer> <silent> î :call AutoPairsJump()
noremap <buffer> <silent> ð :call AutoPairsToggle()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=wipe
setlocal nobuflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*\ %s\ */
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal completeopt=
setlocal concealcursor=inc
setlocal conceallevel=2
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'startify'
setlocal filetype=startify
endif
setlocal fillchars=
setlocal fixendofline
setlocal foldcolumn=0
set nofoldenable
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=tcq
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispoptions=
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal nomodifiable
setlocal nrformats=bin,octal,hex
set number
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=8
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
set signcolumn=yes
setlocal signcolumn=yes
setlocal nosmartindent
setlocal nosmoothscroll
setlocal softtabstop=8
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=%!airline#statusline(1)
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'startify'
setlocal syntax=startify
endif
setlocal tabstop=8
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal wincolor=
setlocal nowinfixbuf
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 11 - ((10 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 11
normal! 05|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
set shortmess=filnxtToOSc
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
