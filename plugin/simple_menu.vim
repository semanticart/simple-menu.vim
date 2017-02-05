function! SimpleMenu(options)
  let l:choice_map = {}

  for choice in a:options
    let l:key = choice[0]
    let l:choice_map[l:key] = choice[2]

    echohl Boolean
    echon l:key . ' '
    echohl None
    echon choice[1]
    echo ''
  endfor

  let l:response = nr2char(getchar())

  redraw!

  if has_key(l:choice_map, l:response)
    call call(l:choice_map[l:response], [])
  endif
endfunction
