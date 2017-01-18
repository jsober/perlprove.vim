if exists('g:autoloaded_proven') || &cp
  finish
endif

function! proven#OpenUnitTest()
  let l:f = expand("%")

  if filereadable(l:f)
    if match(l:f, ".pm$") == -1
      echo "(probably) not a perl file: " . l:f
    else
      let l:f = substitute(l:f, ".pm$", ".t", "")
      if match(l:f, "^lib/") == 0
        let l:f = substitute(l:f, "^lib/", "t/", "")
      else
        let l:f = substitute(l:f, "/lib/", "/t/", "")
      endif

      if filereadable(l:f)
        execute ':tabe ' . l:f
      else
        echo "file not found: " . l:f
      endif
    endif
  endif
endfunction

let g:autoloaded_proven = 1
