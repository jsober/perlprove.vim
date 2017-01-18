Description
===========

Proven adds compiler support for perl's `prove` utility and a function to
automatically open a test file related to the package currently open by
replacing the first occurrence of `lib` in the open file's path with `t`
and swapping the extension (e.g. `s/\.pm$/.t/`).

Installation
============

Using Vundle
------------

Add to your .vimrc between `call vundle#begin()` and `call vundle#end()`:

    Plugin 'jsober/proven.vim'

Then install from within vim:

    :VundleInstall

Manually
--------

Download or clone repo and:

    mkdir -p ~/.vim/compiler
    mkdir -p ~/.vim/autoload

    cd /path/to/wherever/you/put/proven
    cp compiler/proven.vim ~/.vim/compiler
    cp autoload/proven.vim ~/.vim/autoload

Enable
======

Add to your .vimrc:

    " Configure the compiler
    autocmd! BufEnter,BufNewFile *.t set ft=perl
    autocmd  BufEnter,BufNewFile *.t compiler proven

    " Add some handy mappings
    noremap <Leader>v :call proven#OpenUnitTest()<CR>
    noremap <Leader>V :call proven#OpenUnitTest()<CR>:make<CR>

Configuration
=============

    " Has the same meaning as with the perl ft (0=-w, 1=-W)
    let g:perl_compiler_force_warnings=0

    " Enables/disables taint mode (disabled by default)
    let g:perl_compiler_force_taint_mode=1

Credits
=======

This plugin was originally forked from https://github.com/vim-scripts/perlprove.vim,
which is a mirror of http://www.vim.org/scripts/script.php?script_id=1319.
