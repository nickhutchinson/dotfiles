"============================================================================
"File:        lua.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Gregor Uhlenheuer <kongo2002 at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists("g:loaded_syntastic_lua_luajit_checker")
    finish
endif
let g:loaded_syntastic_lua_luajit_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_lua_luajit_GetHighlightRegex(pos)
    let result = ''
    let near = matchstr(a:pos['text'], '\mnear ''\zs[^'']\+\ze''')
    if near != ''
        if near ==# '<eof>'
            let p = getpos('$')
            let a:pos['lnum'] = p[1]
            let a:pos['col'] = p[2]
            let result = '\%' . p[2] . 'c'
        else
            let result = '\V' . escape(near, '\')
        endif
    endif
    return result
endfunction

function! SyntaxCheckers_lua_luajit_GetLocList() dict
    let makeprg = self.makeprgBuild({
        \ 'args': '-b',
        \ 'tail': '/dev/null' })

    let errorformat =  'luajit: %#%f:%l: %m'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'defaults': { 'bufnr': bufnr(''), 'type': 'E' } })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'lua',
    \ 'name': 'luajit'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
