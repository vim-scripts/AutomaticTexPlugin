" Author:	Marcin Szamotulski	
" Descriptiion:	These are various editting tools used in ATP.
" Note:		This file is a part of Automatic Tex Plugin for Vim.
" URL:		https://launchpad.net/automatictexplugin
" Language:	tex

let s:sourced 	= exists("s:sourced") ? 1 : 0

" FUNCTIONS: (source once)
if !s:sourced || g:atp_reload_functions "{{{
" This is the wrap selection function.
" {{{ WrapSelection
function! s:WrapSelection(wrapper,...)

    let l:end_wrapper 	= ( a:0 >= 1 ? a:1 : '}' )
    let l:cursor_pos	= ( a:0 >= 2 ? a:2 : 'end' )
    let l:new_line	= ( a:0 >= 3 ? a:3 : 0 )

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
		let l:begin_choice=1
		call setline(l:begin[1],l:bbegin_line)
		call append(l:begin[1],l:indent.a:wrapper) " THERE IS AN ISSUE HERE!
		call append(copy(l:begin[1])+1,l:indent.substitute(l:ebegin_line,'^\s*','',''))
		let l:end[1]+=2
	    elseif l:bbegin_line =~ '^\s\+$'
		let l:begin_choice=2
		call append(l:begin[1]-1,l:indent.a:wrapper)
		call append(l:begin[1],l:begin_line.l:ebegin_line)
		let l:end[1]+=2
	    else
		let l:begin_choice=3
		call append(copy(l:begin[1])-1,l:indent.a:wrapper)
		let l:end[1]+=1
	    endif
	    if l:eend_line !~ '^\s*$'
		let l:end_choice=4
		call setline(l:end[1],l:bend_line)
		call append(l:end[1],l:indent.l:end_wrapper)
		call append(copy(l:end[1])+1,l:indent.substitute(l:eend_line,'^\s*','',''))
	    else
		let l:end_choice=5
		call append(l:end[1],l:indent.l:end_wrapper)
	    endif
	    if (l:end[1] - l:begin[1]) >= 0
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
	    let l:line=l:begin_l.a:wrapper.l:middle_l.l:end_wrapper.l:end_l
	    call setline(l:begin[1],l:line)
	    let l:end[2]+=len(a:wrapper)+1
	else
	    " in seprate lines
	    let b:begin_l=l:begin_l
	    let b:middle_l=l:middle_l
	    let b:end_l=l:end_l

	    let l:indent=atplib#CopyIndentation(l:begin_line)

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
"}}}
"{{{ Inteligent Wrap Selection 
" This function selects the correct font wrapper for math/text environment.
" the rest of arguments are the same as for WrapSelection (and are passed to
" WrapSelection function)
" a:text_wrapper	= [ 'begin_text_wrapper', 'end_text_wrapper' ] 
" a:math_wrapper	= [ 'begin_math_wrapper', 'end_math_wrapper' ] 
" if end_(math\|text)_wrapper is not given '}' is used (but neverthe less both
" arguments must be lists).
function! s:InteligentWrapSelection(text_wrapper, math_wrapper, ...)

    let cursor_pos	= ( a:0 >= 1 ? a:2 : 'end' )
    let new_line	= ( a:0 >= 2 ? a:3 : 0 )

    let MathZones = copy(g:atp_MathZones)
    let pattern		= '^texMathZone[VWX]'
    if b:atp_TexFlavor == 'plaintex'
	call add(MathZones, 'texMathZoneY')
	let pattern	= '^texMathZone[VWXY]'
    endif

    " select the correct wrapper

    let MathZone	= get(filter(map(synstack(line("."),max([1,col(".")-1])),"synIDattr(v:val,'name')"),"v:val=~pattern"),0,"")
    if MathZone	=~ '^texMathZone[VWY]'
	let step 	= 2
    elseif MathZone == 'texMathZoneX'
	let step 	= 1
    else
	let step	= 0
    endif

    " Note: in visual mode col(".") returns always the column starting position of
    " the visual area, thus it is enough to check the begining (if we stand on
    " $:\(:\[:$$ use text wrapper). 
    if !empty(MathZone) && col(".") > step && atplib#CheckSyntaxGroups(MathZones, line("."), max([1, col(".")-step]))
	let begin_wrapper 	= a:math_wrapper[0]
	let end_wrapper 	= get(a:math_wrapper,1, '}')
    else
	let begin_wrapper	= a:text_wrapper[0]
	let end_wrapper		= get(a:text_wrapper,1, '}')
    endif

    " if the wrapper is empty return
    " useful for wrappers which are valid only in one mode.
    if begin_wrapper == ""
	return
    endif

    call s:WrapSelection(begin_wrapper, end_wrapper, cursor_pos, new_line) 
endfunction
"}}}

" Inteligent Aling
" TexAlign {{{
" This needs Aling vim plugin.
function! TexAlign()
    let save_pos = getpos(".")
    let synstack = map(synstack(line("."), col(".")), 'synIDattr( v:val, "name")')
    if count(synstack, 'texMathZoneA') || count(synstack, 'texMathZoneAS')
	let bpat = '\\begin\s*{\s*align\*\=\s*}' 
	let epat = '\\end\s*{\s*align\*\=\s*}' 
	let AlignCtr = 'Il+ &'
" 	let g:debug = "align"
    elseif count(synstack, 'texMathZoneB') || count(synstack, 'texMathZoneBS')
	let bpat = '\\begin\s*{\s*alignat\*\=\s*}' 
	let epat = '\\end\s*{\s*alignat\*\=\s*}' 
	let AlignCtr = 'Il+ &'
" 	let g:debug = "alignat"
    elseif count(synstack, 'texMathZoneD') || count(synstack, 'texMathZoneDS')
	let bpat = '\\begin\s*{\s*eqnarray\*\=\s*}' 
	let epat = '\\end\s*{\s*eqnarray\*\=\s*}' 
	let AlignCtr = 'Il+ &'
" 	let g:debug = "eqnarray"
    elseif count(synstack, 'texMathZoneE') || count(synstack, 'texMathZoneES')
	let bpat = '\\begin\s*{\s*equation\*\=\s*}' 
	let epat = '\\end\s*{\s*equation\*\=\s*}' 
	let AlignCtr = 'Il+ =+-'
" 	let g:debug = "equation"
    elseif count(synstack, 'texMathZoneF') || count(synstack, 'texMathZoneFS')
	let bpat = '\\begin\s*{\s*flalign\*\=\s*}' 
	let epat = '\\end\s*{\s*flalign\*\=\s*}' 
	let AlignCtr = 'jl+ &'
" 	let g:debug = "falign"
"     elseif count(synstack, 'texMathZoneG') || count(synstack, 'texMathZoneGS')
"     gather doesn't need alignment (by design it give unaligned equation.
" 	let bpat = '\\begin\s*{\s*gather\*\=\s*}' 
" 	let epat = '\\end\s*{\s*gather\*\=\s*}' 
" 	let AlignCtr = 'Il+ &'
" 	let g:debug = "gather"
    elseif count(synstack, 'displaymath')
	let bpat = '\\begin\s*{\s*displaymath\*\=\s*}' 
	let epat = '\\end\s*{\s*displaymath\*\=\s*}' 
	let AlignCtr = 'Il+ =+-'
" 	let g:debug = "displaymath"
    elseif searchpair('\\begin\s*{\s*tabular\s*\}', '', '\\end\s*{\s*tabular\s*}', 'bnW', '', max([1, (line(".")-g:atp_completion_limits[2])]))
	let bpat = '\\begin\s*{\s*tabular\*\=\s*}' 
	let epat = '\\end\s*{\s*tabular\*\=\s*}' 
	let AlignCtr = 'jl+ &'
" 	let g:debug = "tabular"
    elseif searchpair('\\matrix\s*\[[^]]*\]\s*{', '', '}', 'bnW', '', max([1, (line(".")-g:atp_completion_limits[2])]))
	let bpat = '\\matrix\s*\[[^]]*\]\s*{'
	let epat = '}'
	let AlignCtr = 'jl+ &'
	let g:debug = "matrix"
    else
	return
    endif

    " Check if we are inside array environment
    let align = searchpair('\\begin\s*{\s*array\s*}', '', '\\end\s*{\s*array\s*}', 'bnW')
    if align
" 	let bpat = '\\begin\s*{\s*array\s*}'
	let bline = align + 1
	let epat = '\\end\s*{\s*array\s*}'
	let AlignCtr = 'Il+ &'
    endif

"     let g:AlignCtr = AlignCtr

    if !exists("bline")
	let bline = search(bpat, 'cnb') + 1
    endif
    let eline = searchpair(bpat, '', epat, 'cn')  - 1

" 	let g:bline = bline
" 	let g:eline = eline

    if bline <= eline
	execute bline . ',' . eline . 'Align ' . AlignCtr
    endif

    call setpos(".", save_pos) 
endfunction
"}}}

" Insert() function, which is used to insert text depending on mode: text/math. 
" {{{ Insert()
" Should be called via an imap:
" imap <lhs> 	<Esc>:call Insert(text, math)<CR>a
" a:text	= text to insert in text mode
" a:math	= text to insert in math mode	
function! Insert(text, math)

    let MathZones = copy(g:atp_MathZones)
    if b:atp_TexFlavor == 'plaintex'
	call add(MathZones, 'texMathZoneY')
    endif

    " select the correct wrapper
    if atplib#CheckSyntaxGroups(MathZones, line("."), col("."))
	let insert	= a:math
    else
	let insert	= a:text
    endif

    " if the insert variable is empty return
    if empty(insert)
	return
    endif

    let line		= getline(".")
    let col		= col(".")

    let new_line	= strpart(line, 0, col) . insert . strpart(line, col)
    call setline(line("."), new_line)
    call cursor(line("."), col(".")+len(insert))
    return ""
endfunction
" }}}
" Insert \item update the number. 
" {{{ InsertItem()
" ToDo: indent
function! InsertItem()
    let begin_line	= searchpair( '\\begin\s*{\s*\%(enumerate\|itemize\)\s*}', '', '\\end\s*{\s*\%(enumerate\|itemize\)\s*}', 'bnW')
    let saved_pos	= getpos(".")
    call cursor(line("."), 1)

    " This will work with \item [[1]], but not with \item [1]]
    let [ bline, bcol]	= searchpos('\\item\s*\zs\[', 'b', begin_line) 
    if bline == 0
	keepjumps call setpos(".", saved_pos)
	let new_line	= strpart(getline("."), 0, col(".")) . '\item'. strpart(getline("."), col("."))
	call setline(line("."), new_line)

	" Indent the line:
	if &l:indentexpr != ""
	    execute "let indent = " . &l:indentexpr
	    let i 	= 1
	    let ind 	= ""
	    while i <= indent
		let ind	.= " "
		let i	+= 1
	    endwhile
	else
	    indent	= -1
	    ind 	=  matchstr(getline("."), '^\s*')
	endif
	call setline(line("."), ind . substitute(getline("."), '^\s*', '', ''))

	" Set the cursor position
	let saved_pos[2]	+= len('\item') + indent
	keepjumps call setpos(".", saved_pos)

	return ""
    endif
    let [ eline, ecol]	= searchpairpos('\[', '', '\]', 'nr', '', line("."))
    if eline != bline
	return ""
    endif

    let item		= strpart(getline("."), bcol, ecol - bcol - 1)
    let bpat		= '(\|{\|\['
    let epat		= ')\|}\|\]\|\.'
    let number		= matchstr(item, '\d\+')
    let subNr		= matchstr(item, '\d\+\zs\a\ze')
    let space		= matchstr(getline("."), '\\item\zs\s*\ze\[')
    if nr2char(number) != "" && subNr == "" 
	let new_item	= substitute(item, number, number + 1, '')
    elseif nr2char(number) != "" && subNr != ""
	let alphabet 	= [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'w', 'x', 'y', 'z' ] 
	let char	= matchstr(item, '^\%('.bpat.'\)\=\s*\d\+\zs\a\ze\s*\%('.epat.'\)\=$')
	let new_char	= get(alphabet, index(alphabet, char) + 1, 'z')
	let new_item	= substitute(item, '^\%('.bpat.'\)\=\s*\d\+\zs\a\ze\s*\%('.epat.'\)\=$', new_char, 'g')
    elseif item =~ '\%('.bpat.'\)\=\s*\w\s*\%('.epat.'\)\='
	let alphabet 	= [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'w', 'x', 'y', 'z' ] 
	let char	= matchstr(item, '^\%('.bpat.'\)\=\s*\zs\w\ze\s*\%('.epat.'\)\=$')
	let new_char	= get(alphabet, index(alphabet, char) + 1, 'z')
	let new_item	= substitute(item, '^\%('.bpat.'\)\=\s*\zs\w\ze\s*\%('.epat.'\)\=$', new_char, 'g')
    else
	let new_item	= item
    endif

    keepjumps call setpos(".", saved_pos)

    let new_line	= strpart(getline("."), 0, col(".")) . '\item' . space . '[' . new_item . ']' . strpart(getline("."), col("."))
    call setline(line("."), new_line)

    " Indent the line:
    if &l:indentexpr != ""
	execute "let indent = " . &l:indentexpr
	let i 	= 1
	let ind 	= ""
	while i <= indent
	    let ind	.= " "
	    let i	+= 1
	endwhile
    else
	ind 	= matchstr(getline("."), '^\s*')
    endif
    call setline(line("."), ind . substitute(getline("."), '^\s*', '', ''))

    " Set the cursor position
    let saved_pos[2]	+= len('\item' . space . '[' . new_item . ']') + indent
    keepjumps call setpos(".", saved_pos)


    return ""
endfunction
" }}}

" Editing Toggle Functions
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
    let g:atp_toggle_environment_6=[  'equation', 'align', 'array', 'alignat', 'gather', 'flalign', 'multline'  ]
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
"{{{ ToggleStar
" this function adds a star to the current environment
" todo: to doc.
function! s:ToggleStar()

    " limit:
    let from_line=max([1,line(".")-g:atp_completion_limits[2]])
    let to_line=line(".")+g:atp_completion_limits[2]

    " omit pattern
    let omit=join(g:atp_no_star_environments,'\|')
    let open_pos=searchpairpos('\\begin\s*{','','\\end\s*{[^}]*}\zs','cbnW','getline(".") =~ "\\\\begin\\s*{".omit."}"',from_line)
    let b:open_pos=open_pos
    let env_name=matchstr(strpart(getline(open_pos[0]),open_pos[1]),'begin\s*{\zs[^}]*\ze}')
    let b:env_name=env_name
    if ( open_pos == [0, 0] || index(g:atp_no_star_environments,env_name) != -1 ) && getline(line(".")) !~ '\\\%(part\|chapter\|\%(sub\)\{0,2}section\)'
	return
    endif
    if env_name =~ '\*$'
	let env_name=substitute(env_name,'\*$','','')
	let close_pos=searchpairpos('\\begin\s*{'.env_name.'\*}','','\\end\s*{'.env_name.'\*}\zs','cnW',"",to_line)
	if close_pos != [0, 0]
	    call setline(open_pos[0],substitute(getline(open_pos[0]),'\(\\begin\s*{\)'.env_name.'\*}','\1'.env_name.'}',''))
	    call setline(close_pos[0],substitute(getline(close_pos[0]),
			\ '\(\\end\s*{\)'.env_name.'\*}','\1'.env_name.'}',''))
	    echomsg "Star removed from '".env_name."*' at lines: " .open_pos[0]." and ".close_pos[0]
	endif
    else
	let close_pos=searchpairpos('\\begin\s{'.env_name.'}','','\\end\s*{'.env_name.'}\zs','cnW',"",to_line)
	if close_pos != [0, 0]
	    call setline(open_pos[0],substitute(getline(open_pos[0]),
		    \ '\(\\begin\s*{\)'.env_name.'}','\1'.env_name.'\*}',''))
	    call setline(close_pos[0],substitute(getline(close_pos[0]),
			\ '\(\\end\s*{\)'.env_name.'}','\1'.env_name.'\*}',''))
	    echomsg "Star added to '".env_name."' at lines: " .open_pos[0]." and ".close_pos[0]
	endif
    endif

    " Toggle the * in \section, \chapter, \part commands.
    if getline(line(".")) =~ '\\\%(part\|chapter\|\%(sub\)\{0,2}section\)\*'
	let pos = getpos(".")
	substitute/\(\\part\|\\chapter\|\\\%(sub\)\{0,2}section\)\*/\1/
	call cursor(pos[1], pos[2])
    elseif getline(line(".")) =~ '\\\%(part\|chapter\|\%(sub\)\{0,2}section\)'
	let pos = getpos(".")
	substitute/\(\\part\|\\chapter\|\\\%(sub\)\{0,2}section\)/\1*/
	call cursor(pos[1], pos[2])
    endif
endfunction
"}}}
"{{{ ToggleEnvironment
" this function toggles envrionment name.
" Todo: to doc.
" a:ask = 0 toggle, 1 ask for the new env name if not given as the first argument. 
" the argument specifies the speed (if -1 then toggle back)
" default is '1' or the new environment name
try
function! s:ToggleEnvironment(ask, ...)

    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)
    " l:add might be a number or an environment name
    " if it is a number the function will jump this amount in appropriate list
    " (g:atp_toggle_environment_[123...]) to find new environment name
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
"     let b:line=strpart(getline(l:open_pos[0]),l:open_pos[1])
"     let b:label=l:label
"     let b:env_name=l:env_name
    if l:open_pos == [0, 0] || index(g:atp_no_toggle_environments,l:env_name) != -1
	return
    endif

    let l:env_name_ws=substitute(l:env_name,'\*$','','')

    if !a:ask
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
    else
	if l:add == 1
	    let l:new_env_name=input("What is the new name for " . l:env_name . "? type and hit <Enter> ", "", "customlist,<SID>EnvCompletion" )
	    if l:new_env_name == ""
		echomsg "Environment name not changed"
		return
	    endif
	else
	    let l:new_env_name = l:add
	endif
    endif

    " DEBUG
"     let g:i=l:i
"     let g:env_idx=l:env_idx
"     let g:env_name=l:env_name
"     let g:add = l:add
"     let g:new_env_name=l:new_env_name

    let l:env_name=escape(l:env_name,'*')
    let l:close_pos=searchpairpos('\\begin\s*{'.l:env_name.'}','','\\end\s*{'.l:env_name.'}\zs','nW',"",l:to_line)
    if l:close_pos != [0, 0]
	call setline(l:open_pos[0],substitute(getline(l:open_pos[0]),'\(\\begin\s*{\)'.l:env_name.'}','\1'.l:new_env_name.'}',''))
	call setline(l:close_pos[0],substitute(getline(l:close_pos[0]),
		    \ '\(\\end\s*{\)'.l:env_name.'}','\1'.l:new_env_name.'}',''))
	echomsg "Environment toggeled at lines: " .l:open_pos[0]." and ".l:close_pos[0]
    endif

    if l:label != "" && g:atp_toggle_labels
	if l:env_name == ""
	    let l:new_env_name_ws=substitute(l:new_env_name,'\*$','','')
	    let l:new_short_name=get(g:atp_shortname_dict,l:new_env_name_ws,"")
	    let l:new_label =  l:new_short_name . strpart(l:label, stridx(l:label, g:atp_separator))
" 	    let g:new_label = l:new_label . "XXX"
	else
" 	    let g:label = l:label
	    let l:new_env_name_ws=substitute(l:new_env_name,'\*$','','')
" 	    let g:new_env_name_ws=l:new_env_name_ws
	    let l:new_short_name=get(g:atp_shortname_dict,l:new_env_name_ws,"")
" 	    let g:new_short_name=l:new_short_name
	    let l:short_pattern= '^\(\ze:\|' . join(values(filter(g:atp_shortname_dict,'v:val != ""')),'\|') . '\)'
" 	    let g:short_pattern=l:short_pattern
	    let l:short_name=matchstr(l:label, l:short_pattern)
" 	    let g:short_name=l:short_name
	    let l:new_label=substitute(l:label,'^'.l:short_name,l:new_short_name,'')
" 	    let g:new_label=l:new_label
	endif


	" check if new label is in use!
	let pos_save=getpos(".")
	let n=search('\m\C\\\(label\|\%(eq\|page\)\?ref\)\s*{'.l:new_label.'}','nwc')

	if n == 0 && l:new_label != l:label
	    let hidden =  &hidden
	    set hidden
	    silent! keepjumps execute l:open_pos[0].'substitute /\\label{'.l:label.'}/\\label{'.l:new_label.'}'
	    " This should be done for every file in the project. 
	    if !exists("b:TypeDict")
		call TreeOfFiles(atp_MainFile)
	    endif
	    let save_view 	= winsaveview()
	    let file		= expand("%:p")
	    let project_files = keys(filter(b:TypeDict, "v:val == 'input'")) + [ atp_MainFile ]
	    for project_file in project_files
		if atplib#FullPath(project_file) != expand("%:p")
		    exe "silent keepalt edit " . project_file
		endif
		let pos_save_pf=getpos(".")
		silent! keepjumps execute '%substitute /\\\(eq\|page\)\?\(ref\s*\){'.l:label.'}/\\\1\2{'.l:new_label.'}/gIe'
		keepjumps call setpos(".", pos_save_pf)
	    endfor
	    execute "keepalt buffer " . file
	    keepjumps call setpos(".", pos_save)
	    let &hidden = hidden
	elseif n != 0 && l:new_label != l:label
	    echohl WarningMsg
	    echomsg "Labels not changed, new label: ".l:new_label." is in use!"
	    echohl Normal
	endif
    endif
    return  l:open_pos[0]."-".l:close_pos[0]
endfunction
catch /E127:/
endtry "}}}

" This is completion for input() inside ToggleEnvironment which uses
" b:atp_LocalEnvironments variable.
function! <SID>EnvCompletion(ArgLead, CmdLine, CursorPos)
    if !exists("b:atp_LocalEnvironments")
	LocalCommands
    endif

    let env_list = copy(b:atp_LocalEnvironments)
    call filter(env_list, "v:val =~ '^' .a:ArgLead")
    let g:env_list = copy(env_list)
    let g:ArgLead = a:ArgLead
    let g:CmdLine = a:CmdLine
    return env_list
endfunction
" TexDoc commanand and its completion
" {{{ TexDoc 
" This is non interactive !, use :!texdoc for interactive command.
" But it simulates it with a nice command completion (Ctrl-D, <Tab>)
" based on alias files for texdoc.
function! s:TexDoc(...)
    let texdoc_arg	= ""
    for i in range(1,a:0)
	let texdoc_arg.=" " . a:{i}
    endfor
    if texdoc_arg == ""
	let texdoc_arg 	= "-m " . g:atp_TeXdocDefault
    endif
    " If the file is a text file texdoc is 'cat'-ing it into the terminal,
    " we use echo to capture the output. 
    " The rediraction prevents showing texdoc info messages which are not that
    " important, if a document is not found texdoc sends a message to the standard
    " output not the error.
    "
    " -I prevents from using interactive menus
    echo system("texdoc " . texdoc_arg . " 2>/dev/null")
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

    return filter(copy(aliases), "v:val =~ '^' . a:ArgLead")
endfunction
" }}}

" This function deletes tex specific output files (exept the pdf/dvi file, unless
" bang is used - then also delets the current output file)
" {{{ Delete
function! s:Delete(delete_output)

    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)
    call atplib#outdir()

    let l:atp_tex_extensions=deepcopy(g:atp_tex_extensions)
    let error=0

    if a:delete_output == "!"
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
		    let l:rm=g:rmcommand . " " . shellescape(b:atp_OutDir) . "*." . l:ext . " 2>/dev/null && echo Removed: ./*" . l:ext 
		else
		    let l:rm=g:rmcommand . " " . fnamemodify(atp_MainFile,":r").".".l:ext . " 2>/dev/null && echo Removed: " . fnamemodify(atp_MainFile,":r").".".l:ext
		endif
	    endif
	    if !exists("g:rm")
		let g:rm	= [l:rm] 
	    else
		call add(g:rm, l:rm)
	    endif
	    echo system(l:rm)
	else
	    let error=1
	    let file=b:atp_OutDir . fnamemodify(expand("%"),":t:r") . "." . l:ext
	    if delete(file) == 0
		echo "Removed " . l:file 
	    endif
	endif
    endfor

" 	if error
" 		echo "Please set g:rmcommand to clear the working directory"
" 	endif
endfunction
"}}}

"{{{ OpenLog, TexLog, TexLog Buffer Options, PdfFonts, YesNoCompletion
"{{{ s:Search function for Log Buffer
function! <SID>Search(pattern, flag, ...)
    echo ""
    let center 	= ( a:0 >= 1 ? a:1 : 1 )
    let @/	= a:pattern

    " Count:
"     let nr 	= 1
"     while nr <= a:count
" 	let keepjumps = ( a:nr < a:count ? 'keepjumps' : '')
" 	exe keepjumps . "let line = search(a:pattern, a:flag)"
" 	let nr	+= 1
"     endwhile

    let line = search(a:pattern, a:flag)

    if !line
	let message = a:flag =~# 'b' ? 'previous' : 'next'
	if a:pattern =~ 'warning'
	    let type = 'warning'
	elseif a:pattern =~ '\^!'
	    let type = 'error'
	elseif a:pattern =~ 'info'
	    let type = 'info'
	else
	    let type = ''
	endif
	echohl WarningMsg
	echo "No " . message . " " . type . " message."
	echohl Normal
    endif
" This fails (?):
"     if center
" 	normal zz
"     endif
endfunction
" command! -count=1 -nargs=* <SID>Search	:call <SID>Search(<count>,<args>)

function! <SID>Searchpair(start, middle, end, flag, ...)
    let center 	= ( a:0 >= 1 ? a:1 : 1 )
    if getline(".")[col(".")-1] == ')' 
	let flag= a:flag.'b'
    else
	let flag= substitute(a:flag, 'b', '', 'g')
    endif
    call searchpair(a:start, a:middle, a:end, flag)
"     if center
" 	normal zz
"     endif
endfunction
"}}}
function! s:OpenLog()
    if filereadable(&l:errorfile)

	let projectVarDict = SaveProjectVariables()
	let g:projectVarDict = projectVarDict
	let s:winnr		= bufwinnr("")
	exe "rightbelow split +setl\\ nospell\\ ruler\\ syn=log_atp\\ autoread " . fnameescape(&l:errorfile)
	call RestoreProjectVariables(projectVarDict)

	map <buffer> q :bd!<CR>
	nnoremap <silent> <buffer> ]m :call <SID>Search('\CWarning\\|^!', 'W')<CR>
	nnoremap <silent> <buffer> [m :call <SID>Search('\CWarning\\|^!', 'bW')<CR>
	nnoremap <silent> <buffer> ]w :call <SID>Search('\CWarning', 'W')<CR>
	nnoremap <silent> <buffer> [w :call <SID>Search('\CWarning', 'bW')<CR>
	nnoremap <silent> <buffer> ]c :call <SID>Search('\CLaTeX Warning: Citation', 'W')<CR>
	nnoremap <silent> <buffer> [c :call <SID>Search('\CLaTeX Warning: Citation', 'bW')<CR>
	nnoremap <silent> <buffer> ]r :call <SID>Search('\CLaTeX Warning: Reference', 'W')<CR>
	nnoremap <silent> <buffer> [r :call <SID>Search('\CLaTeX Warning: Reference', 'bW')<CR>
	nnoremap <silent> <buffer> ]e :call <SID>Search('^!', 'W')<CR>
	nnoremap <silent> <buffer> [e :call <SID>Search('^!', 'bW')<CR>
	nnoremap <silent> <buffer> ]f :call <SID>Search('\CFont \%(Info\\|Warning\)', 'W')<CR>
	nnoremap <silent> <buffer> [f :call <SID>Search('\CFont \%(Info\\|Warning\)', 'bW')<CR>
	nnoremap <silent> <buffer> ]p :call <SID>Search('\CPackage', 'W')<CR>
	nnoremap <silent> <buffer> [p :call <SID>Search('\CPackage', 'bW')<CR>
	nnoremap <silent> <buffer> ]P :call <SID>Search('\[\_d\+\zs', 'W')<CR>
	nnoremap <silent> <buffer> [P :call <SID>Search('\[\_d\+\zs', 'bW')<CR>
	nnoremap <silent> <buffer> ]i :call <SID>Search('\CInfo', 'W')<CR>
	nnoremap <silent> <buffer> [i :call <SID>Search('\CInfo', 'bW')<CR>
	nnoremap <silent> <buffer> % :call <SID>Searchpair('(', '', ')', 'W')<CR>

"	This prevents vim from reloading with 'autoread' option: the buffer is
"	modified outside and inside vim.
	try
	    silent! execute 'keepjumps %g/^\s*$/d'
	    silent! execute "keepjumps normal ''"
	catch /E486:/ 
	endtry
		   
	function! <SID>SyncTex(bang,...)

	    let cwd = getcwd()
	    exe "lcd " . fnameescape(b:atp_ProjectDir )

	    let g:debugST	= 0

	    " if sync = 1 sync log file and the window - can be used by autocommand
	    let sync = ( a:0 >= 1 ? a:1 : 0 )
		if g:atp_debugST
		    let g:sync = sync
		endif 

	    if sync && !g:atp_SyncLog
		exe "normal! " . cwd
		let g:debugST 	= 1
		return
	    endif

	    " Find the end pos of error msg
	    keepjumps let [ stopline, stopcol ] = searchpairpos('(', '', ')', 'nW') 
		if g:atp_debugST
		    let g:stopline = stopline
		endif

	    let saved_pos = getpos(".")

	    " Be linewise
	    call setpos(".", [0, line("."), 1, 0])

	    " Find the line nr
" 	    keepjumps let [ LineNr, ColNr ] = searchpos('^l.\zs\d\+\>\|oninput line \zs\|at lines \zs', 'W', stopline)
	    keepjumps let [ LineNr, ColNr ] = searchpos('^l.\zs\d\+\>\|o\n\=n\_s\+i\n\=n\n\=p\n\=u\n\=t\_s\+l\n\=i\n\=n\n\=e\_s\+\zs\|a\n\=t\_s\+l\n\=i\n\=n\n\=e\n\=s\_s\+\zs', 'W', stopline)
	    let line	= strpart(getline(LineNr), ColNr-1)
	    let lineNr 	= matchstr(line, '^\d\+\ze')
		let g:lineNr=lineNr
	    if lineNr !~ '\d\+'
		keepjumps call setpos(".", saved_pos)
		return
	    endif
	    if getline(LineNr) =~ '^l\.\d\+'
		let error = escape(matchstr(getline(LineNr), '^l\.\d\+\s*\zs.*$'), '\.')
" 		let error = escape(matchstr(getline(LineNr), '^l\.\d\+\s*\zs.*$'), '\.') . '\s*' .  escape(substitute(strpart(getline(LineNr+1), 0, stridx(getline(LineNr+1), '...')), '^\s*', '', ''), '\.')
		if g:atp_debugST
		    let g:error = error
		endif
	    endif

	    " Find the file name/bufnr/winnr where the error occurs. 
	    let test 	= 0
	    let nr	= 0
	    " There should be a finer way to get the file name if it is split in two
	    " lines.
	    while !test
		" Some times in the lof file there is a '(' from the source tex file
		" which might be not closed, then this while loop is used to find
		" readable file name.
		let [ startline, startcol ] = searchpairpos('(', '', ')', 'bW') 
		if g:atp_debugST
		    redir! >> /tmp/SyncTex_log
		    let g:startline = startline
		    silent! echomsg " [ startline, startcol ] " . string([ startline, startcol ])
		endif
" THIS CODE IS NOT WORKING:
" 		if nr >= 1 && [ startline, startcol ] == [ startline_o, startcol_o ] && !test
" 		    keepjumps call setpos(".", saved_pos)
" 		    let g:debug = "return " . nr
" 		    break
" 		endif
		if !startline
		    if g:atp_debugST
			silent! echomsg "END startline = " . startline
			redir END
		    endif
		    keepjumps call setpos(".", saved_pos)
		    return
		endif
		let fname 	= matchstr(strpart(getline(startline), startcol), '^\f\+') 
		" if the file name was broken in the log file in two lines,
		" get the end of file name from the next line. 
		let tex_extensions = extend(copy(g:atp_tex_extensions), [ 'tex', 'cls', 'sty', 'clo', 'def' ], 0)
		let pat = '\.\%('.join(tex_extensions, '\|').'\)$'
		if fname !~# pat
		    let stridx = {}
		    for end in tex_extensions
			call extend(stridx, { end : stridx(getline(startline+1), "." . end) })
		    endfor
		    call filter(stridx, "v:val != -1")
		    let StrIdx = {}
		    for end in keys(stridx)
			call extend(StrIdx, { stridx[end] : end }, 'keep')
		    endfor
		    let idx = min(keys(StrIdx))
		    let end = get(StrIdx, idx, "")
		    let fname .= strpart(getline(startline+1), 0, idx + len(end) + 1)
		endif
		if g:atp_debugST
		    let g:fname = fnamemodify(fname, ":t")
		    let g:dir	= fnamemodify(g:fname, ":p:h")
		    let g:pat	= pat
" 		    if g:fname =~# '^' .  escape(fnamemodify(tempname(), ":h"), '\/')
" 			let g:fname = substitute(g:fname, fnamemodify(tempname(), ":h"), b:atp_ProjectDir)
" 		    endif
		endif
		let test 	= filereadable(fname)
		let nr	+= 1
		let [ startline_o, startcol_o ] = deepcopy([ startline, startcol ])
	    endwhile
	    keepjumps call setpos(".", saved_pos)
		if g:atp_debugST
		    let g:fname = fname
		endif

	    " if the file is under texmf directory return unless g:atp_developer = 1
	    " i.e. do not visit packages and classes.
	    if ( fnamemodify(fname, ':p') =~ '\%(\/\|\\\)texmf' || index(['cls', 'sty', 'bst'], fnamemodify(fname, ":e")) != -1 ) && !g:atp_developer
		keepjumps call setpos(".", saved_pos)
		return
	    elseif fnamemodify(fname, ':p') =~ '\%(\/\|\\\)texmf'
		" comma separated list of options
	    	let options = 'nospell'
	    else
		let options = ''
	    endif

	    let bufnr = bufnr(fname)
" 		let g:bufnr = bufnr
	    let bufwinnr	= bufwinnr(bufnr)
	    let log_winnr	= bufwinnr("")

	    " Goto found file and correct line.
	    " with bang open file in a new window,
	    " without open file in previous window.
	    if a:bang == "!"
		if bufwinnr != -1
		    exe bufwinnr . " wincmd w"
		    exe ':'.lineNr
		    exe 'normal zz'
		elseif buflisted(bufnr)
		    exe 'split #' . bufnr
		    exe ':'.lineNr
		    exe 'normal zz'
		else
		    " allows to go to errrors in packages.
		    exe 'split ' . fname
		    exe ':'.lineNr
		    exe 'normal zz'
		endif
	    else
		if bufwinnr != -1
		    exe bufwinnr . " wincmd w"
		    exe ':'.lineNr
		    exe 'normal zz'
		else
		    exe s:winnr . " wincmd w"
		    if buflisted(bufnr)
			exe "b " . bufnr
			exe ':'.lineNr
			exe 'normal zz'
		    else
			exe "edit " . fname
			exe ':'.lineNr
			exe 'normal zz'
		    endif
		    exe 'normal zz'
		endif
	    endif

	    " set options
		if &filetype == ""
		    filetype detect
		endif
		for option in split(options, ',')
		    exe "setl " . option
		endfor

	    " highlight the error
	    if exists("error") && error != ""
" 		let error_pat = escape(error, '\.')
" 		call matchadd("ErrorMsg", '\%'.lineNr.'l' . error_pat) 
		let matchID =  matchadd("Error", error, 15) 
	    endif

	    if sync
		setl cursorline
		" Unset 'cursorline' option when entering the window. 
		exe 'au! WinEnter ' . expand("%:p")  . " setl nocursorline"
" 		if exists("matchID")
" 		    exe 'au! WinEnter ' . expand("%:p")  . " call matchdelete(".matchID.")"
" 		endif
		exe log_winnr . ' wincmd w'
	    else
		setl nocursorline
	    endif

	    exe "lcd " . fnameescape(cwd)
	endfunction
	command! -buffer -bang SyncTex		:call <SID>SyncTex(<q-bang>)
	map <buffer> <Enter>			:SyncTex<CR>
" 	nnoremap <buffer> <LocalLeader>g	:SyncTex<CR>	
	augroup ATP_SyncLog
	    au CursorMoved *.log :call <SID>SyncTex("", 1)
	augroup END

	function! s:SyncXpdfLog(...)

	    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)
	    " check the value of g:atp_SyncXpdfLog
	    let check = ( a:0 >= 1 ? a:1 : 1 )

	    if b:atp_Viewer !~ '^\s*xpdf\>' || b:atp_XpdfServer == "" || check && !g:atp_SyncXpdfLog
		return
	    endif

" 	    let saved_pos	= getpos(".")	

	    let [ lineNr, colNr ] 	= searchpos('\[\_d\+\%({[^}]*}\)\=\n\=\]', 'n')
	    let line 	= strpart(getline(lineNr), colNr-1) . getline(lineNr+1)

	    let pageNr	= substitute(matchstr(line, '\[\zs\_d\+\ze\%({[^}]*}\)\=\]'), "\n", "", "g")
	    let g:pageNr	= pageNr

	    if pageNr	!= ""
		let cmd = "xpdf -remote " . b:atp_XpdfServer . " " . fnamemodify(atp_MainFile, ":r") . ".pdf " . pageNr . " &"
		let g:cmd = cmd
		call system(cmd)
	    endif
	endfunction
	command! -buffer SyncXpdf 	:call s:SyncXpdfLog(0)
	command! -buffer Xpdf 		:call s:SyncXpdfLog(0)
	map <buffer> <silent> <F3> 	:SyncXpdf<CR>
	augroup ATP_SyncXpdfLog
	    au CursorMoved *.log :call s:SyncXpdfLog(1)
	augroup END

    else
	echo "No log file"
    endif
endfunction

" TeX LOG FILE
if &buftype == 'quickfix'
	setlocal modifiable
	setlocal autoread
endif	
function! s:TexLog(options)
    if executable("texloganalyser")
       let s:command="texloganalyser " . a:options . " " . &l:errorfile
       echo system(s:command)
    else	
       echo "Please install 'texloganalyser' to have this functionality. The perl program written by Thomas van Oudenhove."  
    endif
endfunction

function! s:PdfFonts()
    if b:atp_OutDir !~ "\/$"
	b:atp_OutDir=b:atp_OutDir . "/"
    endif
    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)
    if executable("pdffonts")
	let s:command="pdffonts " . fnameescape(fnamemodify(atp_MainFile,":r")) . ".pdf"
	echo system(s:command)
    else
	echo "Please install 'pdffonts' to have this functionality. In 'gentoo' it is in the package 'app-text/poppler-utils'."  
    endif
endfunction	

" function! s:setprintexpr()
"     if b:atp_TexCompiler == "pdftex" || b:atp_TexCompiler == "pdflatex"
" 	let s:ext = ".pdf"
"     else
" 	let s:ext = ".dvi"	
"     endif
"     let &printexpr="system('lpr' . (&printdevice == '' ? '' : ' -P' . &printdevice) . ' " . fnameescape(fnamemodify(expand("%"),":p:r")) . s:ext . "') . + v:shell_error"
" endfunction
" call s:setprintexpr()

function! YesNoCompletion(A,P,L)
    return ['yes','no']
endfunction
"}}}

" Ssh printing tools
"{{{ Print, Lpstat, ListPrinters
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

" This function is used for completetion of the command SshPrint
function! s:ListPrinters(A,L,P)
    if exists("g:atp_ssh") && g:atp_ssh !~ '@localhost' && g:atp_ssh != ""
	let l:com="ssh -q " . g:atp_ssh . " lpstat -a | awk '{print $1}'"
    else
	let l:com="lpstat -a | awk '{print $1}'"
    endif
    return system(l:com)
endfunction
" }}}

" Open Library Command
" {{{ :Open
command! -nargs=? -bang -complete=file  Open call atplib#Open(<q-bang>, g:atp_LibraryPath, g:atp_OpenTypeDict, <q-args>)
let g:atp_open_completion = []
" -complete=customlist,ATP_CompleteOpen
" function! ATP_CompleteOpen(ArgLead, CmdLead, CurPos)
"     return filter(deepcopy(g:atp_open_completion), "v:val =~ '^' . a:ArgLead")
" endfunction
" }}}

" ToDo notes
" {{{ ToDo
"
" TODO if the file was not found ask to make one.
function! ToDo(keyword,stop,...)

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
    let sortedkeys=sort(keys(todo), "atplib#CompareNumbers")
    for key in sortedkeys
	" echo the todo line.
	echomsg key . " " . substitute(substitute(todo[key],'%','',''),'\t',' ','g')
	let true	= 1
	let a		= 1
	let linenr	= key
	" show all comment lines right below the found todo line.
	while true && texfile[linenr] !~ '%.*\c\<todo\>' 
	    let linenr=key+a-1
	    if texfile[linenr] =~ '\s*%' && texfile[linenr] !~ a:stop
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
" }}}

" This functions reloads ATP (whole or just a function)
" {{{  RELOAD

if !exists("g:debug_atp_plugin")
    let g:debug_atp_plugin=0
endif
if g:debug_atp_plugin==1 && !exists("*Reload")
" Reload() - reload all the tex_apt functions
" Reload(func1,func2,...) reload list of functions func1 and func2
" function! Reload(...)
"     let l:pos_saved=getpos(".")
"     let l:bufname=fnamemodify(expand("%"),":p")
" 
"     if a:0 == 0
" 	let l:runtime_path=split(&runtimepath,',')
" 	echo "Searching for atp plugin files"
" 	let l:file_list=['ftplugin/tex_atp.vim', 'ftplugin/fd_atp.vim', 
" 		    \ 'ftplugin/bibsearch_atp.vim', 'ftplugin/toc_atp.vim', 
" 		    \ 'autoload/atplib.vim', 'ftplugin/atp_LatexBox.vim',
" 		    \ 'indent/tex_atp.vim' ]
" 	let l:file_path=[]
" 	for l:file in l:file_list
" 		call add(l:file_path,globpath(&rtp,l:file))
" 	endfor
" " 	if exists("b:atp_debug")
" " 	    if b:atp_debug == "v" || b:atp_debug == "verbose"
" " 		echomsg string(l:file_path)
" " 	    endif
" " 	endif
" 	for l:file in l:file_path
" 	    echomsg "deleting FUNCTIONS and VARIABLES from " . l:file
" 	    let l:atp=readfile(l:file)
" 	    for l:line in l:atp
" 		let l:function_name=matchstr(l:line,'^\s*fun\%(ction\)\?!\?\s\+\zs\<[^(]*\>\ze(')
" 		if l:function_name != "" && l:function_name != "Reload"
" 		    if exists("*" . l:function_name)
" 			if exists("b:atp_debug")
" 			    if b:atp_debug == "v" || b:atp_debug == "verbose"
" 				echomsg "deleting function " . l:function_name
" 			    endif
" 			endif
" 			execute "delfunction " . l:function_name
" 		    endif
" 		endif
" 		let l:variable_name=matchstr(l:line,'^\s*let\s\+\zsg:[a-zA-Z_^{}]*\ze\>')
" 		if exists(l:variable_name)
" 		    execute "unlet ".l:variable_name
" 		    if exists("b:atp_debug")
" 			if b:atp_debug == "v" || b:atp_debug == "verbose"
" 			    echomsg "unlet ".l:variable_name
" 			endif
" 		    endif
" 		endif
" 	    endfor
" 	endfor
"     else
" 	if a:1 != "maps" && a:1 != "reload"
" 	    let l:f_list=split(a:1,',')
" 	    let g:f_list=l:f_list
" 	    for l:function in l:f_list
" 		execute "delfunction " . l:function
" 		if exists("b:atp_debug")
" 		    if b:atp_debug == "v" || b:atp_debug == "verbose"
" 			echomsg "delfunction " . l:function
" 		    endif
" 		endif
" 	    endfor
" 	endif
"     endif
"     augroup! ATP_auTeX
"     " Do not write project script file while saving the file.
"     let atp_ProjectScript	= ( exists("g:atp_ProjectScript") ? g:atp_ProjectScript : -1 )
"     let g:atp_ProjectScript	= 0
"     w
"     if atp_ProjectScript == -1
" 	unlet g:atp_ProjectScript
"     else
" 	let g:atp_ProjectScript	= atp_ProjectScript
"     endif
" "   THIS IS THE SLOW WAY:
"     bd!
"     execute "edit " . fnameescape(l:bufname)
"     keepjumps call setpos(".",l:pos_saved)
" "   This could be faster: but aparently doesn't work.
" "     execute "source " . l:file_path[0]
" endfunction

" Source options.vim
try
function! <SID>ReloadATP(bang)
    " First source the option file
    let common_file	= globpath(&rtp, 'ftplugin/ATP_files/common.vim')
    let options_file	= globpath(&rtp, 'ftplugin/ATP_files/options.vim')
    let g:atp_reload_functions = ( a:bang == "!" ? 1 : 0 ) 
    let g:atp_reload	= 1
    if a:bang == ""
	execute "source " . common_file
	execute "source " . options_file 
	let g:atp_reload	= 0
	" Then source atprc file
	if filereadable(globpath($HOME, '/.atprc.vim', 1)) && has("unix")

		" Note: in $HOME/.atprc file the user can set all the local buffer
		" variables without using autocommands
		let path = globpath($HOME, '/.atprc.vim', 1)
		execute 'source ' . fnameescape(path)

	else
		let path	= get(split(globpath(&rtp, "**/ftplugin/ATP_files/atprc.vim"), '\n'), 0, "")
		if path != ""
			execute 'source ' . fnameescape(path)
		endif
	endif
    else
	let tex_atp_file = globpath(&rtp, 'ftplugin/tex_atp.vim')
	execute "source " . tex_atp_file
	" This reloads all functions except autoload/atplib.vim
	let g:atp_reload		= 0
	let g:atp_reload_functions 	= 0
    endif
endfunction
catch /E127:/
    " Cannot redefine function, function is in use.
endtry
endif
" }}}

" This functions prints preambule 
" {{{ Preambule
function! Preambule()
    let loclist = getloclist(0)
    let winview = winsaveview()
    exe '1lvimgrep /^[^%]*\\begin\s*{\s*document\s*}/j ' . fnameescape(b:atp_MainFile)
    let linenr = get(get(getloclist(0), 0, {}), 'lnum', 'nomatch')
    if linenr != 'nomatch'
	if expand("%:p") != atplib#FullPath(b:atp_MainFile)
	    let cfile = expand("%:p")

	    exe "keepalt edit " . b:atp_MainFile 
	endif
	exe "1," . (linenr-1) . "print"
	if exists("cfile")
	    exe "keepalt edit " . cfile
	endif
	call winrestview(winview)
    else	
	echomsg " Not found \begin{document}."
    endif
endfunction
" }}}


" Get bibdata from ams
" {{{ AMSGet
try
function! <SID>GetAMSRef(what, bibfile)
    let what = substitute(a:what, '\s\+', ' ',	'g') 
    let what = substitute(what, '%',	'%25',	'g')
    let what = substitute(what, ',',	'%2C',	'g') 
    let what = substitute(what, ':',	'%3A',	'g')
    let what = substitute(what, ';',	'%3B',	'g')
    let what = substitute(what, '/',	'%2F',	'g')
    let what = substitute(what, '?',	'%3F',	'g')
    let what = substitute(what, '+',	'%2B',	'g')
    let what = substitute(what, '=',	'%3D',	'g')
    let what = substitute(what, '#',	'%23',	'g')
    let what = substitute(what, '\$',	'%24',	'g')
    let what = substitute(what, '&',	'%26',	'g')
    let what = substitute(what, '@',	'%40',	'g')
    let what = substitute(what, ' ',	'+',	'g')
"     let g:what = what
    if a:bibfile != "nobibfile"
	let cmd = g:atpbib_wget . " " . '"http://www.ams.org/mathscinet-mref?ref='.what.'&dataType=bibtex"'
    else
	let cmd = g:atpbib_wget . " " . '"http://www.ams.org/mathscinet-mref?ref='.what.'&dataType=tex"'
    endif
"     let g:cmd=cmd
    call system(cmd)
    let loclist = getloclist(0)

    try
	exe '1lvimgrep /\CNo Unique Match Found/j ' . fnameescape(g:atpbib_WgetOutputFile)
    catch /E480/
    endtry
    if len(getloclist(0))
	echohl WarningMsg
	echomsg "No Unique Match Found"
	echohl None
	return
    endif

    if len(b:AllBibFiles) > 0
	let pattern = '@\%(article\|book\%(let\)\=\|conference\|inbook\|incollection\|\%(in\)\=proceedings\|manual\|masterthesis\|misc\|phdthesis\|techreport\|unpublished\)\s*{\|^\s*\%(ADDRESS\|ANNOTE\|AUTHOR\|BOOKTITLE\|CHAPTER\|CROSSREF\|EDITION\|EDITOR\|HOWPUBLISHED\|INSTITUTION\|JOURNAL\|KEY\|MONTH\|NOTE\|NUMBER\|ORGANIZATION\|PAGES\|PUBLISHER\|SCHOOL\|SERIES\|TITLE\|TYPE\|VOLUME\|YEAR\|MRCLASS\|MRNUMBER\|MRREVIEWER\)\s*=\s*.*$'
	try 
	    exe 'lvimgrep /'.pattern.'/j ' . fnameescape(g:atpbib_WgetOutputFile)
	catch /E480:/
	endtry
	let data = getloclist(0)
	call setloclist(0, loclist)
"         let g:data = copy(data)

	if !len(data) 
	    echohl WarningMsg
	    echomsg "Nothing found."
	    echohl None
	    return
	endif

	let linenumbers = map(copy(data), 'v:val["lnum"]')
	let begin	= min(linenumbers)
"         let g:begin = begin
	let end	= max(linenumbers)
"         let g:end	= end

	let bufnr = bufnr(g:atpbib_WgetOutputFile)
" 	let g:bufnr = bufnr
	" To use getbufline() buffer must be loaded. It is enough to use :buffer
	" command because vimgrep loads buffer and then unloads it. 
	execute "buffer " . bufnr
	let bibdata	= getbufline(bufnr, begin, end)
"         let g:bibdata = bibdata
	execute "bdelete " . bufnr 
	let type = matchstr(bibdata[0], '@\%(article\|book\%(let\)\=\|conference\|inbook\|incollection\|\%(in\)\=proceedings\|manual\|masterthesis\|misc\|phdthesis\|techreport\|unpublished\)\ze\s*\%("\|{\|(\)')
"         let g:type = type
        " Suggest Key:
"         let author = substitute(matchstr(get(filter(copy(bibdata), "v:val =~ '\\<author\\>'"),0, ""), 'author\s*=\s*\("\|{\|''\|(\)\zs.*\ze'), '{\|}\|(\|)\|''\|"\|,', '', 'g')
"         let firstauthor = split(author, "and")[0]
"         let title = substitute(matchstr(get(filter(copy(bibdata), "v:val =~ '\\<title\\>'"),0, ""), 'title\s*=\s*\("\|{\|''\|(\)\zs.*\ze'), '{\|}\|(\|)\|''\|"\|,', '', 'g')
"         let suggested_key = substitute(firstauthor . ":" . title, " ", "_", "g")
"         let g:suggested_key = suggested_key
	let bibkey = input("Provide a key (Enter for the AMS bibkey): ")
	if !empty(bibkey)
	    let bibdata[0] 	= type . '{' . bibkey
	else
	    let bibdata[0] 	= substitute(matchstr(bibdata[0], '@\w*.*$'), '\(@\w*\)\(\s*\)', '\1', '')
	    " This will be only used to echomsg:
	    let bibkey	= matchstr(bibdata[0], '@\w*.\s*\zs[^,]*')
	endif
	call add(bibdata, "}")

	" Open bibfile and append the bibdata:
	execute "silent! edit " . a:bibfile
"         let g:eline = getline(line('$')) !~ '^\s*$'
	if getline(line('$')) !~ '^\s*$' 
	    let bibdata = extend([''], bibdata)
	endif
"         echomsg string(bibdata)
	call append(line('$'), bibdata)
	normal GG
	echohl WarningMsg
	echomsg "Bibkey " . bibkey . " appended to: " . a:bibfile 
	echohl Normal
    else
	" If the user is using \begin{bibliography} environment.
	let pattern = '^<tr><td align="left">'
	try 
	    exe 'lvimgrep /'.pattern.'/j ' . fnameescape(g:atpbib_WgetOutputFile)
	catch /E480:/
	endtry
	let data = getloclist(0)
"         let g:data = copy(data)
	if !len(data) 
	    echohl WarningMsg
	    echomsg "Nothing found."
	    echohl None
	    return
	elseif len(data) > 1
	    echoerr "ATP Error: AMSRef vimgrep pattern error. You can send a bug report. Please include the exact :ATPRef command." 
	endif
	let bibref = '\bibitem{} ' . matchstr(data[0]['text'], '^<tr><td align="left">\zs.*\ze<\/td><\/tr>')
	let g:atp_bibref = bibref
	exe "let @" . g:atp_bibrefRegister . " = '" . bibref . "'"
	let bibdata = [ bibref ]
    endif
    let g:atp_bibdata = bibdata
    return bibdata
endfunction
catch /E127/
endtry

function! AMSRef(bang, what)
    if !exists("b:AllBibFiles")
	call FindInputFiles(b:atp_MainFile)
    endif
    if len(b:AllBibFiles) > 1
	let bibfile = inputlist(extend("Which bib file to use?", b:AllBibFiles))
    elseif len(b:AllBibFiles) == 1
	let bibfile = b:AllBibFiles[0]
    elseif !len(b:AllBibFiles)
	let bibfile = "nobibfile"
" 	let bibfile = get(b:AllBibFiles, 0, "")
" 	if empty(bibfile)
" 	    let bibfile = input("Provide full path to bib file and press <Enter>:")
" 	    if empty(bibfile)
" 		return
" 	    endif
" 	endif
    endif

    call <SID>GetAMSRef(a:what, bibfile)
    if a:bang == "!"
	silent! w
	silent! bd
    endif
endfunction
"}}}
endif "}}}

" COMMANDS AND MAPS:
" Maps: "{{{1
vmap <buffer> 	<Plug>WrapSelection				:<C-U>call <SID>WrapSelection('')<CR>i
vmap <buffer> 	<Plug>InteligentWrapSelection			:<C-U>call <SID>InteligentWrapSelection('')<CR>i
nnoremap <silent> <buffer> 	<Plug>ToggleStar		:call <SID>ToggleStar()<CR>
nnoremap <silent> <buffer> 	<Plug>ToggleEnvForward		:call <SID>ToggleEnvironment(0, 1)<CR>
nnoremap <silent> <buffer> 	<Plug>ToggleEnvBackward		:call <SID>ToggleEnvironment(0, -1)<CR>
nnoremap <silent> <buffer> 	<Plug>ChangeEnv			:call <SID>ToggleEnvironment(1)<CR>
nnoremap <silent> <buffer> 	<Plug>TexDoc			:TexDoc 
" Commands: "{{{1
command! -buffer -nargs=? -range WrapSelection			:call <SID>WrapSelection(<args>)
command! -buffer -nargs=? -range InteligentWrapSelection	:call <SID>InteligentWrapSelection(<args>)
command! -buffer	TexAlign				:call TexAlign()
command! -buffer 	ToggleStar   				:call <SID>ToggleStar()<CR>
command! -buffer -nargs=? ToggleEnv	   			:call <SID>ToggleEnvironment(0, <f-args>)
command! -buffer -nargs=* -complete=customlist,<SID>EnvCompletion ChangeEnv				:call <SID>ToggleEnvironment(1, <f-args>)
command! -buffer -nargs=* -complete=customlist,<SID>TeXdoc_complete TexDoc 	:call <SID>TexDoc(<f-args>)
command! -buffer -bang 	Delete					:call <SID>Delete(<q-bang>)
nmap <silent> <buffer>	 <Plug>Delete				:call <SID>Delete("")<CR>
command! -buffer 	OpenLog					:call <SID>OpenLog()
nnoremap <silent> <buffer> <Plug>OpenLog			:call <SID>OpenLog()<CR>
command! -buffer 	TexLog					:call <SID>TexLog()
nnoremap <silent> <buffer> <Plug>TexLog				:call <SID>TexLog()<CR>
command! -buffer 	PdfFonts				:call <SID>PdfFonts()
nnoremap <silent> <buffer> <Plug>PdfFonts			:call <SID>PdfFonts()<CR>
command! -complete=custom,<SID>ListPrinters  -buffer -nargs=* SshPrint 	:call <SID>SshPrint("", <f-args>)
nnoremap <buffer> 	<Plug>SshPrint				:SshPrint 
command! -buffer 	Lpstat					:call <SID>Lpstat()
nnoremap <silent> <buffer> <Plug>Lpstat				:call <SID>Lpstat()<CR>
command! -buffer 	ListPrinters				:echo <SID>ListPrinters("", "", "")
" List Packages:
command! -buffer 	ShowPackages				:let b:atp_PackageList = atplib#GrepPackageList() | echo join(b:atp_PackageList, "\n")
command! -buffer -nargs=? -complete=buffer ToDo			:call ToDo('\c\<to\s*do\>','\s*%\c.*\<note\>',<f-args>)
command! -buffer -nargs=? -complete=buffer Note			:call ToDo('\c\<note\>','\s*%\c.*\<to\s*do\>',<f-args>)
command! -buffer -bang ReloadATP				:call <SID>ReloadATP(<q-bang>)
command! -bang -buffer -nargs=1 AMSRef				:call AMSRef(<q-bang>, <q-args>)
command! -buffer	Preambule				:call Preambule()
" vim:fdm=marker:tw=85:ff=unix:noet:ts=8:sw=4:fdc=1
