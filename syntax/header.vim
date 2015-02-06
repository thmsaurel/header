" description
" " TITLE "
"
" File Name         : header.vim
" Created By        : Thomas Aurel
" Creation Date     : January  1th, 2015
" Version           : 0.1
" Last Change       : January  1th, 2015 at 22:52:10
" Last Changed By   : Thomas Aurel
"

syntax match headerFunction "\v^:.*$"

syntax match headerComment "\v#.*$"
syntax match headerComment "\v\".*$"

syntax region headerComment start=/\v\/\*/ skip=/\v\\./ end=/\v\*\//

syntax match headerError "\v^.{80}.+$"

highlight link headerFunction Function
highlight link headerComment Comment
highlight link headerError Error

