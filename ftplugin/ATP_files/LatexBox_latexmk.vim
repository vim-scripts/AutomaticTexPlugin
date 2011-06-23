" Author: 		David Munger (mungerd@gmail.com)
" Maintainer:	Marcin Szamotulski
" Note:			This file is a part of Automatic Tex Plugin for Vim.
" Language:		tex
" Last Change:

let s:sourced	 		= exists("s:sourced") ? 1 : 0

if !s:sourced || g:atp_reload_functions
" <SID> Wrap {{{
function! s:GetSID()
	return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\ze.*$')
endfunction
let s:SID = s:GetSID()
function! s:SIDWrap(func)
	return s:SID . a:func
endfunction
" }}}


" dictionary of latexmk PID's (basename: pid)
let s:latexmk_running_pids = {}

" Set PID {{{
function! s:LatexmkSetPID(basename, pid)
	let s:latexmk_running_pids[a:basename] = a:pid
endfunction
" }}}

" Callback {{{
function! s:LatexmkCallback(basename, status)
	"let pos = getpos('.')
	if a:status
		echomsg "[LatexBox:] latexmk exited with status " . a:status
	else
		echomsg "[LatexBox:] latexmk finished"
	endif
	call remove(s:latexmk_running_pids, a:basename)
	call LatexBox_LatexErrors(g:LatexBox_autojump && a:status, a:basename)
	"call setpos('.', pos)
endfunction
" }}}

" Latexmk {{{
function! LatexBox_Latexmk(force)

	if empty(v:servername)
		echoerr "cannot run latexmk in background without a VIM server"
		return
	endif

	let basename = LatexBox_GetTexBasename(1)

	if has_key(s:latexmk_running_pids, basename)
		echomsg "[LatexBox:] latexmk is already running for `" . fnamemodify(basename, ':t') . "'"
		return
	endif

	let callsetpid = s:SIDWrap('LatexmkSetPID')
	let callback = s:SIDWrap('LatexmkCallback')

	let l:options = '-' . g:LatexBox_output_type . ' -quiet ' . g:LatexBox_latexmk_options
	if a:force
		let l:options .= ' -g'
	endif
	let l:options .= " -e '$pdflatex =~ s/ / -file-line-error /'"
	let l:options .= " -e '$latex =~ s/ / -file-line-error /'"

	" callback to set the pid
	let vimsetpid = g:vim_program . ' --servername ' . v:servername . ' --remote-expr ' .
				\ shellescape(callsetpid) . '\(\"' . fnameescape(basename) . '\",$$\)'

	" latexmk command
	" wrap width in log file
	let max_print_line = 2000
	let pwd = getcwd()
	exe "lcd ". fnameescape(b:atp_ProjectDir)
	let cmd =  'max_print_line=' . max_print_line .
				\ ' latexmk ' . l:options	. ' ' . shellescape(b:atp_MainFile)

	" callback after latexmk is finished
	let vimcmd = g:vim_program . ' --servername ' . v:servername . ' --remote-expr ' . 
				\ shellescape(callback) . '\(\"' . fnameescape(basename) . '\",$?\)'

	silent execute '! ( ' . vimsetpid . ' ; ( ' . cmd . ' ) ; ' . vimcmd . ' ) &'
	exe "lcd " . fnameescape(pwd)
endfunction
" }}}

" LatexmkStop {{{
function! LatexBox_LatexmkStop()

	let basename = LatexBox_GetTexBasename(1)

	if !has_key(s:latexmk_running_pids, basename)
		echomsg "[LatexBox:] latexmk is not running for `" . fnamemodify(basename, ':t') . "'"
		return
	endif

	call s:kill_latexmk(s:latexmk_running_pids[basename])

	call remove(s:latexmk_running_pids, basename)
	echomsg "[LatexBox:] latexmk stopped for `" . fnamemodify(basename, ':t') . "'"
endfunction
" }}}

" kill_latexmk {{{
function! s:kill_latexmk(gpid)

	" This version doesn't work on systems on which pkill is not installed:
	"!silent execute '! pkill -g ' . pid

	" This version is more portable, but still doesn't work on Mac OS X:
	"!silent execute '! kill `ps -o pid= -g ' . pid . '`'

	" Since 'ps' behaves differently on different platforms, we must use brute force:
	" - list all processes in a temporary file
	" - match by process group ID
	" - kill matches
	let pids = []
	let tmpfile = tempname()
	silent execute '!ps x -o pgid,pid > ' . tmpfile
	for line in readfile(tmpfile)
		let pid = matchstr(line, '^\s*' . a:gpid . '\s\+\zs\d\+\ze')
		if !empty(pid)
			call add(pids, pid)
		endif
	endfor
	call delete(tmpfile)
	if !empty(pids)
		call atplib#KillPIDs(pids)
	endif
endfunction
" }}}

" kill_all_latexmk {{{
function! s:kill_all_latexmk()
	for gpid in values(s:latexmk_running_pids)
		call s:kill_latexmk(gpid)
	endfor
	let s:latexmk_running_pids = {}
endfunction
" }}}

" LatexmkClean {{{
function! LatexBox_LatexmkClean(cleanall) 
	if a:cleanall
		let l:options = '-C'
	else
		let l:options = '-c'
	endif

	let l:cmd = 'cd ' . shellescape(LatexBox_GetTexRoot()) . ' ; latexmk ' . l:options
				\	. ' ' . shellescape(LatexBox_GetMainTexFile())

	silent execute '! ' . l:cmd
	echomsg "[LatexBox:] latexmk clean finished"
endfunction
" }}}

" LatexmkStatus {{{
function! LatexBox_LatexmkStatus(detailed)

	if a:detailed
		if empty(s:latexmk_running_pids)
			echo "latexmk is not running"
		else
			let plist = ""
			for [basename, pid] in items(s:latexmk_running_pids)
				if !empty(plist)
					let plist .= '; '
				endif
				let plist .= fnamemodify(basename, ':t') . ':' . pid
			endfor
			echo "latexmk is running (" . plist . ")"
		endif
	else
		let basename = LatexBox_GetTexBasename(1)
		if has_key(s:latexmk_running_pids, basename)
			echo "latexmk is running"
		else
			echo "latexmk is not running"
		endif
	endif

endfunction
" }}}
endif

" Commands {{{
command! -buffer -bang Latexmk			call LatexBox_Latexmk((<q-bang> == "!" ? 1 : 0))
command! -buffer -bang LatexmkClean			call LatexBox_LatexmkClean((<q-bang> == "!" ? 1 : 0))
command! -buffer -bang LatexmkStatus			call LatexBox_LatexmkStatus((<q-bang> == "!" ? 1 : 0))
command! -buffer LatexmkStop			call LatexBox_LatexmkStop()
" }}}

autocmd VimLeavePre * call <SID>kill_all_latexmk()

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4
