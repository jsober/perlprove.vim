if exists('g:autoloaded_proven') || &cp
  finish
endif

function! proven#OpenTestFile()
  let l:file = expand('%')

  if !filereadable(l:file) || l:file !~# '\.pm$'
    return
  endif

  let l:file = substitute(l:file, '\.pm$', '.t', '')

  if match(l:file, '^lib/') == 0
    let l:file = substitute(l:file, '^lib/', 't/', '')
  else
    let l:file = substitute(l:file, '/lib/', '/t/', '')
  endif

  if !filereadable(l:file)
    echo 'no matching perl test found (looked for ' . l:file . ')'
    return
  end

  if g:proven_open_in_tab == 1
    execute ':tabe ' . l:file
  else
    execute ':e ' . l:file
  end
endfunction

let g:autoloaded_proven = 1
