Description
===========

Proven adds compiler support for perl's `prove` utility and a function to
automatically open a test file related to the package currently open by
replacing the first occurrence of `lib` in the open file's path with `t`
and swapping the extension (e.g. `s/\.pm$/.t/`).

Installation
============

I am too lazy to type out full instructions for manual installation or
anything harder than Vundle.

Add to your .vimrc between `call vundle#begin()` and `call vundle#end()`:

    Plugin 'jsober/proven.vim'

Then install from within vim:

    :VundleInstall

Enable
======

Add to your .vimrc:

    " Configure the compiler
    autocmd! BufEnter,BufNewFile *.t set ft=perl
    autocmd  BufEnter,BufNewFile *.t compiler proven

    " Add some handy mappings
    noremap <Leader>v :ProvenOpenTest<CR>
    noremap <Leader>V :ProvenOpenTest<CR>:make<CR>

Configuration
=============

    " Sets warnings flag with -w (0) or -W (1) (default is 0)
    let g:proven_force_warn=0

    " Sets taint mode with -T (default is 0)
    let g:proven_taint_mode=1

    " Open in tab (default is 1)
    let g:proven_open_in_tab=1

Credits
=======

This plugin was originally forked from https://github.com/vim-scripts/perlprove.vim,
which is a mirror of http://www.vim.org/scripts/script.php?script_id=1319.
