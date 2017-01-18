" Vim Compiler File
" Compiler:     runs perl's Test::Unit 'prove'
" Maintainer:   Jeff Ober <sysread@fastmail.com>
" PreviousMaintainer: harmen-cpan@millionmonkeys.nl
" OriginalMaintainer: Christian J. Robinson <infynity@onewest.net>
" Creation:  2005 Jul 28
" Creation:  2005 Jul 29
"
" Installation:
" - Copy this file to ~/.vim/compiler/
" - Add to yor .vimrc:
"   au BufRead,BufNewFile *.t set filetype=perl | compiler perlprove

if exists("current_compiler")
  finish
endif
let current_compiler = "perlprove"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:savecpo = &cpo
set cpo&vim

if exists('g:perl_compiler_force_warnings') && g:perl_compiler_force_warnings == 0
  let s:warnopt = 'w'
else
  let s:warnopt = 'W'
endif

if getline(1) =~# '-[^ ]*T' || g:perl_compiler_force_taint_mode == 1
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

"Ignore all other messages
"CompilerSet efm+=%-G%.%#

let &cpo = s:savecpo
unlet s:savecpo
