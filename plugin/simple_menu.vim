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

  let l:i = 0
  for choice in a:options.choices
    if len(choice) == 3
      let l:key = choice[2]
    else
      let l:key = l:keys[l:i]
      let l:i += 1
    endif
    execute 'nnoremap <buffer> ' . l:key ' :call ExecuteAndCloseSimpleMenu("' . choice[1] . '")<CR>'
    let l:output = l:output + [l:key . ' ' . choice[0] . ' ']
  endfor

  for key in g:simplemenu_quit_keys
    execute 'nnoremap <buffer> ' . key . ' :call CloseSimpleMenu()<CR>'
  endfor

  call append(0, l:output)
  normal! ddgg

  " workaround for me not knowing how to hide the cursor
  normal! $
  setlocal list listchars=
endfunction

let g:simplemenu_keys = 'ajskdlf;gh'
let g:simplemenu_quit_keys = ['q', '<ESC>', '<C-c>']
