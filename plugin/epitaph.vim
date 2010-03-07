let $PATH = printf('%s/../bin:', expand('<sfile>:p:h')).$PATH
"if &cmdheight == 1
" set cmdheight=2
"endif

let s:tmp = tempname()
function! Aaa()
  silent execute "write!" s:tmp
  return split(system('epitaph ' . s:tmp), "\n")[0][0:winwidth(0)-1]
endfunction

augroup AAA
  autocmd!
  "autocmd CursorMovedI <buffer> setl statusline=%!Aaa()
  autocmd InsertLeave <buffer> echon Aaa()
augroup END
