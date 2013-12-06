let s:menu = []

function! s:expand_menu()
  if len(s:menu) > 0
    return
  endif
  let start_folder = matchstr(filter(split(system('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"'), "\n"), "v:val =~ '^\\s*Start Menu\\s'")[0], '\sREG_SZ\s\+\zs.*')
  let common_start_folder = matchstr(filter(split(system('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"'), "\n"), "v:val =~ '^\\s*Common Start Menu\\s'")[0], '\sREG_SZ\s\+\zs.*')
  let s:menu += split(globpath(start_folder, '**/*.lnk'), "\n")
  let s:menu += split(globpath(common_start_folder, '**/*.lnk'), "\n")
endfunction

function! startmenu#list_links()
  call s:expand_menu()
  return copy(s:menu)
endfunction

function! startmenu#list_names()
  call s:expand_menu()
  return map(copy(s:menu), 'fnamemodify(v:val, ":p:t:r")')
endfunction

function! startmenu#list_map()
  call s:expand_menu()
  return map(copy(s:menu), '{"name":fnamemodify(v:val, ":p:t:r"), "file":v:val}')
endfunction

function! startmenu#map_links()
  call s:expand_menu()
  let ret = {}
  for l in s:menu
    let ret[fnamemodify(l, ":p:t:r")] = l
  endfor
  return ret
endfunction

function! startmenu#icon(f)
  let icon = sha256(a:f) . ".png"
  call system(printf("exticon %s %s", shellescape(a:f), shellescape(icon)))
  return icon
endfunction

function! startmenu#execute(name)
  call s:expand_menu()
  let item = filter(copy(s:menu), "stridx(v:val, a:name . '.lnk') == len(v:val)-len(a:name)-4")
  if len(item) > 0
    silent! exe '!start explorer ' . item[0]
	return 1
  endif
  return 0
endfunction
