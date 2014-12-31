" Vim header for development files
" " HEADER "
"
" File Name         : header.vim
" Created By        : Thomas Aurel
" Creation Date     : November 5th, 2014
" Version           : 0.3
" Last Change       : December 31th, 2014 at 01:19:31
" Last Changed By   : Thomas Aurel
"

function! s:Find(list, element)
    let value = 0
    for e in a:list
        if e ==# a:element
            let value = 1
        endif
    endfor
    return value
endfunction

function! s:header_creation_check()
    " let g:header_command = "wc -l <"
    let s:date = strftime("%B %eth, %Y")
    let s:date_modif = s:date . strftime(" at %X")
    let s:filename = expand("%")
    let s:header_size = 10

    if !exists("g:header_author")
        let g:header_author = "Unknown Author"
    endif
    if !exists("g:header_types")
        let g:header_types = ['vim', 'c']
    endif
    if !exists("g:header_file")
        let g:header_file = globpath(&runtimepath, 'plugin/headers/' . &filetype . '.header')
    endif

    if !s:Find(g:header_types, &filetype)
        finish
    endif

    if !exists("s:creation") && s:creation == 1
        execute 'source ' . g:header_file
        execute "1," . s:header_size . "g/File Name.*:.*/s// File Name         : ". s:filename
        execute "1," . s:header_size . "g/Created By.*:.*/s//Created By        : ". s:date
        execute "1," . s:header_size . "g/Creation Date.*:.*/s//Creation Date     : ". s:date
    endif

    let s:creation = 0
    augroup header_modification
        autocmd!
        autocmd bufwritepre,filewritepre * execute "normal ma"
        autocmd bufwritepre,filewritepre * execute "1," . s:header_size . "g/Last Change .*:.*/s//Last Change       : " . s:date_modif
        autocmd bufwritepre,filewritepre * execute "1," . s:header_size . "g/Last Changed By.*:.*/s//Last Changed By   : " . g:header_author
        autocmd bufwritepre,filewritepre * execute "normal `a""`"
    augroup END
endfunction

autocmd bufnewfile * :let s:creation = 1
autocmd FileType * :call s:header_creation_check()
