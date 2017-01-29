function! ExecuteAndCloseSimpleMenu(fun)
  " close first so that the caller window has focus (and thus is context) when
  " `fun` is called
  call CloseSimpleMenu()

  execute ":call " . a:fun . "()"
endfunction

function! CloseSimpleMenu()
  execute "bd"
endfunction

function! SimpleMenu(options)
  execute len(a:options.choices) . "split " . substitute(a:options.title, '\s', '_', 'g')

  normal! gg"_dG
  set buftype=nofile
  set filetype=simplemenu
  setlocal nonumber
  setlocal nocursorline
  setlocal colorcolumn=

  let l:output = []

  let l:keys = split(g:simplemenu_keys, '\zs')

  let l:choice_map = {}

  let l:i = 0
  for choice in a:options.choices
    if len(choice) == 3
      let l:key = choice[2]
    else
      let l:key = l:keys[l:i]
      let l:i += 1
    endif
    let l:choice_map[l:key] = choice[1]
    let l:output = l:output + [l:key . ' ' . choice[0]]
  endfor

  call append(0, l:output)
  normal! ddgg

  redraw!
  echo a:options.title . ': '
  let l:response = nr2char(getchar())

  if has_key(l:choice_map, l:response)
    call ExecuteAndCloseSimpleMenu(l:choice_map[l:response])
  else
    call CloseSimpleMenu()
  endif

  redraw!
  echo ''
endfunction

let g:simplemenu_keys = 'ajskdlf;gh'
