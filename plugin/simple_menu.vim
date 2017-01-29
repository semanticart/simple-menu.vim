function! ExecuteAndCloseSimpleMenu(fun)
  " close first so that the caller window has focus when `fun` is called
  call CloseSimpleMenu()
  execute ":call " . a:fun . "()"
endfunction

function! CloseSimpleMenu()
  execute "bd"
endfunction

function! SimpleMenu(options)
  execute len(a:options.choices) . "split " . substitute(a:options.title, '\s', '_', 'g')

  set buftype=nofile
  set filetype=simplemenu
  set nonumber
  normal! gg"_dG

  let l:output = []

  let l:keys = split(g:simplemenu_keys, '\zs')

  let l:i = 0
  for choice in a:options.choices
    let l:key = l:keys[l:i]
    let l:i += 1
    execute 'nnoremap <buffer> ' . l:key ' :call ExecuteAndCloseSimpleMenu("' . choice[1] . '")<CR>'
    " Add space at the end for cursor hack below
    let l:output = l:output + [l:key . '. ' . choice[0] . ' ']
  endfor

  execute 'nnoremap <buffer> q :call CloseSimpleMenu()<CR>'
  execute 'nnoremap <buffer> <ESC> :call CloseSimpleMenu()<CR>'

  call append(0, l:output)
  normal! ddgg

  " workaround for me not knowing how to hide the cursor
  normal! $
  setlocal list listchars=
endfunction

let g:simplemenu_keys = 'ajskdlf;gh'
