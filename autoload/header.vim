" Vim header for development files
" " HEADER "
"
" File Name         : header.vim
" Created By        : Thomas Aurel
" Creation Date     : November 5th, 2014
" Version           : 0.4
" Last Change       : January  2th, 2015 at 17:02:35
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

function! header#creation_check(header_creation)
    let b:creation = a:header_creation
    " let g:header_command = "wc -l <"
    let s:date = strftime("%B %eth, %Y")
    let s:date_modif = s:date . strftime(" at %X")
    let s:filename = expand("%")
    let s:header_size = 10

    if !exists("g:header_author")
        let g:header_author = "Unknown Author"
    endif
    if !exists("g:header_types")
        let g:header_types = ['vim', 'c', 'sh', 'make', 'python', 'lex', 'yacc']
    endif

    if s:Find(g:header_types, &filetype) == 0
        return
    endif

    if !exists("g:header_file")
        let g:header_file = globpath(&runtimepath, 'plugin/headers/' . &filetype . '.header')
    endif

    if b:creation
        execute "source" . g:header_file
        execute "1," . s:header_size . "g/File Name.*:.*/s//File Name         : ". s:filename
        execute "1," . s:header_size . "g/Created By.*:.*/s//Created By        : ". g:header_author
        execute "1," . s:header_size . "g/Creation Date.*:.*/s//Creation Date     : ". s:date
    endif

    let b:creation = 0
    augroup header_modification
        autocmd!
        autocmd BufWritePre,FileWritePre * execute "normal ma"
        autocmd BufWritePre,FileWritePre * execute "1," . s:header_size . "g/Last Change .*:.*/s//Last Change       : " . s:date_modif
        autocmd BufWritePre,FileWritePre * execute "1," . s:header_size . "g/Last Changed By.*:.*/s//Last Changed By   : " . g:header_author
        autocmd BufWritePre,FileWritePre * execute "normal `a""`"
    augroup END
endfunction

