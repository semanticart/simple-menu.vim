function! SimpleMenu(options)
  let l:choice_map = {}

  for choice in a:options
    let l:key = choice[2]
    let l:choice_map[l:key] = choice[1]

    echohl Boolean
    echon l:key . ' '
    echohl None
    echon choice[0]
    echo ''
  endfor

  let l:response = nr2char(getchar())

  if has_key(l:choice_map, l:response)
    execute ":call " . l:choice_map[l:response]. "()"
  endif

  redraw!
endfunction
