if exists('g:loaded_proven') || &cp
  finish
endif

if !exists('g:proven_force_warn')
  let g:proven_force_warn = 0
endif

if !exists('g:proven_taint_mode')
  let g:proven_taint_mode = 0
endif

if !exists('g:proven_open_in_tab')
  let g:proven_open_in_tab = 1
endif

com! -bar ProvenOpenTest cal proven#OpenTestFile()

let g:loaded_proven = 1
