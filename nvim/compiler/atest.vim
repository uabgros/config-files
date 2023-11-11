" Vim compiler file
" Compiler:             atest
" Previous Maintainer:  Goeran Groeschner
" Latest Revision:      2023-04-18

if exists("current_compiler")
  finish
endif
let current_compiler = "atest"

CompilerSet errorformat=
        \%E%f:%l:%c:\ %trror:\ %m,%-Z%p^,%+C%.%#,
        \%E%f:%l:%c:\ %tatal\ error:\ %m,%-Z%p^,%+C%.%#,
        \%D%*\\a:\ Entering\ directory\ '%f',
        \%X%*\\a:\ Leaving\ directory\ '%f',
        \%-G%.%#
" CompilerSet errorformat=%f:\ line\ %l:\ %m
CompilerSet makeprg=atest_run\ %

