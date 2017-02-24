if exists("current_compiler")
  finish
endif
let current_compiler = "proven"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:savecpo = &cpo
set cpo&vim

if exists("g:proven_dash_I") && len(g:proven_dash_I) > 0
  let s:includes = '\ -I' . join(g:proven_dash_I, '\ -I')
else
  let s:includes = ''
endif

if exists("g:proven_dash_M") && len(g:proven_dash_M) > 0
  let s:modules = '\ -M' . join(g:proven_dash_M, '\ -M')
else
  let s:modules = ''
endif

if g:proven_force_warn == 0
  let s:warnings = 'w'
else
  let s:warnings = 'W'
endif

if getline(1) =~# '-[^ ]*[tT]' || g:proven_taint_mode == 1
  let s:taintmode = 'T'
else
  let s:taintmode = ''
endif

if expand('%:e') == 't'
  let s:compilername = 'prove'
else
  let s:compilername = 'perl'
endif

if expand('%:e') == 't'
  let s:compileropt = '\ --nocolor\ --nocount\ -lmv'
else
  let s:compileropt = '\ -c'
endif

let s:compilerstr = s:compilername . s:compileropt . s:warnings . s:taintmode . s:includes . s:modules . '\ %'

"echo 'CompilerSet makeprg=' . s:compilerstr

exe 'CompilerSet makeprg=' . s:compilerstr

"TAP errors
CompilerSet efm=%+I#\ Looks\ like\ you\ %m.
CompilerSet efm+=%+E\ %##\ %#Failed\ test\ '%m'
CompilerSet efm+=%Z\ %##\ %#at\ %f\ line\ %l.
CompilerSet efm+=%Z\ %##\ %#in\ %f\ at\ line\ %l.

"Perl syntax errors, etc, from perl compiler package
CompilerSet efm+=%-G%.%#had\ compilation\ errors.
CompilerSet efm+=%-G%.%#syntax\ OK
CompilerSet efm+=%m\ at\ %f\ line\ %l.
CompilerSet efm+=%+A%.%#\ at\ %f\ line\ %l\\,%.%#
CompilerSet efm+=%+C%.%#

let &cpo = s:savecpo
unlet s:savecpo
