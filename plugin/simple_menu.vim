function! SimpleMenu(options)

  let l:choice_map = {}

  for choice in a:options
    let l:key = choice[0]
    let l:description = choice[1]
    if len(choice) == 3
        let l:choice_map[l:key] = choice[2]
    else
        let l:choice_map[l:key] = choice[1]
        let l:description = substitute(l:description, "^:", '', '')
    endif
    echohl Boolean
    echon ' ' . l:key . ' '
    echohl None
    echon l:description
    echo ''
  endfor

  let l:response = nr2char(getchar())

  redraw!

  if has_key(l:choice_map, l:response)
    if l:choice_map[l:response][0] == ':'
        " if it it stats from dash interpret it as vim command: `:foo`
        execute l:choice_map[l:response]
    else
        " otherwise it's a function name `:call foo()`
        call call(l:choice_map[l:response], [])
    endif
  endif
endfunction
