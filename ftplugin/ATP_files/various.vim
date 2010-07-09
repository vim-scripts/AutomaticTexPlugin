"Author		Marcin Szamotulski	
"These are various tools.

" This is the wrap selection function.
" {{{1 WrapSelection
" ------- Wrap Seclection ----------------------------
function! s:WrapSelection(wrapper,...)

    if a:0 == 0
	let l:end_wrapper='}'
    else
	let l:end_wrapper=a:1
    endif
    if a:0 >= 2
	let l:cursor_pos=a:2
    else
	let l:cursor_pos="end"
    endif
    if a:0 >= 3
	let l:new_line=a:3
    else
	let l:new_line=0
    endif

"     let b:new_line=l:new_line
"     let b:cursor_pos=l:cursor_pos
"     let b:end_wrapper=l:end_wrapper

    let l:begin=getpos("'<")
    " todo: if and on 'ą' we should go one character further! (this is
    " a multibyte character)
    let l:end=getpos("'>")
    let l:pos_save=getpos(".")

    " hack for that:
    let l:pos=deepcopy(l:end)
    keepjumps call setpos(".",l:end)
    execute 'normal l'
    let l:pos_new=getpos(".")
    if l:pos_new[2]-l:pos[2] > 1
	let l:end[2]+=l:pos_new[2]-l:pos[2]-1
    endif

    let l:begin_line=getline(l:begin[1])
    let l:end_line=getline(l:end[1])

    let b:begin=l:begin[1]
    let b:end=l:end[1]

    " ToDo: this doesn't work yet!
    let l:add_indent='    '
    if l:begin[1] != l:end[1]
	let l:bbegin_line=strpart(l:begin_line,0,l:begin[2]-1)
	let l:ebegin_line=strpart(l:begin_line,l:begin[2]-1)

	" DEBUG
	let b:bbegin_line=l:bbegin_line
	let b:ebegin_line=l:ebegin_line

	let l:bend_line=strpart(l:end_line,0,l:end[2])
	let l:eend_line=strpart(l:end_line,l:end[2])

	if l:new_line == 0
	    " inline
" 	    let b:debug=0
	    let l:begin_line=l:bbegin_line.a:wrapper.l:ebegin_line
	    let l:end_line=l:bend_line.l:end_wrapper.l:eend_line
	    call setline(l:begin[1],l:begin_line)
	    call setline(l:end[1],l:end_line)
	    let l:end[2]+=len(l:end_wrapper)
	else
" 	    let b:debug=1
	    " in seprate lines
	    let l:indent=atplib#CopyIndentation(l:begin_line)
	    if l:bbegin_line !~ '^\s*$'
" 		let b:debug.=1
		let l:begin_choice=1
		call setline(l:begin[1],l:bbegin_line)
		call append(l:begin[1],l:indent.a:wrapper) " THERE IS AN ISSUE HERE!
		call append(copy(l:begin[1])+1,l:indent.substitute(l:ebegin_line,'^\s*','',''))
		let l:end[1]+=2
" 		return
	    elseif l:bbegin_line =~ '^\s\+$'
" 		let b:debug.=2
		let l:begin_choice=2
		call append(l:begin[1]-1,l:indent.a:wrapper)
		call append(l:begin[1],l:begin_line.l:ebegin_line)
		let l:end[1]+=2
	    else
" 		let b:debug.=3
		let l:begin_choice=3
" 		let l:indent_b=atplib#CopyIndentation(l:begin_line)
		call append(copy(l:begin[1])-1,l:indent.a:wrapper)
" 		call append(l:begin[1],l:ebegin_line)
		let l:end[1]+=1
	    endif
	    if l:eend_line !~ '^\s*$'
" 		let b:debug.=4
		let l:end_choice=4
" 		let l:indent_e=atplib#CopyIndentation(l:bend_line)
		call setline(l:end[1],l:bend_line)
		call append(l:end[1],l:indent.l:end_wrapper)
		call append(copy(l:end[1])+1,l:indent.substitute(l:eend_line,'^\s*','',''))
	    else
" 		let b:debug.=5
		let l:end_choice=5
" 		let l:indent=atplib#CopyIndentation(l:bend_line)
" 		call setline(l:end[1],l:bend_line)
		call append(l:end[1],l:indent.l:end_wrapper)
	    endif
	    " indent lines in the middle: 
	    if (l:end[1] - l:begin[1]) >= 0
" 		let b:debug.=6
		if l:begin_choice == 1
		    let i=2
		elseif l:begin_choice == 2
		    let i=2
		elseif l:begin_choice == 3 
		    let i=1
		endif
		if l:end_choice == 5 
		    let j=l:end[1]-l:begin[1]+1
		else
		    let j=l:end[1]-l:begin[1]+1
		endif
		while i < j
		    " Adding indentation doesn't work in this simple way here?
		    " but the result is ok.
		    call setline(l:begin[1]+i,l:indent.l:add_indent.getline(l:begin[1]+i))
		    let i+=1
		endwhile
	    endif
	    let l:end[1]+=2
	    let l:end[2]=1
	endif
    else
	let l:begin_l=strpart(l:begin_line,0,l:begin[2]-1)
	let l:middle_l=strpart(l:begin_line,l:begin[2]-1,l:end[2]-l:begin[2]+1)
	let l:end_l=strpart(l:begin_line,l:end[2])
	if l:new_line == 0
	    " inline
" 	    let b:debug="X1"
	    let l:line=l:begin_l.a:wrapper.l:middle_l.l:end_wrapper.l:end_l
	    call setline(l:begin[1],l:line)
	    let l:end[2]+=len(a:wrapper)+1
	else
" 	    let b:debug="X1"
	    " in seprate lines

	    let b:begin_l=l:begin_l
	    let b:middle_l=l:middle_l
	    let b:end_l=l:end_l

	    let l:indent=atplib#CopyIndentation(l:begin_line)
" 	    let b:debug="  ".len(l:indent)

	    if l:begin_l =~ '\S' 
		call setline(l:begin[1],l:begin_l)
		call append(copy(l:begin[1]),l:indent.a:wrapper)
		call append(copy(l:begin[1])+1,l:indent.l:add_indent.l:middle_l)
		call append(copy(l:begin[1])+2,l:indent.l:end_wrapper)
		if substitute(l:end_l,'^\s*','','') =~ '\S'
		    call append(copy(l:begin[1])+3,l:indent.substitute(l:end_l,'^\s*','',''))
		endif
	    else
		call setline(copy(l:begin[1]),l:indent.a:wrapper)
		call append(copy(l:begin[1]),l:indent.l:add_indent.l:middle_l)
		call append(copy(l:begin[1])+1,l:indent.l:end_wrapper)
		if substitute(l:end_l,'^\s*','','') =~ '\S'
		    call append(copy(l:begin[1])+2,l:indent.substitute(l:end_l,'^\s*','',''))
		endif
	    endif
	endif
    endif
    if l:cursor_pos == "end"
	let l:end[2]+=len(l:end_wrapper)-1
	call setpos(".",l:end)
    elseif l:cursor_pos =~ '\d\+'
	let l:pos=l:begin
	let l:pos[2]+=l:cursor_pos
	call setpos(".",l:pos)
    elseif l:cursor_pos == "current"
	keepjumps call setpos(".",l:pos_save)
    elseif l:cursor_pos == "begin"
	let l:begin[2]+=len(a:wrapper)-1
	keepjumps call setpos(".",l:begin)
    endif
endfunction
command! -buffer -nargs=? -range WrapSelection		:call <SID>WrapSelection(<args>)
vmap <Plug>WrapSelection	:<C-U>call <SID>WrapSelection('')<CR>i

"}}}1

" Editing Toggle Functions
"{{{ ToggleStar
" this function adds a star to the current environment
" todo: to doc.
function! s:ToggleStar()

    " limit:
    let l:from_line=max([1,line(".")-g:atp_completion_limits[2]])
    let l:to_line=line(".")+g:atp_completion_limits[2]

    " omit pattern
    let l:omit=join(g:atp_no_star_environments,'\|')
    let l:open_pos=searchpairpos('\\begin\s*{','','\\end\s*{[^}]*}\zs','cbnW','getline(".") =~ "\\\\begin\\s*{".l:omit."}"',l:from_line)
    let b:open_pos=l:open_pos
    let l:env_name=matchstr(strpart(getline(l:open_pos[0]),l:open_pos[1]),'begin\s*{\zs[^}]*\ze}')
    let b:env_name=l:env_name
    if l:open_pos == [0, 0] || index(g:atp_no_star_environments,l:env_name) != -1
	return
    endif
    if l:env_name =~ '\*$'
	let l:env_name=substitute(l:env_name,'\*$','','')
	let l:close_pos=searchpairpos('\\begin\s*{'.l:env_name.'\*}','','\\end\s*{'.l:env_name.'\*}\zs','cnW',"",l:to_line)
	if l:close_pos != [0, 0]
	    call setline(l:open_pos[0],substitute(getline(l:open_pos[0]),'\(\\begin\s*{\)'.l:env_name.'\*}','\1'.l:env_name.'}',''))
	    call setline(l:close_pos[0],substitute(getline(l:close_pos[0]),
			\ '\(\\end\s*{\)'.l:env_name.'\*}','\1'.l:env_name.'}',''))
	    echomsg "Star removed from '".l:env_name."*' at lines: " .l:open_pos[0]." and ".l:close_pos[0]
	endif
    else
	let l:close_pos=searchpairpos('\\begin\s{'.l:env_name.'}','','\\end\s*{'.l:env_name.'}\zs','cnW',"",l:to_line)
	if l:close_pos != [0, 0]
	    call setline(l:open_pos[0],substitute(getline(l:open_pos[0]),
		    \ '\(\\begin\s*{\)'.l:env_name.'}','\1'.l:env_name.'\*}',''))
	    call setline(l:close_pos[0],substitute(getline(l:close_pos[0]),
			\ '\(\\end\s*{\)'.l:env_name.'}','\1'.l:env_name.'\*}',''))
	    echomsg "Star added to '".l:env_name."' at lines: " .l:open_pos[0]." and ".l:close_pos[0]
	endif
    endif
endfunction
command! -buffer 	ToggleStar   		:call <SID>ToggleStar()
nnoremap <silent> <Plug>ToggleStar		:ToggleStar
"}}}
"{{{2 ToggleEnvironment
" this function toggles envrionment name.
" Todo: to doc.

"{{{ Variables
if !exists("g:atp_no_toggle_environments")
    let g:atp_no_toggle_environments=[ 'document', 'tikzpicture', 'picture']
endif
if !exists("g:atp_toggle_environment_1")
    let g:atp_toggle_environment_1=[ 'center', 'flushleft', 'flushright', 'minipage' ]
endif
if !exists("g:atp_toggle_environment_2")
    let g:atp_toggle_environment_2=[ 'enumerate', 'itemize', 'list', 'description' ]
endif
if !exists("g:atp_toggle_environment_3")
    let g:atp_toggle_environment_3=[ 'quotation', 'quote', 'verse' ]
endif
if !exists("g:atp_toggle_environment_4")
    let g:atp_toggle_environment_4=[ 'theorem', 'proposition', 'lemma' ]
endif
if !exists("g:atp_toggle_environment_5")
    let g:atp_toggle_environment_5=[ 'corollary', 'remark', 'note' ]
endif
if !exists("g:atp_toggle_environment_6")
    let g:atp_toggle_environment_6=[  'equation', 'align', 'array', 'alignat', 'gather', 'flalign'  ]
endif
if !exists("g:atp_toggle_environment_7")
    let g:atp_toggle_environment_7=[ 'smallmatrix', 'pmatrix', 'bmatrix', 'Bmatrix', 'vmatrix' ]
endif
if !exists("g:atp_toggle_environment_8")
    let g:atp_toggle_environment_8=[ 'tabbing', 'tabular']
endif
if !exists("g:atp_toggle_labels")
    let g:atp_toggle_labels=1
endif
"}}}

" the argument specifies the speed (if -1 then toggle back)
" default is '1'
function! s:ToggleEnvironment(...)

    let l:add = ( a:0 >= 1 ? a:1 : 1 ) 

    " limit:
    let l:from_line=max([1,line(".")-g:atp_completion_limits[2]])
    let l:to_line=line(".")+g:atp_completion_limits[2]

    " omit pattern
    let l:omit=join(g:atp_no_toggle_environments,'\|')
    let l:open_pos=searchpairpos('\\begin\s*{','','\\end\s*{[^}]*}\zs','bnW','getline(".") =~ "\\\\begin\\s*{".l:omit."}"',l:from_line)
    let l:env_name=matchstr(strpart(getline(l:open_pos[0]),l:open_pos[1]),'begin\s*{\zs[^}]*\ze}')

    let l:label=matchstr(strpart(getline(l:open_pos[0]),l:open_pos[1]),'\\label\s*{\zs[^}]*\ze}')
    " DEBUG
    let b:line=strpart(getline(l:open_pos[0]),l:open_pos[1])
    let b:label=l:label
    let b:env_name=l:env_name
    if l:open_pos == [0, 0] || index(g:atp_no_toggle_environments,l:env_name) != -1
	return
    endif

    let l:env_name_ws=substitute(l:env_name,'\*$','','')
    let l:variable="g:atp_toggle_environment_1"
    let l:i=1
    while 1
	let l:env_idx=index({l:variable},l:env_name_ws)
	if l:env_idx != -1
	    break
	else
	    let l:i+=1
	    let l:variable="g:atp_toggle_environment_".l:i
	endif
	if !exists(l:variable)
	    return
	endif
    endwhile

    if l:add > 0 && l:env_idx > len({l:variable})-l:add-1
	let l:env_idx=0
    elseif ( l:add < 0 && l:env_idx < -1*l:add )
	let l:env_idx=len({l:variable})-1
    else
	let l:env_idx+=l:add
    endif
    let l:new_env_name={l:variable}[l:env_idx]
    if l:env_name =~ '\*$'
	let l:new_env_name.="*"
    endif

    " DEBUG
"     let b:i=l:i
"     let b:env_idx=l:env_idx
"     let b:env_name=l:env_name
"     let b:new_env_name=l:new_env_name

    let l:env_name=escape(l:env_name,'*')
    let l:close_pos=searchpairpos('\\begin\s*{'.l:env_name.'}','','\\end\s*{'.l:env_name.'}\zs','nW',"",l:to_line)
    if l:close_pos != [0, 0]
	call setline(l:open_pos[0],substitute(getline(l:open_pos[0]),'\(\\begin\s*{\)'.l:env_name.'}','\1'.l:new_env_name.'}',''))
	call setline(l:close_pos[0],substitute(getline(l:close_pos[0]),
		    \ '\(\\end\s*{\)'.l:env_name.'}','\1'.l:new_env_name.'}',''))
	echomsg "Environment toggeled at lines: " .l:open_pos[0]." and ".l:close_pos[0]
    endif

    if l:label != "" && g:atp_toggle_labels
	let l:new_env_name_ws=substitute(l:new_env_name,'\*$','','')
	let l:new_short_name=get(g:atp_shortname_dict,l:new_env_name_ws,"")
	let l:short_pattern=join(values(filter(g:atp_shortname_dict,'v:val != ""')),'\|')
	let l:short_name=matchstr(l:label,'^'.l:short_pattern)
	let l:new_label=substitute(l:label,'^'.l:short_name,l:new_short_name,'')

	" check if new label is in use!
	let l:pos_save=getpos(".")
	let l:n=search('\C\\\(label\|\%(eq\|page\)\?ref\)\s*{'.l:new_label.'}','nwc')
" 	let b:n=l:n

	if l:short_name != "" && l:n == 0 && l:new_label != l:label
	    silent! keepjumps execute '%substitute /\\\(eq\|page\)\?\(ref\s*\){'.l:label.'}/\\\1\2{'.l:new_label.'}/gIe'
	    silent! keepjumps execute l:open_pos[0].'substitute /\\label{'.l:label.'}/\\label{'.l:new_label.'}'
	    keepjumps call setpos(".",l:pos_save)
	elseif l:n != 0 && l:new_label != l:label
	    echohl WarningMsg
	    echomsg "Labels not changed, new label: ".l:new_label." is in use!"
	    echohl Normal
	endif
    endif
    return  l:open_pos[0]."-".l:close_pos[0]
endfunction
command! -buffer -nargs=? ToggleEnvironment   		:call <SID>ToggleEnvironment(<f-args>)
nnoremap <silent> <Plug>ToggleEnvForward		:call <SID>ToggleEnvironment(1)
nnoremap <silent> <Plug>ToggleEnvBackward		:call <SID>ToggleEnvironment(-1)
"}}}

"{{{ Help 
function! s:TeXdoc(...)
    let texdoc_arg=""
    for i in range(1,a:0)
	let texdoc_arg.=" " . a:{i}
    endfor
    echo system("texdoc " . texdoc_arg )
endfunction
function! s:TeXdoc_complete(ArgLead, CmdLine, CursorPos)
    let texdoc_alias_files=split(system("texdoc -f"), '\n')
    call filter(texdoc_alias_files, "v:val =~ 'active'")
    call map(texdoc_alias_files, "substitute(substitute(v:val, '^[^/]*\\ze', '', ''), '\/\/\\+', '/', 'g')")
    let aliases = []
    for file in texdoc_alias_files
	call extend(aliases, readfile(file))
    endfor

    call filter(aliases, "v:val =~ 'alias'")
    call filter(map(aliases, "matchstr(v:val, '^\\s*alias\\s*\\zs\\S*\\ze\\s*=')"),"v:val !~ '^\\s*$'")
    let b:files=copy(aliases)

    return filter(copy(aliases), "v:val =~ '^' . a:ArgLead")
endfunction
command -buffer -nargs=* -complete=customlist,<SID>TeXdoc_complete TeXdoc 	:call <SID>TeXdoc(<f-args>)
nnoremap <silent> <buffer> <Plug>TeXdoc		:TeXdoc 
"}}}

" This function deletes tex specific output files (exept the pdf/dvi file, unless
" g:atp_delete_output is set to 1 - then also delets the current output file)
"{{{1 Delete
if !exists("*Delete")
function! Delete()
    call atplib#outdir()
    let l:atp_tex_extensions=deepcopy(g:atp_tex_extensions)
    let s:error=0
    if g:atp_delete_output
	if b:atp_TexCompiler == "pdftex" || b:atp_TexCompiler == "pdflatex"
	    let l:ext="pdf"
	else
	    let l:ext="dvi"
	endif
	call add(l:atp_tex_extensions,l:ext)
    endif
    for l:ext in l:atp_tex_extensions
	if executable(g:rmcommand)
	    if g:rmcommand =~ "^\s*rm\p*" || g:rmcommand =~ "^\s*perltrash\p*"
		if l:ext != "dvi" && l:ext != "pdf"
		    let l:rm=g:rmcommand . " " . shellescape(b:atp_OutDir) . "*." . l:ext . " 2>/dev/null && echo Removed ./*" . l:ext . " files"
		else
		    let l:rm=g:rmcommand . " " . fnamemodify(b:atp_MainFile,":r").".".l:ext . " 2>/dev/null && echo Removed " . fnamemodify(b:atp_MainFile,":r").".".l:ext
		endif
	    endif
" 	    echomsg "DEBUG " l:rm
	echo system(l:rm)
	else
	    let s:error=1
		let l:file=b:atp_OutDir . fnamemodify(expand("%"),":t:r") . "." . l:ext
		if delete(l:file) == 0
		    echo "Removed " . l:file 
		endif
	endif
    endfor


" 	if s:error
" 		echo "Pleas set g:rmcommand to clear the working directory"
" 	endif
endfunction
endif
"}}}1

"{{{1 OpenLog, TexLog, TexLog Buffer Options, PdfFonts, YesNoCompletion
function! OpenLog()
    if filereadable(&l:errorfile)
	exe "tabe +set\\ nospell\\ ruler " . &l:errorfile
    else
	echo "No log file"
    endif
endfunction
command! -buffer OpenLog			:call <SID>OpenLog()
nnoremap <silent> <buffer> <Plug>OpenLog	:call <SID>OpenLog()<CR>

" TeX LOG FILE
if &buftype == 'quickfix'
	setlocal modifiable
	setlocal autoread
endif	
function! TexLog(options)
    if executable("texloganalyser")
       let s:command="texloganalyser " . a:options . " " . &l:errorfile
       echo system(s:command)
    else	
       echo "Please install 'texloganalyser' to have this functionality. The perl program written by Thomas van Oudenhove."  
    endif
endfunction
command! -buffer TexLog			:call <SID>TexLog()
nnoremap <silent> <buffer> <Plug>TexLog	:call <SID>TexLog()<CR>

function! PdfFonts()
    if b:atp_OutDir !~ "\/$"
	b:atp_OutDir=b:atp_OutDir . "/"
    endif
    if executable("pdffonts")
	let s:command="pdffonts " . fnameescape(fnamemodify(b:atp_MainFile,":r")) . ".pdf"
	echo system(s:command)
    else
	echo "Please install 'pdffonts' to have this functionality. In 'gentoo' it is in the package 'app-text/poppler-utils'."  
    endif
endfunction	
command! -buffer PdfFonts			:call <SID>PdfFonts()
nnoremap <silent> <buffer> <Plug>PdfFonts	:call <SID>PdfFonts()<CR>

" function! s:setprintexpr()
"     if b:atp_TexCompiler == "pdftex" || b:atp_TexCompiler == "pdflatex"
" 	let s:ext = ".pdf"
"     else
" 	let s:ext = ".dvi"	
"     endif
"     let &printexpr="system('lpr' . (&printdevice == '' ? '' : ' -P' . &printdevice) . ' " . fnameescape(fnamemodify(expand("%"),":p:r")) . s:ext . "') . + v:shell_error"
" endfunction
" call s:setprintexpr()

fun! YesNoCompletion(A,P,L)
    return ['yes','no']
endfun
"}}}1

" Ssh printing tools
"{{{1 Print, Lpstat, ListPrinters
" This function can send the output file to local or remote printer.
" a:1   = file to print		(if not given printing the output file)
" a:2	= printer name		(if g:atp_ssh is non empty or different from
" 				'localhost' printer on remote server)
" a:3	= printing options	(give printing optinos or 'default' then use
" 				the variable g:printingoptions)
" a:4 	= printing command 	(default lpr)
 function! s:SshPrint(...)

    call atplib#outdir()

    " set the extension of the file to print
    " if prining the tex output file.
    if a:0 == 0 || a:0 >= 1 && a:1 == ""
	let l:ext = get(g:atp_CompilersDict, b:atp_TexCompiler, "not present")
	if l:ext == "not present"
	    echohl WarningMsg
	    echomsg b:atp_TexCompiler . " is not present in g:atp_CompilersDict"
	    echohl Normal
	    return "extension not found"
	endif
	if b:atp_TexCompiler =~ "lua"
	    if b:atp_TexOptions == "" || b:atp_TexOptions =~ "output-format=\s*pdf"
		let l:ext = ".pdf"
	    else
		let l:ext = ".dvi"
	    endif
	endif
    endif

    " set the file to print
    let l:pfile		= ( a:0 == 0 || (a:0 >= 1 && a:1 == "" ) ? b:atp_OutDir . fnamemodify(expand("%"),":t:r") . l:ext : a:1 )

    " set the printing command
    let l:lprcommand	= ( a:0 >= 4 ? a:4 : "lpr" )
    let l:print_options	= ( a:0 >= 3 ? a:3 : g:printingoptions )

    " print locally or remotely
    " the default is to print locally (g:atp_ssh=`whoami`@localhost)
    let l:server	= ( exists("g:atp_ssh") ? strpart(g:atp_ssh,stridx(g:atp_ssh,"@")+1) : "localhost" )
    " To which printer send the file:
    let l:printer	= ( a:0 >= 2 ? "-P " . a:2 : "" )
    " Set Printing Options
    let l:print_options .= " " . l:printer

    echomsg "Server " . l:server
    echomsg "File   " . l:pfile

    if l:server =~ 'localhost'
	let l:ok 		= confirm("Are the printing options set right?\n".l:print_options,"&Yes\n&No\n&Cancel")
	if l:ok == "2"
	    let l:print_options	= input("Give new printing options ")
	elseif l:ok == "3"
	    return "abandoned"
	endif

	let l:com	= l:lprcommand . " " . l:print_options . " " .  fnameescape(l:pfile)

	redraw!
	echomsg "Printing ...  " . l:com
" 	let b:com=l:com " DEBUG
	call system(l:com)
    " print over ssh on the server g:atp_ssh with the printer a:1 (or the
    " default system printer if a:0 == 0
    else 
	" TODO: write completion :).
	let l:ok = confirm("Are the printing options set right?\n".l:print_options,"&Yes\n&No\n&Cancel")
	if l:ok == "2"
	    let l:print_options=input("Give new printing options ")
	elseif l:ok == "3"
	    return "abandoned"
	endif
	redraw!
	let l:com="cat " . fnameescape(l:pfile) . " | ssh " . g:atp_ssh . " " . l:lprcommand . " " . l:print_options
	echomsg "Printing ...  " . l:com
" 	let b:com=l:com " DEBUG
	call system(l:com)
    endif
endfunction
" The command only prints the output file.
command! -complete=custom,ListPrinters  -buffer -nargs=* SshPrint :call <SID>SshPrint("", <f-args>)
nnoremap <silent> <buffer> <Plug>SshPrint	:SshPrint

fun! s:Lpstat()
    if exists("g:apt_ssh") 
	let l:server=strpart(g:atp_ssh,stridx(g:atp_ssh,"@")+1)
    else
	let l:server='locahost'
    endif
    if l:server == 'localhost'
	echo system("lpstat -l")
    else
	echo system("ssh " . g:atp_ssh . " lpstat -l ")
    endif
endfunction
command! -buffer Lpstat	:call <SID>Lpstat()
nnoremap <silent> <buffer> <Plug>Lpstat		:call <SID>Lpstat()<CR>

" it is used for completetion of the command SshPrint
if !exists("*ListPrinters")
function! ListPrinters(A,L,P)
    if exists("g:atp_ssh") && g:atp_ssh !~ '@localhost' && g:atp_ssh != ""
	let l:com="ssh -q " . g:atp_ssh . " lpstat -a | awk '{print $1}'"
    else
	let l:com="lpstat -a | awk '{print $1}'"
    endif
    return system(l:com)
endfunction
endif
"}}}1

" ToDo noto
" {{{1 ToDo
"
" TODO if the file was not found ask to make one.
function! s:ToDo(keyword,stop,...)

    if a:0 == 0
	let bufname	= bufname("%")
    else
	let bufname	= a:1
    endif

    " read the buffer
    let texfile=getbufline(bufname, 1, "$")

    " find ToDos
    let todo = {}
    let nr=1
    for line in texfile
	if line =~ '%.*' . a:keyword 
	    call extend(todo, { nr : line }) 
	endif
	let nr += 1
    endfor

    " Show ToDos
    echohl atp_Todo
    if len(keys(todo)) == 0
	echomsg " List for '%.*" . a:keyword . "' in '" . bufname . "' is empty."
	return
    endif
    echomsg " List for '%.*" . a:keyword . "' in '" . bufname . "':"
    let sortedkeys=sort(keys(todo),"atplib#CompareList")
    for key in sortedkeys
	" echo the todo line.
	echomsg key . " " . substitute(substitute(todo[key],'%','',''),'\t',' ','g')
	let true	= 1
	let a		= 1
	let linenr	= key
	" show all comment lines right below the found todo line.
	while true && texfile[linenr] !~ '%.*\c\<todo\>' 
	    let linenr=key+a-1
	    if texfile[linenr] =~ "\s*%" && texfile[linenr] !~ a:stop
		" make space of length equal to len(linenr)
		let space=""
		let j=0
		while j < len(linenr)
		    let space=space . " " 
		    let j+=1
		endwhile
		echomsg space . " " . substitute(substitute(texfile[linenr],'%','',''),'\t',' ','g')
	    else
		let true = 0
	    endif
	    let a += 1
	endwhile
    endfor
    echohl None
endfunction
command! -buffer -nargs=? -complete=buffer ToDo		:call <SID>ToDo('\c\<to\s*do\>','\s*%\c.*\<note\>',<f-args>)
command! -buffer -nargs=? -complete=buffer Note		:call <SID>ToDo('\c\<note\>','\s*%\c.*\<to\s*do\>',<f-args>)
" }}}1

" This functions reloads ATP (whole or just a function)
" {{{1  RELOAD

if !exists("g:debug_atp_plugin")
    let g:debug_atp_plugin=0
endif
if g:debug_atp_plugin==1 && !exists("*Reload")
" Reload() - reload all the tex_apt functions
" Reload(func1,func2,...) reload list of functions func1 and func2
fun! Reload(...)
    let l:pos_saved=getpos(".")
    let l:bufname=fnamemodify(expand("%"),":p")

    if a:0 == 0
	let l:runtime_path=split(&runtimepath,',')
	echo "Searching for atp plugin files"
	let l:file_list=['ftplugin/tex_atp.vim', 'ftplugin/fd_atp.vim', 
		    \ 'ftplugin/bibsearch_atp.vim', 'ftplugin/toc_atp.vim', 
		    \ 'autoload/atplib.vim', 'ftplugin/atp_LatexBox.vim',
		    \ 'indent/tex_atp.vim' ]
	let l:file_path=[]
	for l:file in l:file_list
		call add(l:file_path,globpath(&rtp,l:file))
	endfor
" 	if exists("b:atp_debug")
" 	    if b:atp_debug == "v" || b:atp_debug == "verbose"
" 		echomsg string(l:file_path)
" 	    endif
" 	endif
	for l:file in l:file_path
	    echomsg "deleting FUNCTIONS and VARIABLES from " . l:file
	    let l:atp=readfile(l:file)
	    for l:line in l:atp
		let l:function_name=matchstr(l:line,'^\s*fun\%(ction\)\?!\?\s\+\zs\<[^(]*\>\ze(')
		if l:function_name != "" && l:function_name != "Reload"
		    if exists("*" . l:function_name)
			if exists("b:atp_debug")
			    if b:atp_debug == "v" || b:atp_debug == "verbose"
				echomsg "deleting function " . l:function_name
			    endif
			endif
			execute "delfunction " . l:function_name
		    endif
		endif
		let l:variable_name=matchstr(l:line,'^\s*let\s\+\zsg:[a-zA-Z_^{}]*\ze\>')
		if exists(l:variable_name)
		    execute "unlet ".l:variable_name
		    if exists("b:atp_debug")
			if b:atp_debug == "v" || b:atp_debug == "verbose"
			    echomsg "unlet ".l:variable_name
			endif
		    endif
		endif
	    endfor
	endfor
    else
	if a:1 != "maps" && a:1 != "reload"
	    let l:f_list=split(a:1,',')
	    let g:f_list=l:f_list
	    for l:function in l:f_list
		execute "delfunction " . l:function
		if exists("b:atp_debug")
		    if b:atp_debug == "v" || b:atp_debug == "verbose"
			echomsg "delfunction " . l:function
		    endif
		endif
	    endfor
	endif
    endif
    au! CursorHold *.tex
    w
"   THIS IS THE SLOW WAY:
    bd!
    execute "edit " . fnameescape(l:bufname)
    keepjumps call setpos(".",l:pos_saved)
"   This could be faster: but aparently doesn't work.
"     execute "source " . l:file_path[0]
endfunction
endif
command -buffer -nargs=* -complete=function Reload	:call Reload(<f-args>)
" }}}1

" vim:fdm=marker:tw=85:ff=unix:noet:ts=8:sw=4:fdc=1
