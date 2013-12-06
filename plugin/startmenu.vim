let s:interface = get(g:, 'startmenu_interface', 'ctrlp')
if s:interface == 'ctrlp'
  command! StartMenu call ctrlp#init(ctrlp#startmenu#id())
elseif s:interface == 'unite'
  command! StartMenu Unite startmenu
endif
