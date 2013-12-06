if get(g:, 'loaded_ctrlp_startmenu', 0)
  "finish
endif
let g:loaded_ctrlp_startmenu = 1

let s:saved_cpo = &cpo
set cpo&vim

call add(g:ctrlp_ext_vars, {
  \ 'init':   'ctrlp#startmenu#init()',
  \ 'accept': 'ctrlp#startmenu#accept',
  \ 'lname':  'startmenu',
  \ 'sname':  'startmenu',
  \ 'type':   'line',
  \ 'sort':   0
  \ })

function! ctrlp#startmenu#init()
  return startmenu#list_names()
endfunction

function! ctrlp#startmenu#accept(mode, str)
  call ctrlp#exit()
  call startmenu#execute(a:str)
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#startmenu#id()
  return s:id
endfunction

let &cpo = s:saved_cpo
unlet s:saved_cpo
