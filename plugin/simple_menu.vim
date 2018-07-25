function! SimpleMenu(options)

  let l:choice_map = {}

  for choice in a:options
    let l:key = choice[0]
    if len(choice) == 3
        let l:choice_map[l:key] = choice[2]
    else
        let l:choice_map[l:key] = choice[1]
    endif
    echohl Boolean
    echon ' ' . l:key . ' '
    echohl None
    echon choice[1]
    echo ''
  endfor

  let l:response = nr2char(getchar())

  redraw!

  if has_key(l:choice_map, l:response)
    if exists('*' . l:choice_map[l:response])
        " first try to `:call foo()`
        call call(l:choice_map[l:response], [])
    else
        " if it not exists then try `:foo`
        execute ':' . l:choice_map[l:response]
    endif
  endif
endfunction
