" Vim Compiler File
" Compiler:     runs perl's Test::Unit 'prove'
" Maintainer:   Jeff Ober <sysread@fastmail.com>
" OriginalMaintainer:   Christian J. Robinson <infynity@onewest.net>
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

" Usage: :make - prove the current testfile
CompilerSet makeprg=prove\ -lmwfv\ --nocolor\ --nocount\ %

" Test2
CompilerSet efm =%Enot\ ok\ %.%#
CompilerSet efm+=%C
CompilerSet efm+=%C#\ %#Failed\ test\ '%m'
CompilerSet efm+=%Z#\ %#at\ %f\ line\ %l.

" TAP comments
CompilerSet efm+=%-G#\ %#%m

" Perl syntax errors (from perl compiler package)
CompilerSet efm+=%m\ at\ %f\ line\ %l.

" Ignore all other messages
CompilerSet efm+=%-G%.%#

let &cpo = s:savecpo
unlet s:savecpo
