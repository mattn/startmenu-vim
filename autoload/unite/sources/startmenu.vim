let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#startmenu#define()
  return s:source
endfunction

let s:source = {
\  "name" : "startmenu",
\  "description" : "Start Menu",
\  "default_action" : "open",
\  "action_table": { "open": {} },
\}

function! s:source.gather_candidates(args, context)
  return map(startmenu#list_names(), '{
        \ "abbr": v:val,
        \ "word": v:val,
        \ }')
endfunction

function! s:source.action_table.open.func(candidate)
  call startmenu#execute(a:candidate.word)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
