"" Example A:

"function! SayHi()
	"echo 'Hello'
"endfunction

"function! SayBye()
	"echo 'See Ya!'
"endfunction
"
"function! MyGreetPopup()
	"call MySimpleMenu([
			"\	['h', 'Say Hi', 'SayHi'],
			"\	['b', 'Say Bye', 'SayBye'],
			"\ ])
"endfunction

"noremap <leader>g :call MyGreetPopup()<CR>

"" Example B:

"function! MyLspPopup()
	"call SimpleMenu([
			"\	['d', 'Go to definition', 'LspDefinition'],
			"\	['e', 'Errors', 'LspDocumentDiagnostics'],
			"\	['f', 'Format', 'LspDocumentFormat'],
			"\	['v', 'ranged format', 'LspDocumentRangeFormat'],
			"\	['s', 'Symbols', 'LspDocumentSymbol'],
			"\	['h', 'Hover', 'LspHover'],
			"\	['i', 'Implementation', 'LspImplementation'],
			"\	['r', 'References', 'LspReferences'],
			"\	['m', 'renaMe', 'LspRename'],
			"\	['w', 'Workspace symbols', 'LspWorkspaceSymbol'],
			"\ ])
"endfunction
"
"noremap <leader>l :call MyLspPopup()<CR>


"" Source Code:

function! SimpleMenu(options)

  let l:choice_map = {}

  for choice in a:options
    let l:key = choice[0]
    let l:choice_map[l:key] = choice[2]

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
