" Vim filetype plugin file
" Language:	tex
" Maintainer:	Marcin Szamotulski
" Last Changed: 2010 July 9
" URL:		
"{{{ Load Once
if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
"}}}
"{{{ OpenFile
if !exists("*OpenFile")
function! OpenFile()
    let line	= max([line("."), '2'])-2
    let file	= g:fd_matches[line]

    " The list of fd files starts at second line.
    let openbuffer	= "topleft split! +setl\\ nospell\\ ft=fd_atp\\ noro " . fnameescape(file)
    silent exe openbuffer
    let b:atp_autex=0
endfunction
endif
"}}}
"{{{ ShowFonts
function! ShowFonts(fd_file)

    let font_commands	= atplib#ShowFont(a:fd_file)

    let message		= ""
    for fcom in font_commands
	let message	.= "\n".fcom
    endfor
    let message="Fonts Declared:".message
    call confirm(message)
endfunction
"}}}
"{{{ Autocommand
au CursorHold fd_list* :echo g:fd_matches[(max([line("."),'2'])-2)]
"}}}
"{{{ Preview
function! Preview(...)

    let keep_tex = ( a:0 == 0 ? 0 : a:1 )

    let b_pos	= getpos("'<")[1]
    let e_pos	= getpos("'>")[1]

    if getpos("'<") != [0, 0, 0, 0] && getpos("'<") != [0, 0, 0, 0]
	let fd_files	= filter(copy(g:fd_matches),'index(g:fd_matches,v:val)+1 >= b_pos-1 && index(g:fd_matches,v:val)+1 <= e_pos-1')
    else
	let fd_files	= [g:fd_matches[(max([line("."),'2'])-2)]]
    endif

    call atplib#Preview(fd_files, keep_tex)

endfunction
"}}}
"{{{ Commands
if bufname("%") =~ 'fd_list'
    command! -buffer -nargs=? -range Preview	:call Preview(<f-args>)
    command! -buffer ShowFonts			:call ShowFonts(g:fd_matches[(max([line("."),'2'])-2)])
    map <buffer> <Enter> 			:call OpenFile()<CR>
    map <buffer> <Tab>				:call ShowFonts(g:fd_matches[(max([line("."),'2'])-2)])<CR>
else
    command! -buffer -nargs=1 Preview		:call atplib#Preview(["buffer"],<f-args>)
endif
"}}}
"{{{ Maps
map 	<buffer> 	P :Preview 1<CR>
map 	<buffer> 	p :Preview 0<CR>
vmap 	<buffer> 	P :Preview 1<CR>
vmap 	<buffer> 	p :Preview 0<CR>
map 	<buffer> 	Q :bd!<CR>
map 	<buffer> 	q :q!<CR>R
"}}}
