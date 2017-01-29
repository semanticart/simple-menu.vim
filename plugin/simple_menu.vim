function! SimpleMenu(options)
  let l:keys = split(g:simplemenu_keys, '\zs')

  let l:choice_map = {}

  echohl Title
  echo a:options.title
  echohl None
  echo ''

  let l:i = 0
  for choice in a:options.choices
    if len(choice) == 3
      let l:key = choice[2]
    else
      let l:key = l:keys[l:i]
      let l:i += 1
    endif

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

let g:simplemenu_keys = 'ajskdlf;gh'
