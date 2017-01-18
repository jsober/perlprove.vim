if exists("current_compiler")
  finish
endif
let current_compiler = "proven"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:savecpo = &cpo
set cpo&vim

if g:proven_force_warn == 0
  let s:warnopt = 'w'
else
  let s:warnopt = 'W'
endif

if getline(1) =~# '-[^ ]*[tT]' || g:proven_taint_mode == 1
  let s:taintopt = 'T'
else
  let s:taintopt = ''
endif

exe 'CompilerSet makeprg=prove\ --nocolor\ --nocount\ -lmfv' . s:warnopt . s:taintopt . '\ %'

"TAP ok
CompilerSet efm =%+Cok\ %.%#

"TAP not ok
CompilerSet efm+=%Enot\ ok\ %.%#
CompilerSet efm+=%C
CompilerSet efm+=%C#\ %#Failed\ test\ '%m'
CompilerSet efm+=%Z#\ %#at\ %f\ line\ %l.
CompilerSet efm+=%Z#\ %#in\ %f\ at\ line\ %l.
CompilerSet efm+=%+C#%.%#

"Perl syntax errors, etc, from perl compiler package
CompilerSet efm+=%-G%.%#had\ compilation\ errors.
CompilerSet efm+=%-G%.%#syntax\ OK
CompilerSet efm+=%m\ at\ %f\ line\ %l.
CompilerSet efm+=%+A%.%#\ at\ %f\ line\ %l\\,%.%#
CompilerSet efm+=%+C%.%#

let &cpo = s:savecpo
unlet s:savecpo
