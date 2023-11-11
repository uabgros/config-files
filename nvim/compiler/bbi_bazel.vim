" Vim compiler file
" Compiler:             GNU C Compiler
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2010-10-14
" 			changed pattern for entering/leaving directories
" 			by Daniel Hahler, 2019 Jul 12
" 			added line suggested by Anton Lindqvist 2016 Mar 31

if exists("current_compiler")
  finish
endif
let current_compiler = "gcc"

let s:cpo_save = &cpo
set cpo&vim

" CompilerSet errorformat=
"       \%*[^\"]\"%f\"%*\\D%l:%c:\ %m,
"       \%*[^\"]\"%f\"%*\\D%l:\ %m,
"       \\"%f\"%*\\D%l:%c:\ %m,
"       \\"%f\"%*\\D%l:\ %m,
"       \%-G%f:%l:\ %trror:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,
"       \%-G%f:%l:\ %trror:\ for\ each\ function\ it\ appears\ in.),
"       \%f:%l:%c:\ %trror:\ %m,
"       \%f:%l:%c:\ %tarning:\ %m,
"       \%f:%l:%c:\ %m,
"       \%f:%l:\ %trror:\ %m,
"       \%f:%l:\ %tarning:\ %m,
"       \%f:%l:\ %m,
"       \%f:\\(%*[^\\)]\\):\ %m,
"       \\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,
"       \%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
"       \%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',
"       \%D%*\\a:\ Entering\ directory\ %*[`']%f',
"       \%X%*\\a:\ Leaving\ directory\ %*[`']%f',
"       \%DMaking\ %*\\a\ in\ %f

CompilerSet errorformat=
        \%E%f:%l:%c:\ %trror:\ %m,%-Z%p^,%+C%.%#,
        \%E%f:%l:%c:\ %tatal\ error:\ %m,%-Z%p^,%+C%.%#,
        \%D%*\\a:\ Entering\ directory\ '%f',
        \%X%*\\a:\ Leaving\ directory\ '%f',
        \%-G%.%#

if exists('g:compiler_gcc_ignore_unmatched_lines')
  CompilerSet errorformat+=%-G%.%#
endif
" CompilerSet makeprg=env\ BAZEL_REMOTE_CONFIG=\"\"\ bbi_bazel
CompilerSet makeprg=bbi_bazel

let &cpo = s:cpo_save
unlet s:cpo_save
