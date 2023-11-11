" Vim compiler file
" Compiler:             Bash
" Previous Maintainer:  Goeran Groeschner
" Latest Revision:      2023-04-16

if exists("current_compiler")
  finish
endif
let current_compiler = "bash"

CompilerSet errorformat=%f:\ line\ %l:\ %m
CompilerSet makeprg=bash\ %

