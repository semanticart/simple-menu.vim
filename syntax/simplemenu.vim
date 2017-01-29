if exists("b:current_syntax")
  finish
endif

syntax match simpleMenuChoice "\v^."
highlight link simpleMenuChoice Number

let b:current_syntax = "simplemenu"
