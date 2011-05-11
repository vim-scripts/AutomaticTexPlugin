" Author: 	Marcin Szamotulski	
" Description: 	This file contains all the options defined on startup of ATP
" Note:		This file is a part of Automatic Tex Plugin for Vim.
" URL:		https://launchpad.net/automatictexplugin
" Language:	tex
" Last Change:

" NOTE: you can add your local settings to ~/.atprc.vim or
" ftplugin/ATP_files/atprc.vim file

" Some options (functions) should be set once:
let s:did_options 	= exists("s:did_options") ? 1 : 0

"{{{ tab-local variables
" We need to know bufnumber and bufname in a tabpage.
" ToDo: we can set them with s: and call them using <SID> stack
" (how to make the <SID> stack invisible to the user!

    let t:atp_bufname	= bufname("")
    let t:atp_bufnr	= bufnr("")
    let t:atp_winnr	= winnr()


" autocommands for buf/win numbers
" These autocommands are used to remember the last opened buffer number and its
" window number:
if !s:did_options
    augroup ATP_TabLocalVariables
	au!
	au BufLeave *.tex 	let t:atp_bufname	= resolve(fnamemodify(bufname(""),":p"))
	au BufLeave *.tex 	let t:atp_bufnr		= bufnr("")
	" t:atp_winnr the last window used by tex, ToC or Labels buffers:
	au WinEnter *.tex 	let t:atp_winnr		= winnr("#")
	au WinEnter __ToC__ 	let t:atp_winnr		= winnr("#")
	au WinEnter __Labels__ 	let t:atp_winnr		= winnr("#")
	au TabEnter *.tex	let t:atp_SectionStack 	= ( exists("t:atp_SectionStack") ? t:atp_SectionStack : [] ) 
    augroup END
endif
"}}}

" ATP Debug Variables: (to debug atp behaviour)
" {{{ debug variables
if !exists("g:atp_debugInsertItem")
    " debug UpdateATP (various.vim)
    let g:atp_debugInsertItem = 0
endif
if !exists("g:atp_debugUpdateATP")
    " debug UpdateATP (various.vim)
    let g:atp_debugUpdateATP 	= 0
endif
if !exists("g:atp_debugPythonCompiler")
    " debug MakeLatex (compiler.vim)
    let g:atp_debugPythonCompiler = 0
endif
if !exists("g:atp_debugML")
    " debug MakeLatex (compiler.vim)
    let g:atp_debugML		= 0
endif
if !exists("g:atp_debugGAF")
    " debug aptlib#GrepAuxFile
    let g:atp_debugGAF		= 0
endif
if !exists("g:atp_debugSCP")
    " debug s:SelectCurrentParapgrahp (LatexBox_motion.vim)
    let g:atp_debugSCP		= 0
endif
if !exists("g:atp_debugSIT")
    " debug <SID>SearchInTree (search.vim)
    let g:atp_debugSIT		= 0
endif
if !exists("g:atp_debugRS")
    " debug <SID>RecursiveSearch (search.vim)
    let g:atp_debugRS		= 0
endif
if !exists("g:atp_debugSync")
    " debug forward search (vim->viewer) (search.vim)
    let g:atp_debugSync		= 0
endif
if !exists("g:atp_debugV")
    " debug ViewOutput() (compiler.vim)
    let g:atp_debugV		= 0
endif
if !exists("g:atp_debugLPS")
    " Debug s:LoadProjectFile() (history.vim)
    " (currently it gives just the loading time info)
    let g:atp_debugLPS		= 0
endif
if !exists("g:atp_debugCompiler")
    " Debug s:Compiler() function (compiler.vim)
    " when equal 2 output is more verbose.
    let g:atp_debugCompiler 	= 0
endif
if !exists("g:atp_debugCallBack")
    " Debug <SID>CallBack() function (compiler.vim)
    let g:atp_debugCallBack	= 0
endif
if !exists("g:atp_debugST")
    " Debug SyncTex() (various.vim) function
    let g:atp_debugST 		= 0
endif
if !exists("g:atp_debugCLE")
    " Debug atplib#CloseLastEnvironment()
    let g:atp_debugCLE 		= 0
endif
if !exists("g:atp_debugMainScript")
    " loading times of scripts sources by main script file: ftpluing/tex_atp.vim
    " NOTE: it is listed here for completeness, it can only be set in
    " ftplugin/tex_atp.vim script file.
    let g:atp_debugMainScript 	= 0
endif

if !exists("g:atp_debugProject")
    " <SID>LoadScript(), <SID>LoadProjectScript(), <SID>WriteProject()
    " The value that is set in history file matters!
    let g:atp_debugProject 	= 0
endif
if !exists("g:atp_debugCB")
    " atplib#CheckBracket()
    let g:atp_debugCB 		= 0
endif
if !exists("g:atp_debugCLB")
    " atplib#CloseLastBracket()
    let g:atp_debugCLB 		= 0
endif
if !exists("g:atp_debugTC")
    " atplib#TabCompletion()
    let g:atp_debugTC 		= 0
endif
if !exists("g:atp_debugBS")
    " atplib#searchbib()
    " atplib#showresults()
    " BibSearch() in ATP_files/search.vim
    " log file: /tmp/ATP_log 
    let g:atp_debugBS 		= 0
endif
if !exists("g:atp_debugToF")
    " TreeOfFiles() ATP_files/common.vim
    let g:atp_debugToF 		= 0
endif
if !exists("g:atp_debgTOF")
    " TreeOfFiles() redirect only the output to
    " /tmp/ATP_log
    let g:atp_debugTOF 		= 0
endif
if !exists("g:atp_debugBabel")
    " echo msg if  babel language is not supported.
    let g:atp_debugBabel 	= 0
endif
"}}}

" vim options + indentation
" {{{ Vim options

" {{{ Intendation
if !exists("g:atp_indentation")
    let g:atp_indentation=1
endif
" if !exists("g:atp_tex_indent_paragraphs")
"     let g:atp_tex_indent_paragraphs=1
" endif
if g:atp_indentation
"     setl indentexpr=GetTeXIndent()
"     setl nolisp
"     setl nosmartindent
"     setl autoindent
"     setl indentkeys+=},=\\item,=\\bibitem,=\\[,=\\],=<CR>
"     let prefix = expand('<sfile>:p:h:h')
"     exe 'so '.prefix.'/indent/tex_atp.vim'
    let prefix = expand('<sfile>:p:h')    
    exe 'so '.prefix.'/LatexBox_indent.vim'
endif
" }}}

setl nrformats=alpha
setl keywordprg=texdoc\ -m
if maparg("K", "n") != ""
    try
	nunmap <buffer> K
    catch E31:
	nunmap K
    endtry
endif

exe "setlocal complete+=".
	    \ "k".globpath(&rtp, "ftplugin/ATP_files/dictionaries/greek").
	    \ ",k".globpath(&rtp, "ftplugin/ATP_files/dictionaries/dictionary").
	    \ ",k".globpath(&rtp, "ftplugin/ATP_files/dictionaries/SIunits")
" The ams_dictionary is added after g:atp_amsmath variable is defined.

setlocal suffixes+=pdf
" As a base we use the standard value defined in 
" The suffixes option is also set after g:atp_tex_extensions is set.

" Borrowed from tex.vim written by Benji Fisher:
    " Set 'comments' to format dashed lists in comments
    setlocal com=sO:%\ -,mO:%\ \ ,eO:%%,:%

    " Set 'commentstring' to recognize the % comment character:
    " (Thanks to Ajit Thakkar.)
    setlocal cms=%%s

    " Allow "[d" to be used to find a macro definition:
    " Recognize plain TeX \def as well as LaTeX \newcommand and \renewcommand .
    " I may as well add the AMS-LaTeX DeclareMathOperator as well.
    let &l:define='\\\([egx]\|char\|mathchar\|count\|dimen\|muskip\|skip\|toks\)\='
	    \ .	'def\|\\font\|\\\(future\)\=let'
	    \ . '\|\\new\(count\|dimen\|skip\|muskip\|box\|toks\|read\|write'
	    \ .	'\|fam\|insert\)'
	    \ . '\|\\\(re\)\=new\(boolean\|command\|counter\|environment\|font'
	    \ . '\|if\|length\|savebox\|theorem\(style\)\=\)\s*\*\=\s*{\='
	    \ . '\|DeclareMathOperator\s*{\=\s*'
	    \ . '\|DeclareFixedFont\s*{\s*'
    let g:filetype = &l:filetype
    if &l:filetype != "plaintex"
	setlocal include=^[^%]*\\%(\\\\input\\(\\s*{\\)\\=\\\\|\\\\include\\s*{\\)
    else
	setlocal include=^[^%]*\\\\input
    endif
    setlocal suffixesadd=.tex

    setlocal includeexpr=substitute(v:fname,'\\%(.tex\\)\\?$','.tex','')
    " TODO set define and work on the above settings, these settings work with [i
    " command but not with [d, [D and [+CTRL D (jump to first macro definition)
    
" This was throwing all autocommand groups to the command line on startup.
" Anyway this is not very good.
"     augroup ATP_makeprg
" 	au VimEnter *.tex let &l:makeprg="vim --servername " . v:servername . " --remote-expr 'Make()'"
"     augroup

" }}}

" Buffer Local Variables:
" {{{ buffer variables
let b:atp_running	= 0

" these are all buffer related variables:
let s:optionsDict= { 	
		\ "atp_TexOptions" 		: "-synctex=1", 
	        \ "atp_ReloadOnError" 		: "1", 
		\ "atp_OpenViewer" 		: "1", 		
		\ "atp_autex" 			: !&l:diff && expand("%:e") == 'tex', 
		\ "atp_autex_wait"		: 0,
		\ "atp_ProjectScript"		: "1",
		\ "atp_Viewer" 			: has("win26") || has("win32") || has("win64") || has("win95") || has("win32unix") ? "AcroRd32.exe" : "okular" , 
		\ "atp_TexFlavor" 		: &l:filetype, 
		\ "atp_XpdfServer" 		: fnamemodify(b:atp_MainFile,":t:r"), 
		\ "atp_okularOptions"		: ["--unique"],
		\ "atp_OutDir" 			: substitute(fnameescape(fnamemodify(resolve(expand("%:p")),":h")) . "/", '\\\s', ' ' , 'g'),
		\ "atp_TempDir"			: substitute(b:atp_OutDir . "/.tmp", '\/\/', '\/', 'g'),
		\ "atp_TexCompiler" 		: &filetype == "plaintex" ? "pdftex" : "pdflatex",	
		\ "atp_BibCompiler"		: ( getline(atplib#SearchPackage('biblatex')) =~ '\<backend\s*=\s*biber\>' ? 'biber' : "bibtex" ),
		\ "atp_auruns"			: "1",
		\ "atp_TruncateStatusSection"	: "40", 
		\ "atp_LastBibPattern"		: "",
		\ "atp_TexCompilerVariable"	: "max_print_line=2000",
		\ "atp_StarEnvDefault"		: "",
		\ "atp_StarMathEnvDefault"	: "",
		\ "atp_LatexPIDs"		: [],
		\ "atp_BibtexPIDs"		: [],
		\ "atp_PythonPIDs"		: [],
		\ "atp_MakeindexPIDs"		: [],
		\ "atp_LastLatexPID"		: 0,
		\ "atp_LastPythonPID"		: 0,
		\ "atp_VerboseLatexInteractionMode" : "errorstopmode",
		\ "atp_BibtexReturnCode"	: 0,
		\ "atp_ProgressBar"		: {},
		\ "atp_BibtexOutput"		: ""}

" 		\ "atp_BibCompiler"		: ( getline(atplib#SearchPackage('biblatex')) =~ '\<backend\s*=\s*biber\>' ? 'biber' : "bibtex" ),
" 		\ "atp_TexCompilerVariable"	: "",
" 			\.";TEXINPUT="
" 			\.($TEXINPUTS == "" ? b:atp_OutDir : b:atp_OutDir.":".$TEXINPUTS)
" 			\.";BIBINPUTS="
" 			\.($BIBINPUTS == "" ? b:atp_OutDir : b:atp_OutDir.":".$BIBINPUTS),
let g:optionsDict=deepcopy(s:optionsDict)
" the above atp_OutDir is not used! the function s:SetOutDir() is used, it is just to
" remember what is the default used by s:SetOutDir().

" This function sets options (values of buffer related variables) which were
" not already set by the user.
" {{{ s:SetOptions
let s:ask = { "ask" : "0" }
function! s:SetOptions()

    let s:optionsKeys		= keys(s:optionsDict)
    let g:optionsKeys		= copy(s:optionsKeys)
    let s:optionsinuseDict	= getbufvar(bufname("%"),"")

    "for each key in s:optionsKeys set the corresponding variable to its default
    "value unless it was already set in .vimrc file.
    for key in s:optionsKeys
	if string(get(s:optionsinuseDict,key, "optionnotset")) == string("optionnotset") && key != "atp_OutDir" && key != "atp_autex" || key == "atp_TexCompiler"
	    call setbufvar(bufname("%"), key, s:optionsDict[key])
	elseif key == "atp_OutDir"

	    " set b:atp_OutDir and the value of errorfile option
	    if !exists("b:atp_OutDir")
		call s:SetOutDir(1)
	    endif
	    let s:ask["ask"] 	= 1
	endif
    endfor

        " Do not run tex on tex files which are in texmf tree
    " Exception: if it is opened using the command ':EditInputFile'
    " 		 which sets this itself.
    if string(get(s:optionsinuseDict,"atp_autex", 'optionnotset')) == string('optionnotset')
	let atp_texinputs=split(substitute(substitute(system("kpsewhich -show-path tex"),'\/\/\+','\/','g'),'!\|\n','','g'),':')
	call remove(atp_texinputs, index(atp_texinputs, '.'))
	call filter(atp_texinputs, 'b:atp_OutDir =~# v:val')
	let b:atp_autex = ( len(atp_texinputs) ? 0 : s:optionsDict['atp_autex'])  
    endif

    if !exists("b:TreeOfFiles") || !exists("b:ListOfFiles") || !exists("b:TypeDict") || !exists("b:LevelDict")
	if exists("b:atp_MainFile") 
	    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)
	    call TreeOfFiles(atp_MainFile)
	else
	    echomsg "[ATP:] b:atp_MainFile: ".b:atp_MainFile." doesn't exists."
	endif
    endif
endfunction
"}}}
call s:SetOptions()
lockvar b:atp_autex_wait

"}}}

" Global Variables: (almost all)
" {{{ global variables 
if !exists("g:atp_cgetfile") || g:atp_reload_variables
    let g:atp_cgetfile = 1
endif
if !exists("g:atp_atpdev") || g:atp_reload_variables
    let g:atp_atpdev = 0
endif
if !exists("g:atp_imap_ShortEnvIMaps") || g:atp_reload_variables
    let g:atp_imap_ShortEnvIMaps = 1
endif
if !exists("g:atp_imap_over_leader") || g:atp_reload_variables
    let g:atp_imap_over_leader="`"
endif
if !exists("g:atp_imap_subscript") || g:atp_reload_variables
    let g:atp_imap_subscript="__"
endif
if !exists("g:atp_imap_supscript") || g:atp_reload_variables
    let g:atp_imap_supscript="^"
endif
if !exists("g:atp_imap_define_math") || g:atp_reload_variables
    let g:atp_imap_define_math=1
endif
if !exists("g:atp_imap_define_environments") || g:atp_reload_variables
    let g:atp_imap_define_environments = 1
endif
if !exists("g:atp_imap_define_math_misc") || g:atp_reload_variables
    let g:atp_imap_define_math_misc = 1
endif
if !exists("g:atp_imap_define_greek_letters") || g:atp_reload_variables
    let g:atp_imap_define_greek_letters = 1
endif
if !exists("g:atp_imap_wide") || g:atp_reload_variables
    let g:atp_imap_wide=0
endif
if !exists("g:atp_letter_opening") || g:atp_reload_variables
    let g:atp_letter_opening=""
endif
if !exists("g:atp_letter_closing") || g:atp_reload_variables
    let g:atp_letter_closing=""
endif
if !exists("g:atp_imap_bibiliography") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_letter=""
    else
	let g:atp_imap_letter="let"
    endif
endif
if !exists("g:atp_imap_bibiliography") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_bibliography="B"
    else
	let g:atp_imap_bibliography="bib"
    endif
endif
if !exists("g:atp_imap_begin") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_begin="b"
    else
	let g:atp_imap_begin="beg"
    endif
endif
if !exists("g:atp_imap_end") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_end="e"
    else
	let g:atp_imap_end="end"
    endif
endif
if !exists("g:atp_imap_theorem") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_theorem="t"
    else
	let g:atp_imap_theorem="the"
    endif
endif
if !exists("g:atp_imap_definition") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_definition="d"
    else
	let g:atp_imap_definition="def"
    endif
endif
if !exists("g:atp_imap_proposition") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_proposition="P"
    else
	let g:atp_imap_proposition="Pro"
    endif
endif
if !exists("g:atp_imap_lemma") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_lemma="l"
    else
	let g:atp_imap_lemma="lem"
    endif
endif
if !exists("g:atp_imap_remark") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_remark="r"
    else
	let g:atp_imap_remark="rem"
    endif
endif
if !exists("g:atp_imap_corollary") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_corollary="c"
    else
	let g:atp_imap_corollary="cor"
    endif
endif
if !exists("g:atp_imap_proof") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_proof="p"
    else
	let g:atp_imap_proof="pro"
    endif
endif
if !exists("g:atp_imap_example") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_example="x"
    else
	let g:atp_imap_example="exa"
    endif
endif
if !exists("g:atp_imap_note") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_note="n"
    else
	let g:atp_imap_note="not"
    endif
endif
if !exists("g:atp_imap_enumerate") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_enumerate="E"
    else
	let g:atp_imap_enumerate="enu"
    endif
endif
if !exists("g:atp_imap_itemize") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_itemize="I"
    else
	let g:atp_imap_itemize="ite"
    endif
endif
if !exists("g:atp_imap_item") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_item="i"
    else
	let g:atp_imap_item="I"
    endif
endif
if !exists("g:atp_imap_align") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_align="a"
    else
	let g:atp_imap_align="ali"
    endif
endif
if !exists("g:atp_imap_abstract") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_abstract="A"
    else
	let g:atp_imap_abstract="abs"
    endif
endif
if !exists("g:atp_imap_equation") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_equation="q"
    else
	let g:atp_imap_equation="equ"
    endif
endif
if !exists("g:atp_imap_center") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_center="C"
    else
	let g:atp_imap_center="cen"
    endif
endif
if !exists("g:atp_imap_flushleft") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_flushleft="L"
    else
	let g:atp_imap_flushleft="lef"
    endif
endif
if !exists("g:atp_imap_flushright") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_flushright="R"
    else
	let g:atp_imap_flushright="rig"
    endif
endif
if !exists("g:atp_imap_tikzpicture") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_tikzpicture="T"
    else
	let g:atp_imap_tikzpicture="tik"
    endif
endif
if !exists("g:atp_imap_frame") || g:atp_reload_variables
    if g:atp_imap_ShortEnvIMaps
	let g:atp_imap_frame="f"
    else
	let g:atp_imap_frame="fra"
    endif
endif
if !exists("g:atp_goto_section_leader") || g:atp_reload_variables
    let g:atp_goto_section_leader="-"
endif
if !exists("g:atp_autex_wait")
    " the value is a comma speareted list of modes, for modes see mode() function.
"     let g:atp_autex_wait = "i,R,Rv,no,v,V,c,cv,ce,r,rm,!"
    let g:atp_autex_wait = ""
endif
if !exists("g:atp_MapSelectComment") || g:atp_reload_variables
    let g:atp_MapSelectComment = "_c"
endif
if exists("g:atp_latexpackages") || g:atp_reload_variables
    " Transition to nicer name:
    let g:atp_LatexPackages = g:atp_latexpackages
    unlet g:atp_latexpackages
endif
if exists("g:atp_latexclasses") || g:atp_reload_variables
    " Transition to nicer name:
    let g:atp_LatexClasses = g:atp_latexclasses
    unlet g:atp_latexclasses
endif
if !exists("g:atp_Python") || g:atp_reload_variables
    " This might be a name of python executable or full path to it (if it is not in
    " the $PATH) 
    if has("win32") || has("win64")
	" TO BE TESTED:
	" see why to use "pythonw.exe" on:
	" "http://docs.python.org/using/windows.html".
	let g:atp_Python = "pythonw.exe"
    else
	let g:atp_Python = "python"
    endif
endif
if !exists("g:atp_MapUpdateToCLine") || g:atp_reload_variables
    let g:atp_MapUpdateToCLine = 1
endif
if !exists("g:atp_DeleteWithBang") || g:atp_reload_variables
    let g:atp_DeleteWithBang = [ 'synctex.gz', 'tex.project.vim']
endif
if !exists("g:atp_CommentLeader") || g:atp_reload_variables
    let g:atp_CommentLeader="% "
endif
if !exists("g:atp_MapCommentLines") || g:atp_reload_variables
    let g:atp_MapCommentLines = 1
endif
if !exists("g:atp_XpdfSleepTime") || g:atp_reload_variables
    let g:atp_XpdfSleepTime = "0.2"
endif
if !exists("g:atp_MapCC") || g:atp_reload_variables
    let g:atp_MapCC = 0
endif
if !exists("g:atp_DefaultErrorFormat") || g:atp_reload_variables
    let g:atp_DefaultErrorFormat = "erc"
endif
let b:atp_ErrorFormat = g:atp_DefaultErrorFormat
if !exists("g:atp_DefiSearchMaxWindowHeight") || g:atp_reload_variables
    let g:atp_DefiSearchMaxWindowHeight=15
endif
if !exists("g:atp_ProgressBar") || g:atp_reload_variables
    let g:atp_ProgressBar = 1
endif
let g:atp_cmdheight = &l:cmdheight
if !exists("g:atp_DebugModeQuickFixHeight") || g:atp_reload_variables 
    let g:atp_DebugModeQuickFixHeight = 8 
endif
if !exists("g:atp_DebugModeCmdHeight") || g:atp_reload_variables 
    let g:atp_DebugModeCmdHeight = &l:cmdheight
endif
if !exists("g:atp_DebugMode_AU_change_cmdheight") || g:atp_reload_variables
    " Background Compilation will change the 'cmdheight' option when the compilation
    " was without errors. AU - autocommand compilation
    let g:atp_DebugMode_AU_change_cmdheight = 0
    " This is the 'stay out of my way' solution. 
endif
if !exists("g:atp_Compiler") || g:atp_reload_variables 
    let g:atp_Compiler = "python"
endif
if !exists("g:atp_ReloadViewers") || g:atp_reload_variables
    " List of viewers which need to be reloaded after output file is updated.
    let g:atp_ReloadViewers	= [ 'xpdf' ]
endif
if !exists("g:atp_PythonCompilerPath") || g:atp_reload_variables
    let g:atp_PythonCompilerPath=globpath(&rtp, 'ftplugin/ATP_files/compile.py')
endif
if !exists("g:atp_cpcmd") || g:atp_reload_variables
    " This will avoid using -i switch which might be defined in an alias file. 
    " This doesn't make much harm, but it might be better. 
    let g:atp_cpcmd="/bin/cp"
endif
" Variables for imaps, standard environment names:
    if !exists("g:atp_EnvNameTheorem") || g:atp_reload_variables
	let g:atp_EnvNameTheorem="theorem"
    endif
    if !exists("g:atp_EnvNameDefinition") || g:atp_reload_variables
	let g:atp_EnvNameDefinition="definition"
    endif
    if !exists("g:atp_EnvNameProposition") || g:atp_reload_variables
	let g:atp_EnvNameProposition="proposition"
    endif
    if !exists("g:atp_EnvNameObservation") || g:atp_reload_variables
	" This mapping is defined only in old layout:
	" i.e. if g:atp_env_maps_old == 1
	let g:atp_EnvNameObservation="observation"
    endif
    if !exists("g:atp_EnvNameLemma") || g:atp_reload_variables
	let g:atp_EnvNameLemma="lemma"
    endif
    if !exists("g:atp_EnvNameNote") || g:atp_reload_variables
	let g:atp_EnvNameNote="note"
    endif
    if !exists("g:atp_EnvNameCorollary") || g:atp_reload_variables
	let g:atp_EnvNameCorollary="corollary"
    endif
    if !exists("g:atp_EnvNameRemark") || g:atp_reload_variables
	let g:atp_EnvNameRemark="remark"
    endif
if !exists("g:atp_EnvOptions_enumerate") || g:atp_reload_variables
    " add options to \begin{enumerate} for example [topsep=0pt,noitemsep] Then the
    " enumerate map <Leader>E will put \begin{enumerate}[topsep=0pt,noitemsep] Useful
    " options of enumitem to make enumerate more condenced.
    let g:atp_EnvOptions_enumerate=""
endif
if !exists("g:atp_EnvOptions_itemize") || g:atp_reload_variables
    " Similar to g:atp_enumerate_options.
    let g:atp_EnvOptions_itemize=""
endif
if !exists("g:atp_VimCompatible") || g:atp_reload_variables
    " Used by: % (s:JumpToMatch in LatexBox_motion.vim).
    let g:atp_VimCompatible = "no"
    " It can be 0/1 or yes/no.
endif 
if !exists("g:atp_CupsOptions") || g:atp_reload_variables
    " lpr command options for completion of SshPrint command.
    let g:atp_CupsOptions = [ 'landscape=', 'scaling=', 'media=', 'sides=', 'Collate=', 'orientation-requested=', 
		\ 'job-sheets=', 'job-hold-until=', 'page-ragnes=', 'page-set=', 'number-up=', 'page-border=', 
		\ 'number-up-layout=', 'fitplot=', 'outputorder=', 'mirror=', 'raw=', 'cpi=', 'columns=',
		\ 'page-left=', 'page-right=', 'page-top=', 'page-bottom=', 'prettyprint=', 'nowrap=', 'position=',
		\ 'natural-scaling=', 'hue=', 'ppi=', 'saturation=', 'blackplot=', 'penwidth=']
endif
if !exists("g:atp_lprcommand") || g:atp_reload_variables
    " Used by :SshPrint
    let g:atp_lprcommand = "lpr"
endif 
if !exists("g:atp_iabbrev_leader") || g:atp_reload_variables
    " Used for abbreviations: =theorem= (from both sides).
    let g:atp_iabbrev_leader = "="
endif 
if !exists("g:atp_bibrefRegister") || g:atp_reload_variables
    " A register to which bibref obtained from AMS will be copied.
    let g:atp_bibrefRegister = "0"
endif
if !exists("g:atpbib_pathseparator") || g:atp_reload_variables
    if has("win16") || has("win32") || has("win64") || has("win95")
	let g:atpbib_pathseparator = "\\"
    else
	let g:atpbib_pathseparator = "/"
    endif 
endif
if !exists("g:atpbib_WgetOutputFile") || g:atp_reload_variables
    let g:atpbib_WgetOutputFile = "amsref.html"
endif
if !exists("g:atpbib_wget") || g:atp_reload_variables
    let g:atpbib_wget="wget"
endif
if !exists("g:atp_vmap_text_font_leader") || g:atp_reload_variables
    let g:atp_vmap_text_font_leader="<LocalLeader>"
endif
if !exists("g:atp_vmap_environment_leader") || g:atp_reload_variables
    let g:atp_vmap_environment_leader="<LocalLeader>"
endif
if !exists("g:atp_vmap_bracket_leader") || g:atp_reload_variables
    let g:atp_vmap_bracket_leader="<LocalLeader>"
endif
if !exists("g:atp_vmap_big_bracket_leader") || g:atp_reload_variables
    let g:atp_vmap_big_bracket_leader='<LocalLeader>b'
endif
if !exists("g:atp_map_forward_motion_leader") || g:atp_reload_variables
    let g:atp_map_forward_motion_leader='>'
endif
if !exists("g:atp_map_backward_motion_leader") || g:atp_reload_variables
    let g:atp_map_backward_motion_leader='<'
endif
if !exists("g:atp_RelativePath") || g:atp_reload_variables
    " This is here only for completness, the default value is set in project.vim
    let g:atp_RelativePath 	= 1
endif
if !exists("g:atp_SyncXpdfLog") || g:atp_reload_variables
    let g:atp_SyncXpdfLog 	= 0
endif
if !exists("g:atp_LogSync") || g:atp_reload_variables
    let g:atp_LogSync 		= 0
endif

	function! s:Sync(...)
	    let arg = ( a:0 >=1 ? a:1 : "" )
	    if arg == "on"
		let g:atp_LogSync = 1
	    elseif arg == "off"
		let g:atp_LogSync = 0
	    else
		let g:atp_LogSync = !g:atp_LogSync
	    endif
	    echomsg "[ATP:] g:atp_LogSync = " . g:atp_LogSync
	endfunction
	command! -buffer -nargs=? -complete=customlist,s:SyncComp LogSync :call s:Sync(<f-args>)
	function! s:SyncComp(ArgLead, CmdLine, CursorPos)
	    return filter(['on', 'off'], "v:val =~ a:ArgLead") 
	endfunction

if !exists("g:atp_Compare") || g:atp_reload_variables
    " Use b:changedtick variable to run s:Compiler automatically.
    let g:atp_Compare = "changedtick"
endif
if !exists("g:atp_babel") || g:atp_reload_variables 
    let g:atp_babel = 0
endif
" if !exists("g:atp_closebracket_checkenv") || g:atp_reload_variables
    " This is a list of environment names. They will be checked by
    " atplib#CloseLastBracket() function (if they are opened/closed:
    " ( \begin{array} ... <Tab>       will then close first \begin{array} and then ')'
    try
	let g:atp_closebracket_checkenv	= [ 'array' ]
	" Changing this variable is not yet supported *see ToDo: in
	" atplib#CloseLastBracket() (autoload/atplib.vim)
	lockvar g:atp_closebracket_checkenv
    catch /E741:/
    endtry
" endif
" if !exists("g:atp_ProjectScript") || g:atp_reload_variables
"     let g:atp_ProjectScript = 1
" endif
if !exists("g:atp_OpenTypeDict") || g:atp_reload_variables
    let g:atp_OpenTypeDict = { 
		\ "pdf" 	: "xpdf",		"ps" 	: "evince",
		\ "djvu" 	: "djview",		"txt" 	: "split" ,
		\ "tex"		: "edit",		"dvi"	: "xdvi -s 5" }
    " for txt type files supported viewers: cat, gvim = vim = tabe, split, edit
endif
if !exists("g:atp_LibraryPath") || g:atp_reload_variables
    let g:atp_LibraryPath	= 0
endif
if !exists("g:atp_statusOutDir") || g:atp_reload_variables
    let g:atp_statusOutDir 	= 1
endif
if !exists("g:atp_developer") || g:atp_reload_variables
    let g:atp_developer		= 0
endif
if !exists("g:atp_mapNn") || g:atp_reload_variables
	let g:atp_mapNn		= 0 " This value is used only on startup, then :LoadHistory sets the default value.
endif  				    " user cannot change the value set by :LoadHistory on startup in atprc file.
" 				    " Unless using: 
" 				    	au VimEnter *.tex let b:atp_mapNn = 0
" 				    " Recently I changed this: in project files it is
" 				    better to start with atp_mapNn = 0 and let the
" 				    user change it. 
if !exists("g:atp_TeXdocDefault") || g:atp_reload_variables
    let g:atp_TeXdocDefault	= '-a -I lshort'
endif
"ToDo: to doc.
"ToDo: luatex! (can produce both!)
if !exists("g:atp_CompilersDict") || g:atp_reload_variables
    let g:atp_CompilersDict 	= { 
		\ "pdflatex" 	: ".pdf", 	"pdftex" 	: ".pdf", 
		\ "xetex" 	: ".pdf", 	"latex" 	: ".dvi", 
		\ "tex" 	: ".dvi",	"elatex"	: ".dvi",
		\ "etex"	: ".dvi", 	"luatex"	: ".pdf"}
endif

if !exists("g:CompilerMsg_Dict") || g:atp_reload_variables
    let g:CompilerMsg_Dict	= { 
		\ 'tex'			: 'TeX', 
		\ 'etex'		: 'eTeX', 
		\ 'pdftex'		: 'pdfTeX', 
		\ 'latex' 		: 'LaTeX',
		\ 'elatex' 		: 'eLaTeX',
		\ 'pdflatex'		: 'pdfLaTeX', 
		\ 'context'		: 'ConTeXt',
		\ 'luatex'		: 'LuaTeX',
		\ 'xetex'		: 'XeTeX'}
endif

if !exists("g:ViewerMsg_Dict") || g:atp_reload_variables
    let g:ViewerMsg_Dict	= {
		\ 'xpdf'		: 'Xpdf',
		\ 'xdvi'		: 'Xdvi',
		\ 'kpdf'		: 'Kpdf',
		\ 'okular'		: 'Okular', 
		\ 'evince'		: 'Evince',
		\ 'acroread'		: 'AcroRead',
		\ 'epdfview'		: 'epdfView' }
endif
if !exists("g:atp_updatetime_insert") || g:atp_reload_variables
    let g:atp_updatetime_insert = 2000
endif
if !exists("g:atp_updatetime_normal") || g:atp_reload_variables
    let g:atp_updatetime_normal = 1000
endif
if g:atp_updatetime_normal
    let &l:updatetime=g:atp_updatetime_normal
endif
if !exists("g:atp_DefaultDebugMode") || g:atp_reload_variables
    " recognised values: silent, debug.
    let g:atp_DefaultDebugMode	= "silent"
endif
if !exists("g:atp_show_all_lines") || g:atp_reload_variables
    " boolean
    let g:atp_show_all_lines 	= 0
endif
if !exists("g:atp_ignore_unmatched") || g:atp_reload_variables
    " boolean
    let g:atp_ignore_unmatched 	= 1
endif
if !exists("g:atp_imap_first_leader") || g:atp_reload_variables
    let g:atp_imap_first_leader	= "#"
endif
if !exists("g:atp_imap_second_leader") || g:atp_reload_variables
    let g:atp_imap_second_leader= "##"
endif
if !exists("g:atp_imap_third_leader") || g:atp_reload_variables
    let g:atp_imap_third_leader	= "]"
endif
if !exists("g:atp_imap_fourth_leader") || g:atp_reload_variables
    let g:atp_imap_fourth_leader= "["
endif
" todo: to doc.
if !exists("g:atp_completion_font_encodings") || g:atp_reload_variables
    let g:atp_completion_font_encodings	= ['T1', 'T2', 'T3', 'T5', 'OT1', 'OT2', 'OT4', 'UT1']
endif
" todo: to doc.
if !exists("g:atp_font_encoding") || g:atp_reload_variables
    let s:line=atplib#SearchPackage('fontenc')
    if s:line != 0
	" the last enconding is the default one for fontenc, this we will
	" use
	let s:enc=matchstr(getline(s:line),'\\usepackage\s*\[\%([^,]*,\)*\zs[^]]*\ze\]\s*{fontenc}')
    else
	let s:enc='OT1'
    endif
    let g:atp_font_encoding=s:enc
    unlet s:line
    unlet s:enc
endif
if !exists("g:atp_no_star_environments")
    let g:atp_no_star_environments=['document', 'flushright', 'flushleft', 'center', 
		\ 'enumerate', 'itemize', 'tikzpicture', 'scope', 
		\ 'picture', 'array', 'proof', 'tabular', 'table' ]
endif
if !exists("g:atp_sizes_of_brackets") || g:atp_reload_variables
    let g:atp_sizes_of_brackets={'\left': '\right', 
			    \ '\bigl' 	: '\bigr', 
			    \ '\Bigl' 	: '\Bigr', 
			    \ '\biggl' 	: '\biggr' , 
			    \ '\Biggl' 	: '\Biggr', 
			    \ '\big'	: '\big',
			    \ '\Big'	: '\Big',
			    \ '\bigg'	: '\bigg',
			    \ '\Bigg'	: '\Bigg',
			    \ '\' 	: '\',
			    \ }
   " the last one is not a size of a bracket is to a hack to close \(:\), \[:\] and
   " \{:\}
endif
if !exists("g:atp_algorithmic_dict") || g:atp_reload_variables
    let g:atp_algorithmic_dict = { 'IF' : 'ENDIF', 'FOR' : 'ENDFOR', 'WHILE' : 'ENDWHILE' }
endif
if !exists("g:atp_bracket_dict") || g:atp_reload_variables
    let g:atp_bracket_dict = { '(' : ')', '{' : '}', '[' : ']', '\lceil' : '\rceil', '\lfloor' : '\rfloor', '\langle' : '\rangle', '\lgroup' : '\rgroup' }
endif
if !exists("g:atp_LatexBox") || g:atp_reload_variables
    let g:atp_LatexBox		= 1
endif
if !exists("g:atp_check_if_LatexBox") || g:atp_reload_variables
    let g:atp_check_if_LatexBox	= 1
endif
if !exists("g:atp_autex_check_if_closed") || g:atp_reload_variables
    let g:atp_autex_check_if_closed = 1
endif
if !exists("g:atp_env_maps_old") || g:atp_reload_variables
    let g:atp_env_maps_old	= 0
endif
if !exists("g:atp_amsmath") || g:atp_reload_variables
    let g:atp_amsmath=atplib#SearchPackage('ams')
endif
if atplib#SearchPackage('amsmath') || g:atp_amsmath != 0 || atplib#DocumentClass(b:atp_MainFile) =~ '^ams'
    exe "setlocal complete+=k".globpath(&rtp, "ftplugin/ATP_files/dictionaries/ams_dictionary")
endif
if !exists("g:atp_no_math_command_completion") || g:atp_reload_variables
    let g:atp_no_math_command_completion = 0
endif
if !exists("g:atp_tex_extensions") || g:atp_reload_variables
    let g:atp_tex_extensions	= ["tex.project.vim", "aux", "log", "bbl", "blg", "bcf", "run.xml", "spl", "snm", "nav", "thm", "brf", "out", "toc", "mpx", "idx", "ind", "ilg", "maf", "glo", "mtc[0-9]", "mtc1[0-9]", "pdfsync", "synctex.gz" ]
endif
for ext in g:atp_tex_extensions
    let suffixes = split(&suffixes, ",")
    if index(suffixes, ".".ext) == -1
	exe "setlocal suffixes+=.".ext
    endif
endfor
if !exists("g:atp_delete_output") || g:atp_reload_variables
    let g:atp_delete_output	= 0
endif
if !exists("g:keep") || g:atp_reload_variables
    let g:keep=[ "log", "aux", "toc", "bbl", "ind", "synctex.gz", "blg", "loa", "toc", "lot", "lof", "thm" ]
    " biber stuff is added before compelation, this makes it possible to change 
    " to biber on the fly
    if b:atp_BibCompiler =~ '^\s*biber\>'
	let g:keep += [ "run.xml", "bcf" ]
    endif
endif
if !exists("g:atp_ssh") || g:atp_reload_variables
    " WINDOWS NOT COMPATIBLE
    let g:atp_ssh=$USER . "@localhost"
endif
" opens bibsearch results in vertically split window.
if !exists("g:vertical") || g:atp_reload_variables
    let g:vertical		= 1
endif
if !exists("g:matchpair") || g:atp_reload_variables
    let g:matchpair="(:),[:],{:}"
endif
if !exists("g:texmf") || g:atp_reload_variables
    let g:texmf			= $HOME . "/texmf"
endif
if !exists("g:atp_compare_embedded_comments") || g:atp_reload_variables || g:atp_compare_embedded_comments != 1
    let g:atp_compare_embedded_comments  = 0
endif
if !exists("g:atp_compare_double_empty_lines") || g:atp_reload_variables || g:atp_compare_double_empty_lines != 0
    let g:atp_compare_double_empty_lines = 1
endif
"TODO: put toc_window_with and labels_window_width into DOC file
if !exists("t:toc_window_width") || g:atp_reload_variables
    if exists("g:toc_window_width")
	let t:toc_window_width	= g:toc_window_width
    else
	let t:toc_window_width	= 30
    endif
endif
if !exists("t:atp_labels_window_width") || g:atp_reload_variables
    if exists("g:labels_window_width")
	let t:atp_labels_window_width = g:labels_window_width
    else
	let t:atp_labels_window_width = 30
    endif
endif
if !exists("g:atp_completion_limits") || g:atp_reload_variables
    let g:atp_completion_limits	= [40,60,80,120]
endif
if !exists("g:atp_long_environments") || g:atp_reload_variables
    let g:atp_long_environments	= []
endif
if !exists("g:atp_no_complete") || g:atp_reload_variables
     let g:atp_no_complete	= ['document']
endif
" if !exists("g:atp_close_after_last_closed") || g:atp_reload_variables
"     let g:atp_close_after_last_closed=1
" endif
if !exists("g:atp_no_env_maps") || g:atp_reload_variables
    let g:atp_no_env_maps	= 0
endif
if !exists("g:atp_extra_env_maps") || g:atp_reload_variables
    let g:atp_extra_env_maps	= 0
endif
" todo: to doc. Now they go first.
" if !exists("g:atp_math_commands_first") || g:atp_reload_variables
"     let g:atp_math_commands_first=1
" endif
if !exists("g:atp_completion_truncate") || g:atp_reload_variables
    let g:atp_completion_truncate	= 4
endif
" ToDo: to doc.
" add server call back (then automatically reads errorfiles)
if !exists("g:atp_statusNotif") || g:atp_reload_variables
    if has('clientserver') && !empty(v:servername) 
	let g:atp_statusNotif	= 1
    else
	let g:atp_statusNotif	= 0
    endif
endif
if !exists("g:atp_statusNotifHi") || g:atp_reload_variables
    " User<nr>  - highlight status notifications with highlight group User<nr>.
    let g:atp_statusNotifHi	= 0
endif
if !exists("g:atp_callback") || g:atp_reload_variables
    if exists("g:atp_statusNotif") && g:atp_statusNotif == 1 &&
		\ has('clientserver') && !empty(v:servername)
	let g:atp_callback	= 1
    else
	let g:atp_callback	= 0
    endif
endif
" ToDo: to doc.
" I switched this off.
" if !exists("g:atp_complete_math_env_first") || g:atp_reload_variables
"     let g:atp_complete_math_env_first=0
" endif
" }}}
"

" Project Settings:
" {{{1
if !exists("g:atp_ProjectLocalVariables") || g:atp_reload_variables
    " This is a list of variable names which will be preserved in project files
    let g:atp_ProjectLocalVariables = [
		\ "b:atp_MainFile", 	"g:atp_mapNn", 		"b:atp_autex", 
		\ "b:atp_TexCompiler", 	"b:atp_TexFlavor", 	"b:atp_OutDir" , 
		\ "b:atp_auruns", 	"b:atp_ReloadOnErr", 	"b:atp_OpenViewer", 
		\ "b:atp_XpdfServer",	"b:atp_ProjectDir", 	"b:atp_Viewer",
		\ "b:TreeOfFiles",	"b:ListOfFiles", 	"b:TypeDict",
		\ "b:LevelDict", 	"b:atp_BibCompiler"
		\ ] 
endif
" the variable a:1 is the name of the variable which stores the list of variables to
" save.
function! SaveProjectVariables(...)
    let variables_List	= ( a:0 >= 1 ? {a:1} : g:atp_ProjectLocalVariables )
    let variables_Dict 	= {}
    for var in variables_List
	if exists(var)
	    call extend(variables_Dict, { var : {var} })
	endif
    endfor
    return variables_Dict
endfunction
function! RestoreProjectVariables(variables_Dict)
    for var in keys(a:variables_Dict)
 	let cmd =  "let " . var . "=" . string(a:variables_Dict[var])
	try
	    exe cmd
	catch E741:
	    "if the variable was locked
	    exe "unlockvar ".var
	    exe cmd
	    exe "lockvar ".var 
	endtry
    endfor
endfunction
" }}}1

" This is to be extended into a nice function which shows the important options
" and allows to reconfigure atp
"{{{ ShowOptions
let s:file	= expand('<sfile>:p')
function! s:ShowOptions(bang,...)

    let pattern	= a:0 >= 1 ? a:1 : ".*,"
    let mlen	= max(map(copy(keys(s:optionsDict)), "len(v:val)"))

    redraw
    echohl WarningMsg
    echo "Local buffer variables:"
    echohl Normal
    for key in keys(s:optionsDict)
	let space = ""
	for s in range(mlen-len(key)+1)
	    let space .= " "
	endfor
	if "b:".key =~ pattern
" 	    if patn != '' && "b:".key !~ patn
		echo "b:".key.space.string(getbufvar(bufnr(""), key))
" 	    endif
	endif
    endfor
    if a:bang == "!"
" 	Show some global options
	echo "\n"
	echohl WarningMsg
	echo "Global variables (defined in ".s:file."):"
	echohl Normal
	let saved_loclist	= getloclist(0)
	    execute "lvimgrep /^\\s*let\\s\\+g:/j " . fnameescape(s:file)
	let global_vars		= getloclist(0)
	call setloclist(0, saved_loclist)
	let var_list		= []

	for var in global_vars
	    let var_name	= matchstr(var['text'], '^\s*let\s\+\zsg:\S*\ze\s*=')
	    if len(var_name) 
		call add(var_list, var_name)
	    endif
	endfor

	" Filter only matching variables that exists!
	call filter(var_list, 'count(var_list, v:val) == 1 && exists(v:val)')
	let mlen	= max(map(copy(var_list), "len(v:val)"))
	for var_name in var_list
	    let space = ""
	    for s in range(mlen-len(var_name)+1)
		let space .= " "
	    endfor
	    if var_name =~ pattern && var_name !~ '_command\|_amsfonts\|ams_negations\|tikz_\|keywords'
" 		if patn != '' && var_name !~ patn
		if index(["g:atp_LatexPackages", "g:atp_LatexClasses", "g:optionsDict", "g:optionsKeys", "g:atp_completion_modes", "g:atp_completion_modes_normal_mode", "g:atp_Environments", "g:atp_shortname_dict", "g:atp_MathTools_environments", "g:atp_keymaps", "g:atp_CupsOptions", "g:atp_CompilerMsg_Dict", "g:ViewerMsg_Dict", "g:CompilerMsg_Dict", "g:atp_amsmath_environments"], var_name) == -1 && var_name !~# '^g:atp_Beamer' && var_name !~# '^g:atp_TodoNotes'
		    echo var_name.space.string({var_name})
		    if len(var_name.space.string({var_name})) > &l:columns
			echo "\n"
		    endif
		endif
" 		endif
	    endif
	endfor

    endif
endfunction
command! -buffer -bang -nargs=* ShowOptions		:call <SID>ShowOptions(<q-bang>, <q-args>)
"}}}

" Debug Mode Variables:
" {{{ Debug Mode
let t:atp_DebugMode	= g:atp_DefaultDebugMode 
" there are three possible values of t:atp_DebugMode
" 	silent/normal/debug
if !exists("t:atp_QuickFixOpen")
    let t:atp_QuickFixOpen	= 0
endif

if !s:did_options
    augroup ATP_DebugMode
	au FileType *.tex let t:atp_DebugMode	= g:atp_DefaultDebugMode
	" When opening the quickfix error buffer:  
	au FileType qf 	let t:atp_QuickFixOpen=1
	" When closing the quickfix error buffer (:close, :q) also end the Debug Mode.
	au FileType qf 	au BufUnload <buffer> let t:atp_DebugMode = g:atp_DefaultDebugMode | let t:atp_QuickFixOpen = 0
	au FileType qf	setl nospell
    augroup END
endif
"}}}

" Babel
" {{{1 variables
if !exists("g:atp_keymaps") || g:atp_reload_variables
let g:atp_keymaps = { 
		\ 'british'	: 'ignore',		'english' 	: 'ignore',
		\ 'USenglish'	: 'ignore', 		'UKenglish'	: 'ignore',
		\ 'american'	: 'ignore',
	    	\ 'bulgarian' 	: 'bulgarian-bds', 	'croatian' 	: 'croatian',
		\ 'czech'	: 'czech',		'greek'		: 'greek',
		\ 'plutonikogreek': 'greek',		'hebrew'	: 'hebrew',
		\ 'russian' 	: 'russian-jcuken',	'serbian' 	: 'serbian',
		\ 'slovak' 	: 'slovak', 		'ukrainian' 	: 'ukrainian-jcuken',
		\ 'polish' 	: 'polish-slash' }
else "extend the existing dictionary with default values not ovverriding what is defind:
    for lang in [ 'croatian', 'czech', 'greek', 'hebrew', 'serbian', 'slovak' ] 
	call extend(g:atp_keymaps, { lang : lang }, 'keep')
    endfor
    call extend(g:atp_keymaps, { 'british' 	: 'ignore' }, 		'keep')
    call extend(g:atp_keymaps, { 'american' 	: 'ignore' }, 		'keep')
    call extend(g:atp_keymaps, { 'english' 	: 'ignore' }, 		'keep')
    call extend(g:atp_keymaps, { 'UKenglish' 	: 'ignore' }, 		'keep')
    call extend(g:atp_keymaps, { 'USenglish' 	: 'ignore' }, 		'keep')
    call extend(g:atp_keymaps, { 'bulgarian' 	: 'bulgarian-bds' }, 	'keep')
    call extend(g:atp_keymaps, { 'plutonikogreek' : 'greek' }, 		'keep')
    call extend(g:atp_keymaps, { 'russian' 	: 'russian-jcuken' }, 	'keep')
    call extend(g:atp_keymaps, { 'ukrainian' 	: 'ukrainian-jcuken' },	'keep')
endif

" {{{1 function
function! <SID>Babel()
    " Todo: make notification.
    if &filetype != "tex" || !exists("b:atp_MainFile") || !has("keymap")
	" This only works for LaTeX documents.
	" but it might work for plain tex documents as well!
	return
    endif
    let atp_MainFile	= atplib#FullPath(b:atp_MainFile)

    let saved_loclist = getloclist(0)
    try
	execute '1lvimgrep /^[^%]*\\usepackage.*{babel}/j ' . fnameescape(atp_MainFile)
	" Find \usepackage[babel_options]{babel} - this is the only way that one can
	" pass options to babel.
    catch /E480:/
	return
    catch /E683:/ 
	return
    endtry
    let babel_line 	= get(get(getloclist(0), 0, {}), 'text', '')
    call setloclist(0, saved_loclist) 
    let languages	= split(matchstr(babel_line, '\[\zs[^]]*\ze\]'), ',')
    if len(languages) == 0
	return
    endif
    let default_language 	= get(languages, '-1', '') 
	if g:atp_debugBabel
	    echomsg "[Babel:] defualt language:" . default_language
	endif
    let keymap 			= get(g:atp_keymaps, default_language, '')

    if keymap == ''
	if g:atp_debugBabel
	    echoerr "No keymap in g:atp_keymaps.\n" . babel_line
	endif
	return
    endif

    if keymap != 'ignore'
	execute "set keymap=" . keymap
    else
	execute "set keymap="
    endif
endfunction
command! -buffer Babel	:call <SID>Babel()
" {{{1 start up
if g:atp_babel
    call <SID>Babel()
endif
"  }}}1

" These are two functions which sets options for Xpdf and Xdvi. 
" {{{ Xpdf, Xdvi
" xdvi - supports forward and reverse searching
" {{{ SetXdvi
function! <SID>SetXdvi()

    " Remove menu entries
    let Compiler		= get(g:CompilerMsg_Dict, matchstr(b:atp_TexCompiler, '^\s*\S*'), 'Compiler')
    let Viewer			= get(g:ViewerMsg_Dict, matchstr(b:atp_Viewer, '^\s*\S*'), 'View\ Output')
    try
	execute "aunmenu LaTeX.".Compiler
	execute "aunmenu LaTeX.".Compiler."\\ debug"
	execute "aunmenu LaTeX.".Compiler."\\ twice"
	execute "aunmenu LaTeX.View\\ with\\ ".Viewer
    catch /E329:/
    endtry

    " Set new options:
    let b:atp_TexCompiler	= "latex"
    let b:atp_TexOptions	= "-src-specials"
    let b:atp_Viewer		= "xdvi"
    if exists("g:atp_xdviOptions")
	let g:atp_xdviOptions	+= index(g:atp_xdviOptions, '-editor') != -1 && 
		    \ ( !exists("b:atp_xdviOptions") || exists("b:atp_xdviOptions") && index(b:atp_xdviOptions,  '-editor') != -1 )
		    \ ? ["-editor", "'".v:progname." --servername ".v:servername." --remote-wait +%l %f'"] : []
    else
	let g:atp_xdviOptions = ["-editor",  "'".v:progname." --servername ".v:servername." --remote-wait +%l %f'"]
    endif

    map <buffer> <LocalLeader>rs				:call RevSearch()<CR>
    try
	nmenu 550.65 &LaTeX.Reverse\ Search<Tab>:map\ <LocalLeader>rs	:RevSearch<CR>
    catch /E329:/
    endtry

    " Put new menu entries:
    let Compiler	= get(g:CompilerMsg_Dict, matchstr(b:atp_TexCompiler, '^\s*\zs\S*'), 'Compile')
    let Viewer		= get(g:ViewerMsg_Dict, matchstr(b:atp_Viewer, '^\s*\zs\S*'), "View\\ Output")
    execute "nmenu 550.5 &LaTeX.&".Compiler."<Tab>:TEX			:TEX<CR>"
    execute "nmenu 550.6 &LaTeX.".Compiler."\\ debug<Tab>:TEX\\ debug 	:DTEX<CR>"
    execute "nmenu 550.7 &LaTeX.".Compiler."\\ &twice<Tab>:2TEX		:2TEX<CR>"
    execute "nmenu 550.10 LaTeX.&View\\ with\\ ".Viewer."<Tab>:ViewOutput 		:ViewOutput<CR>"
endfunction
command! -buffer SetXdvi			:call <SID>SetXdvi()
nnoremap <silent> <buffer> <Plug>SetXdvi	:call <SID>SetXdvi()<CR>
" }}}

" xpdf - supports server option (we use the reoding mechanism, which allows to
" copy the output file but not reload the viewer if there were errors during
" compilation (b:atp_ReloadOnError variable)
" {{{ SetXpdf
function! <SID>SetPdf(viewer)

    " Remove menu entries.
    let Compiler		= get(g:CompilerMsg_Dict, matchstr(b:atp_TexCompiler, '^\s*\S*'), 'Compiler')
    let Viewer			= get(g:ViewerMsg_Dict, matchstr(b:atp_Viewer, '^\s*\S*'), 'View\ Output')
    try 
	execute "aunmenu LaTeX.".Compiler
	execute "aunmenu LaTeX.".Compiler."\\ debug"
	execute "aunmenu LaTeX.".Compiler."\\ twice"
	execute "aunmenu LaTeX.View\\ with\\ ".Viewer
    catch /E329:/
    endtry

    let b:atp_TexCompiler	= "pdflatex"
    " We have to clear tex options (for example -src-specials set by :SetXdvi)
    let b:atp_TexOptions	= "-synctex=1"
    let b:atp_Viewer		= a:viewer

    " Delete menu entry.
    try
	silent aunmenu LaTeX.Reverse\ Search
    catch /E329:/
    endtry

    " Put new menu entries:
    let Compiler	= get(g:CompilerMsg_Dict, matchstr(b:atp_TexCompiler, '^\s*\zs\S*'), 'Compile')
    let Viewer		= get(g:ViewerMsg_Dict, matchstr(b:atp_Viewer, '^\s*\zs\S*'), 'View\ Output')
    execute "nmenu 550.5 &LaTeX.&".Compiler.	"<Tab>:TEX			:TEX<CR>"
    execute "nmenu 550.6 &LaTeX." .Compiler.	"\\ debug<Tab>:TEX\\ debug 	:DTEX<CR>"
    execute "nmenu 550.7 &LaTeX." .Compiler.	"\\ &twice<Tab>:2TEX		:2TEX<CR>"
    execute "nmenu 550.10 LaTeX.&View\\ with\\ ".Viewer.	"<Tab>:ViewOutput 		:ViewOutput<CR>"
endfunction
command! -buffer SetXpdf			:call <SID>SetPdf('xpdf')
command! -buffer SetOkular			:call <SID>SetPdf('okular')
nnoremap <silent> <buffer> <Plug>SetXpdf	:call <SID>SetPdf('xpdf')<CR>
nnoremap <silent> <buffer> <Plug>SetOkular	:call <SID>SetPdf('okular')<CR>
" }}}
""
" }}}

" These are functions which toggles some of the options:
"{{{ Toggle Functions
if !s:did_options || g:atp_reload_functions
" {{{ ATP_ToggleAuTeX
" command! -buffer -count=1 TEX	:call TEX(<count>)		 
function! ATP_ToggleAuTeX(...)
  let on	= ( a:0 >=1 ? ( a:1 == 'on'  ? 1 : 0 ) : !b:atp_autex )
    if on
	let b:atp_autex=1	
	echo "[ATP:] ON"
	silent! aunmenu LaTeX.Toggle\ AuTeX\ [off]
	silent! aunmenu LaTeX.Toggle\ AuTeX\ [on]
	menu 550.75 &LaTeX.&Toggle\ AuTeX\ [on]<Tab>b:atp_autex	:<C-U>ToggleAuTeX<CR>
	cmenu 550.75 &LaTeX.&Toggle\ AuTeX\ [on]<Tab>b:atp_autex	<C-U>ToggleAuTeX<CR>
	imenu 550.75 &LaTeX.&Toggle\ AuTeX\ [on]<Tab>b:atp_autex	<ESC>:ToggleAuTeX<CR>a
    else
	let b:atp_autex=0
	silent! aunmenu LaTeX.Toggle\ AuTeX\ [off]
	silent! aunmenu LaTeX.Toggle\ AuTeX\ [on]
	menu 550.75 &LaTeX.&Toggle\ AuTeX\ [off]<Tab>b:atp_autex	:<C-U>ToggleAuTeX<CR>
	cmenu 550.75 &LaTeX.&Toggle\ AuTeX\ [off]<Tab>b:atp_autex	<C-U>ToggleAuTeX<CR>
	imenu 550.75 &LaTeX.&Toggle\ AuTeX\ [off]<Tab>b:atp_autex	<ESC>:ToggleAuTeX<CR>a
	echo "[ATP:] OFF"
    endif
endfunction
"}}}
" {{{ ATP_ToggleSpace
" Special Space for Searching 
let s:special_space="[off]"
function! ATP_ToggleSpace(...)
    let on	= ( a:0 >=1 ? ( a:1 == 'on'  ? 1 : 0 ) : maparg('<space>','c') == "" )
    if on
	echomsg "[ATP:] special space is on"
	cmap <Space> \_s\+
	let s:special_space="[on]"
	silent! aunmenu LaTeX.Toggle\ Space\ [off]
	silent! aunmenu LaTeX.Toggle\ Space\ [on]
	menu 550.78 &LaTeX.&Toggle\ Space\ [on]<Tab>cmap\ <space>\ \\_s\\+	:<C-U>ToggleSpace<CR>
	cmenu 550.78 &LaTeX.&Toggle\ Space\ [on]<Tab>cmap\ <space>\ \\_s\\+	<C-U>ToggleSpace<CR>
	imenu 550.78 &LaTeX.&Toggle\ Space\ [on]<Tab>cmap\ <space>\ \\_s\\+	<Esc>:ToggleSpace<CR>a
	tmenu &LaTeX.&Toggle\ Space\ [on] cmap <space> \_s\+ is curently on
    else
	echomsg "[ATP:] special space is off"
	cunmap <Space>
	let s:special_space="[off]"
	silent! aunmenu LaTeX.Toggle\ Space\ [on]
	silent! aunmenu LaTeX.Toggle\ Space\ [off]
	menu 550.78 &LaTeX.&Toggle\ Space\ [off]<Tab>cmap\ <space>\ \\_s\\+	:<C-U>ToggleSpace<CR>
	cmenu 550.78 &LaTeX.&Toggle\ Space\ [off]<Tab>cmap\ <space>\ \\_s\\+	<C-U>ToggleSpace<CR>
	imenu 550.78 &LaTeX.&Toggle\ Space\ [off]<Tab>cmap\ <space>\ \\_s\\+	<Esc>:ToggleSpace<CR>a
	tmenu &LaTeX.&Toggle\ Space\ [off] cmap <space> \_s\+ is curently off
    endif
endfunction
function! ATP_CmdwinToggleSpace(on)
    let on	= ( a:0 >=1 ? ( a:1 == 'on'  ? 1 : 0 ) : maparg('<space>', 'i') == "" )
    let g:on	= on
    if on
	echomsg "space ON"
	imap <space> \_s\+
    else
	echomsg "space OFF"
	iunmap <space>
    endif
endfunction
"}}}
" {{{ ATP_ToggleCheckMathOpened
" This function toggles if ATP is checking if editing a math mode.
" This is used by insert completion.
" ToDo: to doc.
function! ATP_ToggleCheckMathOpened(...)
    let on	= ( a:0 >=1 ? ( a:1 == 'on'  ? 1 : 0 ) :  !g:atp_MathOpened )
"     if g:atp_MathOpened
    if !on
	let g:atp_MathOpened = 0
	echomsg "[ATP:] check if in math environment is off"
	silent! aunmenu LaTeX.Toggle\ Check\ if\ in\ Math\ [on]
	silent! aunmenu LaTeX.Toggle\ Check\ if\ in\ Math\ [off]
	menu 550.79 &LaTeX.Toggle\ &Check\ if\ in\ Math\ [off]<Tab>g:atp_MathOpened			
		    \ :<C-U>ToggleCheckMathOpened<CR>
	cmenu 550.79 &LaTeX.Toggle\ &Check\ if\ in\ Math\ [off]<Tab>g:atp_MathOpened			
		    \ <C-U>ToggleCheckMathOpened<CR>
	imenu 550.79 &LaTeX.Toggle\ &Check\ if\ in\ Math\ [off]<Tab>g:atp_MathOpened			
		    \ <Esc>:ToggleCheckMathOpened<CR>a
    else
	let g:atp_MathOpened = 1
	echomsg "[ATP:] check if in math environment is on"
	silent! aunmenu LaTeX.Toggle\ Check\ if\ in\ Math\ [off]
	silent! aunmenu LaTeX.Toggle\ Check\ if\ in\ Math\ [off]
	menu 550.79 &LaTeX.Toggle\ &Check\ if\ in\ Math\ [on]<Tab>g:atp_MathOpened
		    \ :<C-U>ToggleCheckMathOpened<CR>
	cmenu 550.79 &LaTeX.Toggle\ &Check\ if\ in\ Math\ [on]<Tab>g:atp_MathOpened
		    \ <C-U>ToggleCheckMathOpened<CR>
	imenu 550.79 &LaTeX.Toggle\ &Check\ if\ in\ Math\ [on]<Tab>g:atp_MathOpened
		    \ <Esc>:ToggleCheckMathOpened<CR>a
    endif
endfunction
"}}}
" {{{ ATP_ToggleCallBack
function! ATP_ToggleCallBack(...)
    let on	= ( a:0 >=1 ? ( a:1 == 'on'  ? 1 : 0 ) :  !g:atp_callback )
    if !on
	let g:atp_callback	= 0
	echomsg "[ATP:] call back is off"
	silent! aunmenu LaTeX.Toggle\ Call\ Back\ [on]
	silent! aunmenu LaTeX.Toggle\ Call\ Back\ [off]
	menu 550.80 &LaTeX.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	
		    \ :<C-U>call ToggleCallBack()<CR>
	cmenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	
		    \ <C-U>call ToggleCallBack()<CR>
	imenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	
		    \ <Esc>:call ToggleCallBack()<CR>a
    else
	let g:atp_callback	= 1
	echomsg "[ATP:] call back is on"
	silent! aunmenu LaTeX.Toggle\ Call\ Back\ [on]
	silent! aunmenu LaTeX.Toggle\ Call\ Back\ [off]
	menu 550.80 &LaTeX.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback
		    \ :call ToggleCallBack()<CR>
	cmenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback
		    \ <C-U>call ToggleCallBack()<CR>
	imenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback
		    \ <Esc>:call ToggleCallBack()<CR>a
    endif
endfunction
"}}}
" {{{ ATP_ToggleDebugMode
" ToDo: to doc.
" TODO: it would be nice to have this command (and the map) in quickflist (FileType qf)
" describe DEBUG MODE in doc properly.
function! ATP_ToggleDebugMode(mode,...)
    if a:mode != ""
	let set_new 		= 1
	let new_debugmode 	= ( t:atp_DebugMode ==# a:mode ? g:atp_DefaultDebugMode : a:mode )
	let copen 		= ( a:mode =~? '^d\%[ebug]' && t:atp_DebugMode !=? 'debug' && !t:atp_QuickFixOpen )
	let on 			= ( a:mode !=# t:atp_DebugMode )
	if t:atp_DebugMode ==# 'Debug' && a:mode ==# 'debug' || t:atp_DebugMode ==# 'debug' && a:mode ==# 'Debug'
	    let change_menu 	= 0
	else
	    let change_menu 	= 1
	endif
    else
	let change_menu 	= 1
	let new_debugmode	= ""
	if a:0 >= 1 && a:1 =~ '^on\|off$'
	    let [ on, new_debugmode ]	= ( a:1 == 'on'  ? [ 1, 'debug' ] : [0, g:atp_DefaultDebugMode] )
	    let set_new=1
	    let copen = 1
	elseif a:0 >= 1
	    let t:atp_DebugMode	= a:1
	    let new_debugmode 	= a:1
	    let set_new		= 0
	    if a:1 =~ 's\%[ilent]'
		let on		= 0
		let copen		= 0
	    elseif a:1 =~ '^d\%[ebug]'
		let on		= 1 
		let copen		= ( a:1 =~# '^D\%[ebug]' ? 1 : 0 )
	    else
		" for verbose mode
		let on		= 0
		let copen		= 0
	    endif
	else
	    let set_new = 1
	    let [ on, new_debugmode ] = ( t:atp_DebugMode =~? '^\%(debug\|verbose\)$' ? [ 0, g:atp_DefaultDebugMode ] : [ 1, 'debug' ] )
	    let copen 		= 1
	endif
    endif

"     let g:on = on
"     let g:set_new = set_new
"     let g:new_debugmode = new_debugmode
"     let g:copen = copen
"     let g:change_menu = change_menu

    " on == 0 set debug off
    " on == 1 set debug on
    if !on
	echomsg "[ATP debug mode:] ".new_debugmode

	if change_menu
	    silent! aunmenu 550.20.5 LaTeX.Log.Toggle\ &Debug\ Mode\ [on]
	    silent! aunmenu 550.20.5 LaTeX.Log.Toggle\ &Debug\ Mode\ [off]
	    menu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [off]<Tab>ToggleDebugMode
			\ :<C-U>ToggleDebugMode<CR>
	    cmenu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [off]<Tab>ToggleDebugMode
			\ <C-U>ToggleDebugMode<CR>
	    imenu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [off]<Tab>ToggleDebugMode
			\ <Esc>:ToggleDebugMode<CR>a

	    silent! aunmenu LaTeX.Toggle\ Call\ Back\ [on]
	    silent! aunmenu LaTeX.Toggle\ Call\ Back\ [off]
	    menu 550.80 &LaTeX.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	
			\ :<C-U>ToggleDebugMode<CR>
	    cmenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	
			\ <C-U>ToggleDebugMode<CR>
	    imenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	
			\ <Esc>:ToggleDebugMode<CR>a
	endif

	if set_new
	    let t:atp_DebugMode	= new_debugmode
	endif
	silent cclose
    else
	echomsg "[ATP debug mode:] ".new_debugmode

	if change_menu
	    silent! aunmenu 550.20.5 LaTeX.Log.Toggle\ Debug\ Mode\ [off]
	    silent! aunmenu 550.20.5 LaTeX.Log.Toggle\ &Debug\ Mode\ [on]
	    menu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [on]<Tab>ToggleDebugMode
			\ :<C-U>ToggleDebugMode<CR>
	    cmenu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [on]<Tab>ToggleDebugMode
			\ <C-U>ToggleDebugMode<CR>
	    imenu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [on]<Tab>ToggleDebugMode
			\ <Esc>:ToggleDebugMode<CR>a

	    silent! aunmenu LaTeX.Toggle\ Call\ Back\ [on]
	    silent! aunmenu LaTeX.Toggle\ Call\ Back\ [off]
	    menu 550.80 &LaTeX.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback	
			\ :<C-U>ToggleDebugMode<CR>
	    cmenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback	
			\ <C-U>ToggleDebugMode<CR>
	    imenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback	
			\ <Esc>:ToggleDebugMode<CR>a
	endif

	let g:atp_callback	= 1
	if set_new
	    let t:atp_DebugMode	= new_debugmode
	endif
	let winnr = bufwinnr("%")
	if copen
	    let efm=b:atp_ErrorFormat
	    exe "ErrorFormat ".efm
	    silent! cg
	    if len(getqflist()) > 0
		exe "silent copen ".min([atplb#qflength(), g:atp_DebugModeQuickFixHeight])
		exe winnr . " wincmd w"
	    else
		echo "[ATP:] no errors for b:atp_ErrorFormat=".efm
	    endif
	endif
    endif
endfunction
function! ToggleDebugModeCompl(A,B,C)
    return "silent\ndebug\nDebug\nverbose\non\noff"
endfunction
augroup ATP_DebugModeCommandsAndMaps
    au!
    au FileType qf command! -buffer ToggleDebugMode 	:call <SID>ToggleDebugMode()
    au FileType qf nnoremap <silent> <LocalLeader>D		:ToggleDebugMode<CR>
augroup END
" }}}
" {{{ ATP_ToggleTab
" switches on/off the <Tab> map for TabCompletion
function! ATP_ToggleTab(...)
    if mapcheck('<F7>','i') !~ 'atplib#TabCompletion'
	let on	= ( a:0 >=1 ? ( a:1 == 'on'  ? 1 : 0 ) : mapcheck('<Tab>','i') !~# 'atplib#TabCompletion' )
	if !on 
	    iunmap <buffer> <Tab>
	    echo '[ATP:] <Tab> map OFF'
	else
	    imap <buffer> <Tab> <C-R>=atplib#TabCompletion(1)<CR>
	    echo '[ATP:] <Tab> map ON'
	endif
    endif
endfunction
" }}}
" {{{ ATP_ToggleIMaps
" switches on/off the <Tab> map for TabCompletion
function! ATP_ToggleMathIMaps(insert_enter, bang,...)
"     let g:arg	= ( a:0 >=1 ? a:1 : 0 )
"     let g:bang = a:bang
    let on	= ( a:0 >=1 ? ( a:1 == 'on'  ? 1 : 0 ) : g:atp_imap_define_math <= 0 || g:atp_imap_define_math_misc <= 0 )
"     let g:debug=g:atp_imap_define_math." ".g:atp_imap_define_math_misc
"     let g:on	= on
"     echomsg "****"
"     echomsg g:arg
"     echomsg g:debug
"     echomsg g:on
    if on == 0
" 	echomsg "DELETE IMAPS"
	let g:atp_imap_define_math = ( a:bang == "!" ? -1 : 0 ) 
	call atplib#DelMaps(g:atp_imap_math)
	let g:atp_imap_define_math_misc = ( a:bang == "!" ? -1 : 0 )
	call atplib#DelMaps(g:atp_imap_math_misc)
	echo '[ATP:] imaps OFF '.(a:bang == "" ? '(insert)' : '')
    else
" 	echomsg "MAKE IMAPS"
	let g:atp_imap_define_math =1
	call atplib#MakeMaps(g:atp_imap_math)
	let g:atp_imap_define_math_misc = 1
	call atplib#MakeMaps(g:atp_imap_math_misc)
	echo '[ATP:] imaps ON'
    endif
    if a:insert_enter
	let g:atp_eventignore=&l:eventignore
	let g:atp_eventignoreInsertEnter=1
	set eventignore+=InsertEnter
" 	" This doesn't work because startinsert runs after function ends.
    endif
endfunction
" }}}
endif
 
"  Commands And Maps:
command! -buffer -nargs=? -complete=customlist,atplib#OnOffComp	ToggleMathIMaps	 	:call ATP_ToggleMathIMaps(0, "!", <f-args>)
nnoremap <silent> <buffer> 	<Plug>ToggleMathIMaps		:call ATP_ToggleMathIMaps(0, "!")<CR>
inoremap <silent> <buffer> 	<Plug>ToggleMathIMaps		<Esc>:call ATP_ToggleMathIMaps(1, "")<CR>

command! -buffer -nargs=? -complete=customlist,atplib#OnOffComp ToggleAuTeX 	:call ATP_ToggleAuTeX(<f-args>)
nnoremap <silent> <buffer> 	<Plug>ToggleAuTeX 		:call ATP_ToggleAuTeX()<CR>

command! -buffer -nargs=? -complete=customlist,atplib#OnOffComp ToggleSpace 	:call ATP_ToggleSpace(<f-args>)
nnoremap <silent> <buffer> 	<Plug>ToggleSpace 		:call ATP_ToggleSpace()<CR>
nnoremap <silent> <buffer> 	<Plug>ToggleSpaceOn 		:call ATP_ToggleSpace('on')<CR>
nnoremap <silent> <buffer> 	<Plug>ToggleSpaceOff 		:call ATP_ToggleSpace('off')<CR>

command! -buffer -nargs=? -complete=customlist,atplib#OnOffComp	ToggleCheckMathOpened 	:call ATP_ToggleCheckMathOpened(<f-args>)
nnoremap <silent> <buffer> 	<Plug>ToggleCheckMathOpened	:call ATP_ToggleCheckMathOpened()<CR>

command! -buffer -nargs=? -complete=customlist,atplib#OnOffComp	ToggleCallBack 		:call ATP_ToggleCallBack(<f-args>)
nnoremap <silent> <buffer> 	<Plug>ToggleCallBack		:call ATP_ToggleCallBack()<CR>

command! -buffer -nargs=? -complete=custom,ToggleDebugModeCompl	ToggleDebugMode 	:call ATP_ToggleDebugMode("",<f-args>)
nnoremap <silent> <buffer> 	<Plug>ToggledebugMode		:call ATP_ToggleDebugMode("debug")<CR>
nnoremap <silent> <buffer> 	<Plug>ToggleDebugMode		:call ATP_ToggleDebugMode("Debug")<CR>

command! -buffer -nargs=? -complete=customlist,atplib#OnOffComp	ToggleTab	 	:call ATP_ToggleTab(<f-args>)
nnoremap <silent> <buffer> 	<Plug>ToggleTab		:call ATP_ToggleTab()<CR>
inoremap <silent> <buffer> 	<Plug>ToggleTab		<Esc>:call ATP_ToggleTab()<CR>
"}}}

" Tab Completion Variables:
" {{{ TAB COMPLETION variables
" ( functions are in autoload/atplib.vim )
"
try 
let g:atp_completion_modes=[ 
	    \ 'commands', 		'labels', 		
	    \ 'tikz libraries', 	'environment names',
	    \ 'close environments' , 	'brackets',
	    \ 'input files',		'bibstyles',
	    \ 'bibitems', 		'bibfiles',
	    \ 'documentclass',		'tikzpicture commands',
	    \ 'tikzpicture',		'tikzpicture keywords',
	    \ 'package names',		'font encoding',
	    \ 'font family',		'font series',
	    \ 'font shape',		'algorithmic',
	    \ 'beamerthemes', 		'beamerinnerthemes',
	    \ 'beamerouterthemes', 	'beamercolorthemes',
	    \ 'beamerfontthemes',	'todonotes' ]
lockvar 2 g:atp_completion_modes
catch /E741:/
endtry

if !exists("g:atp_completion_modes_normal_mode") || g:atp_reload_variables
    unlockvar g:atp_completion_modes_normal_mode
    let g:atp_completion_modes_normal_mode=[ 
		\ 'close environments' , 'brackets', 'algorithmic' ]
    lockvar g:atp_completion_modes_normal_mode
endif

" By defualt all completion modes are ative.
if !exists("g:atp_completion_active_modes") || g:atp_reload_variables
    let g:atp_completion_active_modes=deepcopy(g:atp_completion_modes)
endif
if !exists("g:atp_completion_active_modes_normal_mode") || g:atp_reload_variables
    let g:atp_completion_active_modes_normal_mode=deepcopy(g:atp_completion_modes_normal_mode)
endif

if !exists("g:atp_sort_completion_list") || g:atp_reload_variables
    let g:atp_sort_completion_list = 12
endif

" Note: to remove completions: 'inline_math' or 'displayed_math' one has to
" remove also: 'close_environments' /the function atplib#CloseLastEnvironment can
" close math instead of an environment/.

" ToDo: make list of complition commands from the input files.
" ToDo: make complition fot \cite, and for \ref and \eqref commands.

" ToDo: there is second such a list! line 3150
	let g:atp_Environments=['array', 'abstract', 'center', 'corollary', 
		\ 'definition', 'document', 'description', 'displaymath',
		\ 'enumerate', 'example', 'eqnarray', 
		\ 'flushright', 'flushleft', 'figure', 'frontmatter', 
		\ 'keywords', 
		\ 'itemize', 'lemma', 'list', 'letter', 'notation', 'minipage', 
		\ 'proof', 'proposition', 'picture', 'theorem', 'tikzpicture',  
		\ 'tabular', 'table', 'tabbing', 'thebibliography', 'titlepage',
		\ 'quotation', 'quote',
		\ 'remark', 'verbatim', 'verse', 'frame' ]

	let g:atp_amsmath_environments=['align', 'alignat', 'equation', 'gather',
		\ 'multline', 'split', 'substack', 'flalign', 'smallmatrix', 'subeqations',
		\ 'pmatrix', 'bmatrix', 'Bmatrix', 'vmatrix' ]

	" if short name is no_short_name or '' then both means to do not put
	" anything, also if there is no key it will not get a short name.
	let g:atp_shortname_dict = { 'theorem' : 'thm', 
		    \ 'proposition' 	: 'prop', 	'definition' 	: 'defi',
		    \ 'lemma' 		: 'lem',	'array' 	: 'ar',
		    \ 'abstract' 	: 'no_short_name',
		    \ 'tikzpicture' 	: 'tikz',	'tabular' 	: 'table',
		    \ 'table' 		: 'table', 	'proof' 	: 'pr',
		    \ 'corollary' 	: 'cor',	'enumerate' 	: 'enum',
		    \ 'example' 	: 'ex',		'itemize' 	: 'it',
		    \ 'item'		: 'itm',	'algorithmic'	: 'alg',
		    \ 'algorithm'	: 'alg',
		    \ 'remark' 		: 'rem',	'notation' 	: 'not',
		    \ 'center' 		: '', 		'flushright' 	: '',
		    \ 'flushleft' 	: '', 		'quotation' 	: 'quot',
		    \ 'quot' 		: 'quot',	'tabbing' 	: '',
		    \ 'picture' 	: 'pic',	'minipage' 	: '',	
		    \ 'list' 		: 'list',	'figure' 	: 'fig',
		    \ 'verbatim' 	: 'verb', 	'verse' 	: 'verse',
		    \ 'thebibliography' : '',		'document' 	: 'no_short_name',
		    \ 'titlepave' 	: '', 		'align' 	: 'eq',
		    \ 'alignat' 	: 'eq',		'equation' 	: 'eq',
		    \ 'gather'  	: 'eq', 	'multline' 	: 'eq',
		    \ 'split'		: 'eq', 	'substack' 	: '',
		    \ 'flalign' 	: 'eq',		'displaymath' 	: 'eq',
		    \ 'part'		: 'prt',	'chapter' 	: 'chap',
		    \ 'section' 	: 'sec',	'subsection' 	: 'ssec',
		    \ 'subsubsection' 	: 'sssec', 	'paragraph' 	: 'par',
		    \ 'subparagraph' 	: 'spar',	'subequations'	: 'eq' }

	" ToDo: Doc.
	" Usage: \label{l:shorn_env_name . g:atp_separator
	if !exists("g:atp_separator") || g:atp_reload_variables
	    let g:atp_separator=':'
	endif
	if !exists("g:atp_no_separator") || g:atp_reload_variables
	    let g:atp_no_separator = 0
	endif
	if !exists("g:atp_no_short_names") || g:atp_reload_variables
	    let g:atp_env_short_names = 1
	endif
	" the separator will not be put after the environments in this list:  
	" the empty string is on purpose: to not put separator when there is
	" no name.
	let g:atp_no_separator_list=['', 'titlepage']

" 	let g:atp_package_list=sort(['amsmath', 'amssymb', 'amsthm', 'amstex', 
" 	\ 'babel', 'booktabs', 'bookman', 'color', 'colorx', 'chancery', 'charter', 'courier',
" 	\ 'enumerate', 'euro', 'fancyhdr', 'fancyheadings', 'fontinst', 
" 	\ 'geometry', 'graphicx', 'graphics',
" 	\ 'hyperref', 'helvet', 'layout', 'longtable',
" 	\ 'newcent', 'nicefrac', 'ntheorem', 'palatino', 'stmaryrd', 'showkeys', 'tikz',
" 	\ 'qpalatin', 'qbookman', 'qcourier', 'qswiss', 'qtimes', 'verbatim', 'wasysym'])

	" the command \label is added at the end.
	let g:atp_Commands=["\\begin{", "\\end{", 
	\ "\\cite", "\\nocite{", "\\ref{", "\\pageref{", "\\eqref{", "\\item",
	\ "\\emph{", "\\documentclass{", "\\usepackage{",
	\ "\\section", "\\subsection", "\\subsubsection", "\\part", 
	\ "\\chapter", "\\appendix", "\\subparagraph", "\\paragraph",
	\ "\\textbf{", "\\textsf{", "\\textrm{", "\\textit{", "\\texttt{", 
	\ "\\textsc{", "\\textsl{", "\\textup{", "\\textnormal", "\\textcolor{",
	\ "\\bfseries", "\\mdseries", "\\bigskip", "\\bibitem",
	\ "\\tiny",  "\\scriptsize", "\\footnotesize", "\\small",
	\ "\\noindent", "\\normalfont", "\normalsize", "\\normalsize", "\\normal", 
	\ "\hfil", "\\hfill", "\\hspace","\\hline", 
	\ "\\large", "\\Large", "\\LARGE", "\\huge", "\\HUGE",
	\ "\\overline{", "\\underline{", 
	\ "\\usefont{", "\\fontsize{", "\\selectfont", "\\fontencoding{", "\\fontfamiliy{", "\\fontseries{", "\\fontshape{",
	\ "\\rmdefault", "\\sfdefault", "\\ttdefault", "\\bfdefault", "\\mddefault", "\\itdefault",
	\ "\\sldefault", "\\scdefault", "\\updefault",  "\\renewcommand{", "\\newcommand{",
	\ "\\input", "\\include", "\\includeonly", "\\includegraphics",  
	\ "\\savebox", "\\sbox", "\\usebox", "\\rule", "\\raisebox{", 
	\ "\\parbox{", "\\mbox{", "\\makebox{", "\\framebox{", "\\fbox{",
	\ "\\medskip", "\\smallskip", "\\vskip", "\\vfil", "\\vfill", "\\vspace{", "\\vbox",
	\ "\\hrulefill", "\\dotfill", "\\hbox",
	\ "\\thispagestyle{", "\\mathnormal", "\\markright{", "\\markleft{", "\\pagestyle{", "\\pagenumbering{",
	\ "\\author{", "\\address{", "\\date{", "\\thanks{", "\\title{",
	\ "\\maketitle",
	\ "\\marginpar", "\\indent", "\\par", "\\sloppy", "\\pagebreak", "\\nopagebreak",
	\ "\\newpage", "\\newline", "\\newtheorem{", "\\linebreak", "\\line", "\\linespread{",
	\ "\\hyphenation{", "\\fussy", "\\eject",
	\ "\\enlagrethispage{", "\\clearpage", "\\cleardoublepage",
	\ "\\caption{",
	\ "\\opening{", "\\name{", "\\makelabels{", "\\location{", "\\closing{", 
	\ "\\signature{", "\\stopbreaks", "\\startbreaks",
	\ "\\newcounter{", "\\refstepcounter{", 
	\ "\\roman{", "\\Roman{", "\\stepcounter{", "\\setcounter{", 
	\ "\\usecounter{", "\\value{", 
	\ "\\newlength{", "\\setlength{", "\\addtolength{", "\\settodepth{", "\\nointerlineskip", 
	\ "\\addcontentsline{", "\\addtocontents",
	\ "\\settoheight{", "\\settowidth{", "\\stretch{",
	\ "\\width", "\\height", "\\depth", "\\totalheight",
	\ "\\footnote{", "\\footnotemark", "\\footnotetetext", 
	\ "\\bibliography{", "\\bibliographystyle{", "\\baselineskip",
	\ "\\flushbottom", "\\onecolumn", "\\raggedbottom", "\\twocolumn",  
	\ "\\alph{", "\\Alph{", "\\arabic{", "\\fnsymbol{", "\\reversemarginpar",
	\ "\\exhyphenpenalty",
	\ "\\topmargin", "\\oddsidemargin", "\\evensidemargin", "\\headheight", "\\headsep", 
	\ "\\textwidth", "\\textheight", "\\marginparwidth", "\\marginparsep", "\\marginparpush", "\\footskip", "\\hoffset",
	\ "\\voffset", "\\paperwidth", "\\paperheight", "\\theequation", "\\thepage", "\\usetikzlibrary{",
	\ "\\tableofcontents", "\\newfont{", "\\phantom",
	\ "\\DeclareRobustCommand", "\\DeclareFixedFont", "\\DeclareMathSymbol", 
	\ "\\DeclareTextFontCommand", "\\DeclareMathVersion", "\\DeclareSymbolFontAlphabet",
	\ "\\DeclareMathDelimiter", "\\DeclareMathAccent", "\\DeclareMathRadical",
	\ "\\SetMathAlphabet", "\\show", "\\CheckCommand", "\\mathnormal",
	\ "\\pounds", "\\magstep{", "\\hyperlink", "\\newenvironment{", 
	\ "\\renewenvironemt{", "\\DeclareFixedFont", "\\layout", "\\parskip" ]
	
	let g:atp_picture_commands=[ "\\put", "\\circle", "\\dashbox", "\\frame{", 
		    \"\\framebox(", "\\line(", "\\linethickness{",
		    \ "\\makebox(", "\\\multiput(", "\\oval(", "\\put", 
		    \ "\\shortstack", "\\vector(" ]
	let g:atp_hyperref_commands=[ '\hypersetup{', '\hypertarget{', '\url{', '\nolinkurl{', '\hyperbaseurl{', 
		    \ '\hyperdef{', '\hyperref', '\hyperlink{', '\phantomsection', '\autoref{', '\autopageref{', 
		    \ '\ref*{', '\autoref*{', '\autopageref*{', '\pdfstringdef{', '\pdfbookmark', 
		    \ '\curretnpdfbookmark{', '\subpdfbookmark{', '\subpdfbookmark{', '\belowpdfbookmark{',
		    \ '\texorpdfstring{', '\hypercalcbp', '\Acrobatmenu{', 
		    \ '\textField', '\CheckBox', '\ChoiceMenu', '\PushButton', '\Submit', '\Reset',
		    \ '\LayoutTextField', '\LayoutChoiceField', '\LayoutCheckField', '\MakeRadioField{', 
		    \ '\MakeCheckField{', '\MakeTextField{', '\MakeChoiceField{', '\MakeButtonField{' ]
	" ToDo: end writting layout commands. 
	" ToDo: MAKE COMMANDS FOR PREAMBULE.

	let g:atp_math_commands=["\\forall", "\\exists", "\\emptyset", "\\aleph", "\\partial",
	\ "\\nabla", "\\Box", "\\bot", "\\top", "\\flat", "\\natural",
	\ "\\mathbf{", "\\mathsf{", "\\mathrm{", "\\mathit{", "\\mathtt{", "\\mathcal{", 
	\ "\\mathop{", "\\mathversion", "\\limits", "\\text{", "\\leqslant", "\\leq", "\\geqslant", "\\geq",
	\ "\\gtrsim", "\\lesssim", "\\gtrless", "\\left", "\\right", 
	\ "\\rightarrow", "\\Rightarrow", "\\leftarrow", "\\Leftarrow", "\\infty", "\\iff", 
	\ "\\oplus", "\\otimes", "\\odot", "\\oint",
	\ "\\leftrightarrow", "\\Leftrightarrow", "\\downarrow", "\\Downarrow", 
	\ "\\overline", "\\underline", "\\overbrace{", "\\Uparrow",
	\ "\\Longrightarrow", "\\longrightarrow", "\\Longleftarrow", "\\longleftarrow",
	\ "\\overrightarrow{", "\\overleftarrow{", "\\underrightarrow{", "\\underleftarrow{",
	\ "\\uparrow", "\\nearrow", "\\searrow", "\\swarrow", "\\nwarrow", "\\mapsto", "\\longmapsto",
	\ "\\hookrightarrow", "\\hookleftarrow", "\\gets", "\\to", "\\backslash", 
	\ "\\sum", "\\bigsum", "\\cup", "\\bigcup", "\\cap", "\\bigcap", 
	\ "\\prod", "\\coprod", "\\bigvee", "\\bigwedge", "\\wedge",  
	\ "\\int", "\\bigoplus", "\\bigotimes", "\\bigodot", "\\times",  
	\ "\\smile", "\\frown", 
	\ "\\dashv", "\\vdash", "\\vDash", "\\Vdash", "\\models", "\\sim", "\\simeq", 
	\ "\\prec", "\\preceq", "\\preccurlyeq", "\\precapprox", "\\mid",
	\ "\\succ", "\\succeq", "\\succcurlyeq", "\\succapprox", "\\approx", 
	\ "\\ldots", "\\cdot", "\\cdots", "\\vdots", "\\ddots", "\\circ", 
	\ "\\thickapprox", "\\cong", "\\bullet",
	\ "\\lhd", "\\unlhd", "\\rhd", "\\unrhd", "\\dagger", "\\ddager", "\\dag", "\\ddag", 
	\ "\\vartriangleright", "\\vartriangleleft", 
	\ "\\triangle", "\\triangledown", "\\trianglerighteq", "\\trianglelefteq",
	\ "\\copyright", "\\textregistered", "\\puonds",
	\ "\\big", "\\Big", "\\Bigg", "\\huge", 
	\ "\\bigr", "\\Bigr", "\\biggr", "\\Biggr",
	\ "\\bigl", "\\Bigl", "\\biggl", "\\Biggl", 
	\ "\\hat", "\\grave", "\\bar", "\\acute", "\\mathring", "\\check", 
	\ "\\dots", "\\dot", "\\vec", "\\breve",
	\ "\\tilde", "\\widetilde" , "\\widehat", "\\ddot", 
	\ "\\sqrt", "\\frac", "\\binom{", "\\cline", "\\vline", "\\hline", "\\multicolumn{", 
	\ "\\nouppercase", "\\sqsubseteq", "\\sqsubset", "\\sqsupseteq", "\\sqsupset", 
	\ "\\square", "\\blacksquare",  
	\ "\\nexists", "\\varnothing", "\\Bbbk", "\\circledS", 
	\ "\\complement", "\\hslash", "\\hbar", 
	\ "\\eth", "\\rightrightarrows", "\\leftleftarrows", "\\rightleftarrows", "\\leftrighrarrows", 
	\ "\\downdownarrows", "\\upuparrows", "\\rightarrowtail", "\\leftarrowtail", 
	\ "\\rightharpoondown", "\\rightharpoonup", "\\rightleftharpoons", "\\leftharpoondown", "\\leftharpoonup",
	\ "\\twoheadrightarrow", "\\twoheadleftarrow", "\\rceil", "\\lceil", "\\rfloor", "\\lfloor", 
	\ "\\bigtriangledown", "\\bigtriangleup", "\\ominus", "\\bigcirc", "\\amalg", "\\asymp",
	\ "\\vert", "\\Arrowvert", "\\arrowvert", "\\bracevert", "\\lmoustache", "\\rmoustache",
	\ "\\setminus", "\\sqcup", "\\sqcap", "\\bowtie", "\\owns", "\\oslash",
	\ "\\lnot", "\\notin", "\\neq", "\\smile", "\\frown", "\\equiv", "\\perp",
	\ "\\quad", "\\qquad", "\\stackrel", "\\displaystyle", "\\textstyle", "\\scriptstyle", "\\scriptscriptstyle",
	\ "\\langle", "\\rangle", "\\Diamond", "\\lgroup", "\\rgroup", "\\propto", "\\Join", "\\div", 
	\ "\\land", "\\star", "\\uplus", "\\leadsto", "\\rbrack", "\\lbrack", "\\mho", 
	\ "\\diamondsuit", "\\heartsuit", "\\clubsuit", "\\spadesuit", "\\top", "\\ell", 
	\ "\\imath", "\\jmath", "\\wp", "\\Im", "\\Re", "\\prime", "\\ll", "\\gg" ]

	let g:atp_math_commands_PRE=[ "\\diagdown", "\\diagup", "\\subset", "\\subseteq", "\\supset", "\\supsetneq",
		    \ "\\sharp", "\\underline", "\\underbrace{",  ]

	" commands defined by the user in input files.
	" ToDo: to doc.
	" ToDo: this doesn't work with input files well enough. 
	
	" Returns a list of two lists:  [ commanad_names, enironment_names ]

	" The BufEnter augroup doesn't work with EditInputFile, but at least it works
	" when entering. Debuging shows that when entering new buffer it uses
	" wrong b:atp_MainFile, it is still equal to the bufername and not the
	" real main file. Maybe it is better to use s:mainfile variable.

	if !exists("g:atp_local_completion") || g:atp_reload_variables
	    let g:atp_local_completion = 1
	endif


	let g:atp_math_commands_non_expert_mode=[ "\\leqq", "\\geqq", "\\succeqq", "\\preceqq", 
		    \ "\\subseteqq", "\\supseteqq", "\\gtrapprox", "\\lessapprox" ]
	 
	" requiers amssymb package:
	let g:atp_ams_negations=[ "\\nless", "\\ngtr", "\\lneq", "\\gneq", "\\nleq", "\\ngeq", "\\nleqslant", "\\ngeqslant", 
		    \ "\\nsim", "\\nconq", "\\nvdash", "\\nvDash", 
		    \ "\\nsubseteq", "\\nsupseteq", 
		    \ "\\varsubsetneq", "\\subsetneq", "\\varsupsetneq", "\\supsetneq", 
		    \ "\\ntriangleright", "\\ntriangleleft", "\\ntrianglerighteq", "\\ntrianglelefteq", 
		    \ "\\nrightarrow", "\\nleftarrow", "\\nRightarrow", "\\nLeftarrow", 
		    \ "\\nleftrightarrow", "\\nLeftrightarrow", "\\nsucc", "\\nprec", "\\npreceq", "\\nsucceq", 
		    \ "\\precneq", "\\succneq", "\\precnapprox", "\\ltimes", "\\rtimes" ]

	let g:atp_ams_negations_non_expert_mode=[ "\\lneqq", "\\ngeqq", "\\nleqq", "\\ngeqq", "\\nsubseteqq", 
		    \ "\\nsupseteqq", "\\subsetneqq", "\\supsetneqq", "\\nsucceqq", "\\precneqq", "\\succneqq" ] 

	" ToDo: add more amsmath commands.
	let g:atp_amsmath_commands=[ "\\boxed", "\\intertext", "\\multiligngap", "\\shoveleft{", "\\shoveright{", "\\notag", "\\tag", 
		    \ "\\notag", "\\raistag{", "\\displaybreak", "\\allowdisplaybreaks", "\\numberwithin{",
		    \ "\\hdotsfor{" , "\\mspace{",
		    \ "\\negthinspace", "\\negmedspace", "\\negthickspace", "\\thinspace", "\\medspace", "\\thickspace",
		    \ "\\leftroot{", "\\uproot{", "\\overset{", "\\underset{", "\\substack{", "\\sideset{", 
		    \ "\\dfrac", "\\tfrac", "\\cfrac", "\\dbinom{", "\\tbinom{", "\\smash",
		    \ "\\lvert", "\\rvert", "\\lVert", "\\rVert", "\\DeclareMatchOperator{",
		    \ "\\arccos", "\\arcsin", "\\arg", "\\cos", "\\cosh", "\\cot", "\\coth", "\\csc", "\\deg", "\\det",
		    \ "\\dim", "\\exp", "\\gcd", "\\hom", "\\inf", "\\injlim", "\\ker", "\\lg", "\\lim", "\\liminf", "\\limsup",
		    \ "\\log", "\\min", "\\max", "\\Pr", "\\projlim", "\\sec", "\\sin", "\\sinh", "\\sup", "\\tan", "\\tanh",
		    \ "\\varlimsup", "\\varliminf", "\\varinjlim", "\\varprojlim", "\\mod", "\\bmod", "\\pmod", "\\pod", "\\sideset",
		    \ "\\iint", "\\iiint", "\\iiiint", "\\idotsint", "\\tag",
		    \ "\\varGamma", "\\varDelta", "\\varTheta", "\\varLambda", "\\varXi", "\\varPi", "\\varSigma", 
		    \ "\\varUpsilon", "\\varPhi", "\\varPsi", "\\varOmega" ]
	
	" ToDo: integrate in TabCompletion (amsfonts, euscript packages).
	let g:atp_amsfonts=[ "\\mathbb{", "\\mathfrak{", "\\mathscr{" ]

	" not yet supported: in TabCompletion:
	let g:atp_amsextra_commands=[ "\\sphat", "\\sptilde" ]
	let g:atp_fancyhdr_commands=["\\lfoot{", "\\rfoot{", "\\rhead{", "\\lhead{", 
		    \ "\\cfoot{", "\\chead{", "\\fancyhead{", "\\fancyfoot{",
		    \ "\\fancypagestyle{", "\\fancyhf{}", "\\headrulewidth", "\\footrulewidth",
		    \ "\\rightmark", "\\leftmark", "\\markboth{", 
		    \ "\\chaptermark", "\\sectionmark", "\\subsectionmark",
		    \ "\\fancyheadoffset", "\\fancyfootoffset", "\\fancyhfoffset"]

	let g:atp_makeidx_commands=[ "\\makeindex", "\\index{", "\\printindex" ]


	" ToDo: remove tikzpicture from above and integrate the
	" tikz_envirnoments variable
	" \begin{pgfonlayer}{background} (complete the second argument as
	" well}
	"
	" Tikz command cuold be accitve only in tikzpicture and after \tikz
	" command! There is a way to do that.
	" 
	let g:atp_tikz_environments=['tikzpicture', 'scope', 'pgfonlayer', 'background' ]
	" ToDo: this should be completed as packages.
	let g:atp_tikz_libraries=sort(['arrows', 'automata', 'backgrounds', 'calc', 'calendar', 'chains', 'decorations', 
		    \ 'decorations.footprints', 'decorations.fractals', 
		    \ 'decorations.markings', 'decorations.pathmorphing', 
		    \ 'decorations.replacing', 'decorations.shapes', 
		    \ 'decorations.text', 'er', 'fadings', 'fit',
		    \ 'folding', 'matrix', 'mindmap', 'scopes', 
		    \ 'patterns', 'pteri', 'plothandlers', 'plotmarks', 
		    \ 'plcaments', 'pgflibrarypatterns', 'pgflibraryshapes',
		    \ 'pgflibraryplotmarks', 'positioning', 'replacements', 
		    \ 'shadows', 'shapes.arrows', 'shapes.callout', 'shapes.geometric', 
		    \ 'shapes.gates.logic.IEC', 'shapes.gates.logic.US', 'shapes.misc', 
		    \ 'shapes.multipart', 'shapes.symbols', 'topaths', 'through', 'trees' ])
	" tikz keywords = begin without '\'!
	" ToDo: add mote keywords: done until page 145.
	" ToDo: put them in a correct order!!!
	" ToDo: completion for arguments in brackets [] for tikz commands.
	let g:atp_tikz_commands=[ "\\begin", "\\end", "\\matrix", "\\node", "\\shadedraw", 
		    \ "\\draw", "\\tikz", "\\tikzset",
		    \ "\\path", "\\filldraw", "\\fill", "\\clip", "\\drawclip", "\\foreach", "\\angle", "\\coordinate",
		    \ "\\useasboundingbox", "\\tikztostart", "\\tikztotarget", "\\tikztonodes", "\\tikzlastnode",
		    \ "\\pgfextra", "\\endpgfextra", "\\verb", "\\coordinate", 
		    \ "\\pattern", "\\shade", "\\shadedraw", "\\colorlet", "\\definecolor",
		    \ "\\pgfmatrixnextcell" ]
	let g:atp_tikz_keywords=[ 'draw', 'node', 'matrix', 'anchor', 'top', 'bottom',  
		    \ 'west', 'east', 'north', 'south', 'at', 'thin', 'thick', 'semithick', 'rounded', 'corners',
		    \ 'controls', 'and', 'circle', 'step', 'grid', 'very', 'style', 'line', 'help',
		    \ 'color', 'arc', 'curve', 'scale', 'parabola', 'line', 'ellipse', 'bend', 'sin', 'rectangle', 'ultra', 
		    \ 'right', 'left', 'intersection', 'xshift', 'yshift', 'shift', 'near', 'start', 'above', 'below', 
		    \ 'end', 'sloped', 'coordinate', 'cap', 'shape', 'label', 'every', 
		    \ 'edge', 'point', 'loop', 'join', 'distance', 'sharp', 'rotate', 'blue', 'red', 'green', 'yellow', 
		    \ 'black', 'white', 'gray',
		    \ 'text', 'width', 'inner', 'sep', 'baseline', 'current', 'bounding', 'box', 
		    \ 'canvas', 'polar', 'radius', 'barycentric', 'angle', 'opacity', 
		    \ 'solid', 'phase', 'loosly', 'dashed', 'dotted' , 'densly', 
		    \ 'latex', 'diamond', 'double', 'smooth', 'cycle', 'coordinates', 'distance',
		    \ 'even', 'odd', 'rule', 'pattern', 
		    \ 'stars', 'shading', 'ball', 'axis', 'middle', 'outer', 'transorm',
		    \ 'fading', 'horizontal', 'vertical', 'light', 'dark', 'button', 'postaction', 'out',
		    \ 'circular', 'shadow', 'scope', 'borders', 'spreading', 'false', 'position', 'midway',
		    \ 'paint', 'from', 'to' ]
	let g:atp_tikz_library_arrows_keywords	= [ 'reversed', 'stealth', 'triangle', 'open', 
		    \ 'hooks', 'round', 'fast', 'cap', 'butt'] 
	let g:atp_tikz_library_automata_keywords=[ 'state', 'accepting', 'initial', 'swap', 
		    \ 'loop', 'nodepart', 'lower', 'upper', 'output']  
	let g:atp_tikz_library_backgrounds_keywords=[ 'background', 'show', 'inner', 'frame', 'framed',
		    \ 'tight', 'loose', 'xsep', 'ysep']

	let g:atp_tikz_library_calendar_commands=[ '\calendar', '\tikzmonthtext' ]
	let g:atp_tikz_library_calendar_keywords=[ 'week list', 'dates', 'day', 'day list', 'month', 'year', 'execute', 
		    \ 'before', 'after', 'downward', 'upward' ]
	let g:atp_tikz_library_chain_commands=[ '\chainin' ]
	let g:atp_tikz_library_chain_keywords=[ 'chain', 'start chain', 'on chain', 'continue chain', 
		    \ 'start branch', 'branch', 'going', 'numbers', 'greek' ]
	let g:atp_tikz_library_decorations_commands=[ '\\arrowreversed' ]
	let g:atp_tikz_library_decorations_keywords=[ 'decorate', 'decoration', 'lineto', 'straight', 'zigzag',
		    \ 'saw', 'random steps', 'bent', 'aspect', 'bumps', 'coil', 'curveto', 'snake', 
		    \ 'border', 'brace', 'segment lenght', 'waves', 'ticks', 'expanding', 
		    \ 'crosses', 'triangles', 'dart', 'shape', 'width', 'size', 'sep', 'shape backgrounds', 
		    \ 'between', 'along', 'path', 
		    \ 'Koch curve type 1', 'Koch curve type 1', 'Koch snowflake', 'Cantor set', 'footprints',
		    \ 'foot',  'stride lenght', 'foot', 'foot', 'foot of', 'gnome', 'human', 
		    \ 'bird', 'felis silvestris', 'evenly', 'spread', 'scaled', 'star', 'height', 'text',
		    \ 'mark', 'reset', 'marks' ]
	let g:atp_tikz_library_er_keywords	= [ 'entity', 'relationship', 'attribute', 'key']
	let g:atp_tikz_library_fadings_keywords	= [ 'with', 'fuzzy', 'percent', 'ring' ]
	let g:atp_tikz_library_fit_keywords	= [ 'fit']
	let g:atp_tikz_library_matrix_keywords	= ['matrix', 'of', 'nodes', 'math', 'matrix of math nodes', 
		    \ 'matrix of nodes', 'delimiter', 
		    \ 'rmoustache', 'column sep=', 'row sep=' ] 
	let g:atp_tikz_library_mindmap_keywords	= [ 'mindmap', 'concept', 'large', 'huge', 'extra', 'root', 'level',
		    \ 'connection', 'bar', 'switch', 'annotation' ]
	let g:atp_tikz_library_folding_commands	= ["\\tikzfoldingdodecahedron"]
	let g:atp_tikz_library_folding_keywords	= ['face', 'cut', 'fold'] 
        let g:atp_tikz_library_patterns_keywords	= ['lines', 'fivepointed', 'sixpointed', 'bricks', 'checkerboard',
		    \ 'crosshatch', 'dots']
	let g:atp_tikz_library_petri_commands	= ["\\tokennumber" ]
        let g:atp_tikz_library_petri_keywords	= ['place', 'transition', 'pre', 'post', 'token', 'child', 'children', 
		    \ 'are', 'tokens', 'colored', 'structured' ]
	let g:atp_tikz_library_pgfplothandlers_commands	= ["\\pgfplothandlercurveto", "\\pgfsetplottension",
		    \ "\\pgfplothandlerclosedcurve", "\\pgfplothandlerxcomb", "\\pgfplothandlerycomb",
		    \ "\\pgfplothandlerpolarcomb", "\\pgfplothandlermark{", "\\pgfsetplotmarkpeat{", 
		    \ "\\pgfsetplotmarkphase", "\\pgfplothandlermarklisted{", "\\pgfuseplotmark", 
		    \ "\\pgfsetplotmarksize{", "\\pgfplotmarksize" ]
        let g:atp_tikz_library_plotmarks_keywords	= [ 'asterisk', 'star', 'oplus', 'oplus*', 'otimes', 'otimes*', 
		    \ 'square', 'square*', 'triangle', 'triangle*', 'diamond*', 'pentagon', 'pentagon*']
	let g:atp_tikz_library_shadow_keywords 	= ['general shadow', 'shadow', 'drop shadow', 'copy shadow', 'glow' ]
	let g:atp_tikz_library_shapes_keywords 	= ['shape', 'center', 'base', 'mid', 'trapezium', 'semicircle', 'chord', 'regular polygon', 'corner', 'star', 'isoscales triangle', 'border', 'stretches', 'kite', 'vertex', 'side', 'dart', 'tip', 'tail', 'circular', 'sector', 'cylinder', 'minimum', 'height', 'width', 'aspect', 'uses', 'custom', 'body', 'forbidden sign', 'cloud', 'puffs', 'ignores', 'starburst', 'random', 'signal', 'pointer', 'tape', 
		    \ 'single', 'arrow', 'head', 'extend', 'indent', 'after', 'before', 'arrow box', 'shaft', 
		    \ 'lower', 'upper', 'split', 'empty', 'part', 
		    \ 'callout', 'relative', 'absolute', 'shorten',
		    \ 'logic gate', 'gate', 'inputs', 'inverted', 'radius', 'use', 'US style', 'CDH style', 'nand', 'and', 'or', 'nor', 'xor', 'xnor', 'not', 'buffer', 'IEC symbol', 'symbol', 'align', 
		    \ 'cross out', 'strike out', 'length', 'chamfered rectangle' ]
	let g:atp_tikz_library_topath_keywords	= ['line to', 'curve to', 'out', 'in', 'relative', 'bend', 'looseness', 'min', 'max', 'control', 'loop']
	let g:atp_tikz_library_through_keywords	= ['through']
	let g:atp_tikz_library_trees_keywords	= ['grow', 'via', 'three', 'points', 'two', 'child', 'children', 'sibling', 'clockwise', 'counterclockwise', 'edge', 'parent', 'fork'] 

	" BEAMER
	let g:atp_BeamerEnvironments = ["frame", "beamercolorbox", "onlyenv", "altenv", 
		    \ "visibleenv", "uncoverenv", "invisibleenv", "overlayarea", "overprint", "actionenv",
		    \ 'description', 'structureenv', 'alertenv', 'block', 'alertblock', 'exampleblock', 'beamercolorbox',
		    \ 'beamerboxesrounded', 'columns', 'semiverbatim' ]

	let g:atp_BeamerCommands = ["\\alert{", "\\frametitle{", "\\framesubtitle", "\\titlepage", "\\setbeamercolor{", 
		    \ "\\pause", "\\onslide", "\\only", "\\uncover", "\\visible", "\\invisible", "\\temporal", "\\alt",
		    \ "\\usebeamercolor{", "\\usetheme{", "\\includeonlyframes{", "\\againframe", "\\setbeamersize{",
		    \ "\\action{", "\\inserttocsection", "\\inserttocsectionumber", "\\lecture", "\\AtBeginLecture{",
		    \ "\\appendix", "\\hypertarget", "\\beamerbutton", "\\beamerskipbutton", "\\beamerreturnbutton", 
		    \ "\\beamergotobutton", '\hyperlinkslideprev', '\hyperlinkslidenext', '\hyperlinkframestart', 
		    \ '\hyperlinkframeend', '\hyperlinkframestartnext', '\hyperlinkframeendprev', 
		    \ '\hyperlinkpresentationstart', '\hyperlinkpresentationend', '\hyperlinkappendixstart', 
		    \  '\hyperlinkappendixend', '\hyperlinkdocumentstart',  '\hyperlinkdocumentend',
		    \ '\framezoom', '\structure', '\insertblocktitle', '\column', '\movie', '\animate', 
		    \ '\hyperlinksound', '\hyperlinkmute',
		    \ '\usetheme', '\usecolortheme', '\usefonttheme', '\useinnertheme', '\useoutertheme',
		    \ '\usefonttheme', '\note', '\AtBeginNote', '\AtEndNote', '\setbeameroption{',
		    \ '\setbeamerfont{', '\mode' ]

	let g:atp_BeamerThemes = [ "default", "boxes", "Bergen", "Boadilla", "Madrid", "AnnArbor", 
		    \ "CambridgeUS", "Pittsburgh", "Rochester", "Antibes", "JuanLesPins", "Montpellier", 
		    \ "Berkeley" , "PalAlto", "Gottingen", "Marburg", "Hannover", "Berlin", "Ilmenau", 
		    \ "Dresden", "Darmstadt", "Frankfurt", "Singapore", "Szeged", "Copenhagen", "Luebeck", "Malmoe", 
		    \ "Warsaw", ]
	let g:atp_BeamerInnerThemes = [ "default", "circles", "rectangles", "rounded", "inmargin" ]
	let g:atp_BeamerOuterThemes = [ "default", "infolines", "miniframes", "smoothbars", "sidebar",
		    \ "split", "shadow", "tree", "smoothtree" ]
	let g:atp_BeamerColorThemes = [ "default", "structure", "sidebartab", "albatross", "beetle", "crane", 
		    \ "dove", "fly", "seagull", "wolverine", "beaver", "lily", "orchid", "rose", "whale", "seahorse", 
		    \ "dolphin" ]
	let g:atp_BeamerFontThemes = [ "default", "serif", "structurebold", "structureitalicserif",
		    \ "structuresmallcapsserif" ]

	let g:atp_MathTools_math_commands = [ '\cramped', '\crampedllap', '\crampedclap', '\crampedrlap', '\smashoperator',
		    \ '\adjustlimits', '\newtagform{', '\usetagform{', '\renewtagform{', 
		    \ '\xleftrightarrow', '\xRightarrow', '\xLeftarrow', '\xLeftrightarrow', 
		    \ '\xhookleftarrow', '\xhookrightarrow', '\xmapsto', '\underbracket', '\overbracket',
		    \ '\LaTeXunderbrace', '\LaTeXoverbrace', '\Aboxed', '\ArrowBetweenLines', '\ArrowBetweenLines*',
		    \ '\shortintertext', '\lparen', '\rparen', '\vcentcolon', 
		    \ '\ordinarycolon', '\mathtoolsset{', '\prescript',
		    \ '\newgathered', '\renewgathered', '\splitfrac{', '\splitdfrac{' ]
	let g:atp_MathTools_commands = [ '\DeclarePairedDelimiter{', '\DeclarePairedDelimiterX{' ]

	let g:atp_MathTools_environments = [ 'matrix*', 'pmatrix*', 'bmatrix*', 'Bmatrix*', 'vmatrix*', 'Vmatrix*', 
		    \ 'multilined', 'dcases', 'dcases*', 'rcases', 'rcases*', 'drcases*', 'cases*', 'spreadlines',
		    \ 'lgathered', 'rgathered' ]

	let g:atp_TodoNotes_commands = [ '\todo{', '\listoftodos', '\missingfigure' ] 
	let g:atp_TodoNotes_todo_options = 
		    \ [ 'disable', 'color=', 'backgroundcolor=', 'linecolor=', 'bordercolor=', 
		    \ 'line', 'noline', 'inline', 'noinline', 'size=', 'list', 'nolist', 
		    \ 'caption=', 'prepend', 'noprepend', 'fancyline' ]   
	"Todo: PackageOptions are not yet done.  
	let g:atp_TodoNotes_packageOptions = [ 'textwidth', 'textsize', 
			    \ 'prependcaption', 'shadow', 'dvistyle', 'figwidth', 'obeyDraft' ]

	let g:atp_TodoNotes_missingfigure_options = [ 'figwidth=' ]
if !exists("g:atp_MathOpened") || g:atp_reload_variables
    let g:atp_MathOpened = 1
endif
" augroup ATP_MathOpened
"     au!
"     au Syntax tex :let g:atp_MathOpened = 1
" augroup END

let g:atp_math_modes=[ ['\%([^\\]\|^\)\%(\\\|\\\{3}\)(','\%([^\\]\|^\)\%(\\\|\\\{3}\)\zs)'],
	    \ ['\%([^\\]\|^\)\%(\\\|\\\{3}\)\[','\%([^\\]\|^\)\%(\\\|\\\{3}\)\zs\]'],	
	    \ ['\\begin{align', '\\end{alig\zsn'], 	['\\begin{gather', '\\end{gathe\zsr'], 
	    \ ['\\begin{falign', '\\end{flagi\zsn'], 	['\\begin[multline', '\\end{multlin\zse'],
	    \ ['\\begin{equation', '\\end{equatio\zsn'],
	    \ ['\\begin{\%(display\)\?math', '\\end{\%(display\)\?mat\zsh'] ] 

" Completion variables for \pagestyle{} and \thispagestyle{} LaTeX commands.
let g:atp_pagestyles = [ 'plain', 'headings', 'empty', 'myheadings' ]
let g:atp_fancyhdr_pagestyles = [ 'fancy' ]

" Completion variable for \pagenumbering{} LaTeX command.
let g:atp_pagenumbering = [ 'arabic', 'roman', 'Roman', 'alph', 'Alph' ]
" }}}
"

" AUTOCOMMANDS:
" Some of the autocommands (Status Line, LocalCommands, Log File):
" {{{ Autocommands:


if !s:did_options

    let g:atp_eventignore		= &l:eventignore
    let g:atp_eventignoreInsertEnter 	= 0
    function! <SID>InsertLeave_InsertEnter()
	if g:atp_eventignoreInsertEnter
	    setl eventignore-=g:atp_eventignore
	endif
    endfunction
    augroup ATP_InsertLeave_eventignore
	" ToggleMathIMaps
	au!
	au InsertLeave *.tex 	:call <SID>InsertLeave_InsertEnter()
    augroup END

    augroup ATP_Cmdwin
	au!
	au CmdwinLeave / :call ATP_CmdwinToggleSpace(0)
	au CmdwinLeave ? :call ATP_CmdwinToggleSpace(0)
    augroup END

    augroup ATP_cmdheight
	" update g:atp_cmdheight when user writes the buffer
	au!
	au BufWrite *.tex :let g:atp_cmdheight = &l:cmdheight
    augroup END

function! <SID>Rmdir(dir)
if executable("rmdir")
    call system("rmdir ".shellescape(a:dir))
elseif has("python") && executable(g:atp_Python)
python << EOF
import shutil, errno
dir=vim.eval('a:dir')
try:
	shutil.rmtree(dir)
except OSError, e:
	if errno.errorcode[e.errno] == 'ENOENT':
		pass
EOF
else
    echohl ErrorMsg
    echo "[ATP:] the directory ".a:dir." is not removed."
    echohl Normal
endif
endfunction

    function! ErrorMsg(type)
	let errors		= len(filter(getqflist(),"v:val['type']==a:type"))
	let type		= (a:type == 'E' ? 'errors' : 'warnnings')
	let msg			= ""
	if errors
	    let msg.=" ".errors." ".type
	endif
	return msg
    endfunction

    augroup ATP_QuickFix_2
	au!
	au FileType qf command! -bang -buffer -nargs=? -complete=custom,DebugComp DebugMode	:call <SID>SetDebugMode(<q-bang>,<f-args>)
	au FileType qf let w:atp_qf_errorfile=&l:errorfile
	au FileType qf setl statusline=%{w:atp_qf_errorfile}%=\ %#WarnningMsg#%{ErrorMsg('W')}\ %#ErrorMsg#%{ErrorMsg('E')}
	"There are %{len(getqflist())} messages"
	au FileType qf "resize ".min([atplib#qflength(), g:atp_DebugModeQuickFixHeight])
" 	THIS IS NOT WORKING this might be considered as a vim bug.
" 	when there are two files it loads the errors from the window which we leave
" 	rather than we get into.
" 	au WinEnter *.tex cgetfile
    augroup END

    function! <SID>BufEnterCgetfile()
	if g:atp_cgetfile 
	    try
		cgetfile
		" cgetfile needs:
		exe "ErrorFormat ".b:atp_ErrorFormat
	    catch /E40:/ 
	    endtry
	endif
    endfunction
    augroup ATP_QuickFix_cgetfile
	au!
	au BufEnter *.tex :call <SID>BufEnterCgetfile()
    augroup END

    augroup ATP_VimLeave
	au!
	" Remove b:atp_TempDir (where compelation is done).
	au VimLeave *.tex :call <SID>Rmdir(b:atp_TempDir)
	" Remove TempDir for debug files.
	au VimLeave *.tex :call <SID>RmTempDir()
	" :Kill! (i.e. silently if there is no python support.)
	au VimLeave *.tex :Kill!
    augroup END

    function! <SID>UpdateTime(enter)
	if a:enter	== "Enter" && g:atp_updatetime_insert != 0
	    let &l:updatetime	= g:atp_updatetime_insert
	elseif a:enter 	== "Leave" && g:atp_updatetime_normal != 0
	    let &l:updatetime	= g:atp_updatetime_normal
	endif
    endfunction

    augroup ATP_UpdateTime
	au!
	au InsertEnter *.tex :call <SID>UpdateTime("Enter")
	au InsertLeave *.tex :call <SID>UpdateTime("Leave")
    augroup END

    if (exists("g:atp_statusline") && g:atp_statusline == '1') || !exists("g:atp_statusline")
	augroup ATP_Status
	    au!
	    au BufWinEnter *.tex 	call ATPStatus("")
	augroup END
    endif

    if g:atp_local_completion == 2 
	augroup ATP_LocaCommands
	    au!
	    au BufEnter *.tex 	call LocalCommands()
	augroup END
    endif

    augroup ATP_TeXFlavor
	au!
	au FileType *tex 	let b:atp_TexFlavor = &filetype
    augroup END

    " Idea:
    " au 		*.log if LogBufferFileDiffer | silent execute '%g/^\s*$/d' | w! | endif
    " or maybe it is better to do that after latex made the log file in the call back
    " function, but this adds something to every compilation process !
    " This changes the cursor position in the log file which is NOT GOOD.
"     au WinEnter	*.log	execute "normal m'" | silent execute '%g/^\s*$/d' | execute "normal ''"

    " Experimental:
	" This doesn't work !
" 	    fun! GetSynStackI()
" 		let synstack=[]
" 		let synstackI=synstack(line("."), col("."))
" 		try 
" 		    let test =  synstackI == 0
" 		    let b:return 	= 1
" 		    catch /Can only compare List with List/
" 		    let b:return	= 0
" 		endtry
" 		if b:return == 0
" 		    return []
" 		else
" 		    return map(synstack, "synIDattr(v:val, 'name')")
" 		endif
" 	    endfunction

    " The first one is not working! (which is the more important of these two :(
"     au CursorMovedI *.tex let g:atp_synstackI	= GetSynStackI()
    " This has problems in visual mode:
"     au CursorMoved  *.tex let g:atp_synstack	= map(synstack(line('.'), col('.')), "synIDattr(v:val, 'name')")
    
endif
" }}}

" This function and the following autocommand toggles the textwidth option if
" editing a math mode. Currently, supported are $:$, \(:\), \[:\] and $$:$$.
" {{{  SetMathVimOptions

if !exists("g:atp_SetMathVimOptions") || g:atp_reload_variables
    let g:atp_SetMathVimOptions 	= 1
endif

if !exists("g:atp_MathVimOptions") || g:atp_reload_variables
"     { 'option_name' : [ val_in_math, normal_val], ... }
    let g:atp_MathVimOptions 		=  { 'textwidth' 	: [ 0, 	&textwidth],
						\ }
endif

if !exists("g:atp_MathZones") || g:atp_reload_variables
let g:atp_MathZones	= ( &l:filetype == "tex" ? [ 
	    		\ 'texMathZoneV', 	'texMathZoneW', 
	    		\ 'texMathZoneX', 	'texMathZoneY',
	    		\ 'texMathZoneA', 	'texMathZoneAS',
	    		\ 'texMathZoneB', 	'texMathZoneBS',
	    		\ 'texMathZoneC', 	'texMathZoneCS',
	    		\ 'texMathZoneD', 	'texMathZoneDS',
	    		\ 'texMathZoneE', 	'texMathZoneES',
	    		\ 'texMathZoneF', 	'texMathZoneFS',
	    		\ 'texMathZoneG', 	'texMathZoneGS',
	    		\ 'texMathZoneH', 	'texMathZoneHS',
	    		\ 'texMathZoneI', 	'texMathZoneIS',
	    		\ 'texMathZoneJ', 	'texMathZoneJS',
	    		\ 'texMathZoneK', 	'texMathZoneKS',
	    		\ 'texMathZoneL', 	'texMathZoneLS',
			\ 'texMathZoneT'
			\ ]
			\ : [ 'plaintexMath' ] )
endif

" a:0 	= 0 check if in math mode
" a:1   = 0 assume cursor is not in math
" a:1	= 1 assume cursor stands in math  
function! s:SetMathVimOptions(...)

	if !g:atp_SetMathVimOptions
	    return "no setting to toggle" 
	endif

	let MathZones = copy(g:atp_MathZones)
	if b:atp_TexFlavor == 'plaintex'
	    call add(MathZones, 'texMathZoneY')
	endif
	    
	" Change the long values to numbers 
	let MathVimOptions = map(copy(g:atp_MathVimOptions),
			\ " v:val[0] =~ v:key ? [ v:val[0] =~ '^no' . v:key ? 0 : 1, v:val[1] ] : v:val " )
	let MathVimOptions = map(MathVimOptions,
			\ " v:val[1] =~ v:key ? [ v:val[0], v:val[1] =~ '^no' . v:key ? 0 : 1 ] : v:val " )

	" check if the current (and 3 steps back) cursor position is in math
	" or use a:1
	let check	= a:0 == 0 ? atplib#CheckSyntaxGroups(MathZones) + atplib#CheckSyntaxGroups(MathZones, line("."), max([ 1, col(".")-3])) : a:1

	if check
	    for option_name in keys(MathVimOptions)
		execute "let &l:".option_name. " = " . MathVimOptions[option_name][0]
	    endfor
	else
	    for option_name in keys(MathVimOptions)
		execute "let &l:".option_name. " = " . MathVimOptions[option_name][1]
	    endfor
	endif

endfunction

if !s:did_options

    augroup ATP_SetMathVimOptions
	au!
	" if leaving the insert mode set the non-math options
	au InsertLeave 	*.tex 	:call s:SetMathVimOptions(0)
	" if entering the insert mode or in the insert mode check if the cursor is in
	" math or not and set the options acrodingly
	au InsertEnter	*.tex 	:call s:SetMathVimOptions()
	au CursorMovedI *.tex 	:call s:SetMathVimOptions()
	" This slows down vim when moving the cursor:
	" au CursorMoved *.tex :call s:SetMathVimOptions()
    augroup END

endif
"}}}

" Add extra syntax groups
" {{{1 ATP_SyntaxGroups
function! s:ATP_SyntaxGroups()
    " add texMathZoneT syntax group for tikzpicture environment:
    if atplib#SearchPackage('tikz') || atplib#SearchPackage('pgfplots')
	try
	    call TexNewMathZone("T", "tikzpicture", 0)
	catch /E117:/
	endtry
    endif
    " add texMathZoneALG syntax group for algorithmic environment:
    if atplib#SearchPackage('algorithmic')
	try
	    call TexNewMathZone("ALG", "algorithmic", 0)
	catch /E117:/ 
	endtry
    endif
endfunction

augroup ATP_AddSyntaxGroups
    au Syntax tex :call <SID>ATP_SyntaxGroups()
augroup END

augroup ATP_Devel
    au BufEnter *.sty	:setl nospell	
    au BufEnter *.cls	:setl nospell
    au BufEnter *.fd	:setl nospell
augroup END
"}}}1

"{{{1 Highlightings in help file
augroup ATP_HelpFile_Highlight
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_FileName') ? "atp_FileName" : "Title",  'highlight atp_FileName\s\+Title')
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_LineNr') 	? "atp_LineNr"   : "LineNr", 'highlight atp_LineNr\s\+LineNr')
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_Number') 	? "atp_Number"   : "Number", 'highlight atp_Number\s\+Number')
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_Chapter') 	? "atp_Chapter"  : "Label",  'highlight atp_Chapter\s\+Label')
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_Section') 	? "atp_Section"  : "Label",  'highlight atp_Section\s\+Label')
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_SubSection') ? "atp_SubSection": "Label", 'highlight atp_SubSection\s\+Label')
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_Abstract')	? "atp_Abstract" : "Label", 'highlight atp_Abstract\s\+Label')

au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_label_FileName') 	? "atp_label_FileName" 	: "Title",	'^\s*highlight atp_label_FileName\s\+Title\s*$')
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_label_LineNr') 	? "atp_label_LineNr" 	: "LineNr",	'^\s*highlight atp_label_LineNr\s\+LineNr\s*$')
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_label_Name') 	? "atp_label_Name" 	: "Label",	'^\s*highlight atp_label_Name\s\+Label\s*$')
au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('atp_label_Counter') 	? "atp_label_Counter" 	: "Keyword",	'^\s*highlight atp_label_Counter\s\+Keyword\s*$')

au BufEnter automatic-tex-plugin.txt call matchadd(hlexists('bibsearchInfo')	? "bibsearchInfo"	: "Number",	'^\s*highlight bibsearchInfo\s*$')
augroup END
"}}}1

" {{{1 :Viewer, :Compiler, :DebugMode
function! <SID>Viewer(...) 
    if a:0 == 0 || a:1 =~ '^\s*$'
	echomsg "[ATP:] current viewer: ".b:atp_Viewer
	return
    else
	let new_viewer = a:1
    endif
    let old_viewer	= b:atp_Viewer
    let oldViewer	= get(g:ViewerMsg_Dict, matchstr(old_viewer, '^\s*\zs\S*'), "")
    let b:atp_Viewer	= new_viewer
    let Viewer		= get(g:ViewerMsg_Dict, matchstr(b:atp_Viewer, '^\s*\zs\S*'), "")
    silent! execute "aunmenu LaTeX.View\\ with\\ ".oldViewer
    silent! execute "aunmenu LaTeX.View\\ Output"
    if Viewer != ""
	execute "menu 550.10 LaTe&X.&View\\ with\\ ".Viewer."<Tab>:ViewOutput 		:<C-U>ViewOutput<CR>"
	execute "cmenu 550.10 LaTe&X.&View\\ with\\ ".Viewer."<Tab>:ViewOutput 		<C-U>ViewOutput<CR>"
	execute "imenu 550.10 LaTe&X.&View\\ with\\ ".Viewer."<Tab>:ViewOutput 		<Esc>:ViewOutput<CR>a"
    else
	execute "menu 550.10 LaTe&X.&View\\ Output\\ <Tab>:ViewOutput 		:<C-U>ViewOutput<CR>"
	execute "cmenu 550.10 LaTe&X.&View\\ Output\\ <Tab>:ViewOutput 		<C-U>ViewOutput<CR>"
	execute "imenu 550.10 LaTe&X.&View\\ Output\\ <Tab>:ViewOutput 		<Esc>:ViewOutput<CR>a"
    endif
endfunction
command! -buffer -nargs=? -complete=customlist,ViewerComp Viewer	:call <SID>Viewer(<q-args>)
function! ViewerComp(A,L,P)
    let view = [ 'okular', 'xpdf', 'xdvi', 'evince', 'epdfview', 'kpdf', 'acroread', 'zathura', 'gv',
		\  'AcroRd32.exe', 'sumatrapdf.exe' ]
    " The names of Windows programs (second line) might be not right [sumatrapdf.exe (?)].
    call filter(view, "v:val =~ '^' . a:A")
    call filter(view, 'executable(v:val)')
    return view
endfunction

function! <SID>Compiler(...) 
    if a:0 == 0
	echo "[ATP:] b:atp_TexCompiler=".b:atp_TexCompiler
	return
    else
	let compiler		= a:1
	let old_compiler	= b:atp_TexCompiler
	let oldCompiler	= get(g:CompilerMsg_Dict, matchstr(old_compiler, '^\s*\zs\S*'), "")
	let b:atp_TexCompiler	= compiler
	let Compiler		= get(g:CompilerMsg_Dict, matchstr(b:atp_TexCompiler, '^\s*\zs\S*'), "")
	silent! execute "aunmenu LaTeX.".oldCompiler
	silent! execute "aunmenu LaTeX.".oldCompiler."\\ debug"
	silent! execute "aunmenu LaTeX.".oldCompiler."\\ twice"
	execute "menu 550.5 LaTe&X.&".Compiler."<Tab>:TEX				:<C-U>TEX<CR>"
	execute "cmenu 550.5 LaTe&X.&".Compiler."<Tab>:TEX				<C-U>TEX<CR>"
	execute "imenu 550.5 LaTe&X.&".Compiler."<Tab>:TEX				<Esc>:TEX<CR>a"
	execute "menu 550.6 LaTe&X.".Compiler."\\ debug<Tab>:TEX\\ debug		:<C-U>DTEX<CR>"
	execute "cmenu 550.6 LaTe&X.".Compiler."\\ debug<Tab>:TEX\\ debug		<C-U>DTEX<CR>"
	execute "imenu 550.6 LaTe&X.".Compiler."\\ debug<Tab>:TEX\\ debug		<Esc>:DTEX<CR>a"
	execute "menu 550.7 LaTe&X.".Compiler."\\ &twice<Tab>:2TEX			:<C-U>2TEX<CR>"
	execute "cmenu 550.7 LaTe&X.".Compiler."\\ &twice<Tab>:2TEX			<C-U>2TEX<CR>"
	execute "imenu 550.7 LaTe&X.".Compiler."\\ &twice<Tab>:2TEX			<Esc>:2TEX<CR>a"
    endif
endfunction
command! -buffer -nargs=? -complete=customlist,CompilerComp Compiler	:call <SID>Compiler(<f-args>)
function! CompilerComp(A,L,P)
    let compilers = [ 'tex', 'pdftex', 'latex', 'pdflatex', 'etex', 'xetex', 'luatex', 'xelatex' ]
"     let g:compilers = copy(compilers)
    call filter(compilers, "v:val =~ '^' . a:A")
    call filter(compilers, 'executable(v:val)')
    return compilers
endfunction

function! <SID>SetDebugMode(bang,...)
    if a:0 == 0
	echo t:atp_DebugMode
	return
    else
	if a:1 =~# '^s\%[silent]'
	    let t:atp_DebugMode= 'silent'
	elseif a:1 =~# '^d\%[debug]'
	    let t:atp_DebugMode= 'debug'
	elseif a:1 =~# '^D\%[debug]'
	    let t:atp_DebugMode= 'Debug'
	elseif a:1 =~# '^v\%[erbose]'
	    let t:atp_DebugMode= 'verbose'
	else
	    let t:atp_DebugMode= g:atp_DefaultDebugMode
	endif
    endif

    if t:atp_DebugMode ==# 'Debug' && a:1 ==# 'debug' || t:atp_DebugMode ==# 'debug' && a:1 ==# 'Debug'
	let change_menu 	= 0
    else
	let change_menu 	= 1
    endif

    "{{{ Change menu
    if change_menu && t:atp_DebugMode !=? 'debug'
	silent! aunmenu 550.20.5 LaTeX.Log.Toggle\ &Debug\ Mode\ [on]
	silent! aunmenu 550.20.5 LaTeX.Log.Toggle\ &Debug\ Mode\ [off]
	menu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [off]<Tab>ToggleDebugMode
		    \ :<C-U>ToggleDebugMode<CR>
	cmenu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [off]<Tab>ToggleDebugMode
		    \ <C-U>ToggleDebugMode<CR>
	imenu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [off]<Tab>ToggleDebugMode
		    \ <Esc>:ToggleDebugMode<CR>a

	silent! aunmenu LaTeX.Toggle\ Call\ Back\ [on]
	silent! aunmenu LaTeX.Toggle\ Call\ Back\ [off]
	menu 550.80 &LaTeX.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	
		    \ :<C-U>ToggleDebugMode<CR>
	cmenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	
		    \ <C-U>ToggleDebugMode<CR>
	imenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	
		    \ <Esc>:ToggleDebugMode<CR>a
    elseif change_menu
	silent! aunmenu 550.20.5 LaTeX.Log.Toggle\ Debug\ Mode\ [off]
	silent! aunmenu 550.20.5 LaTeX.Log.Toggle\ &Debug\ Mode\ [on]
	menu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [on]<Tab>ToggleDebugMode
		    \ :<C-U>ToggleDebugMode<CR>
	cmenu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [on]<Tab>ToggleDebugMode
		    \ <C-U>ToggleDebugMode<CR>
	imenu 550.20.5 &LaTeX.&Log.Toggle\ &Debug\ Mode\ [on]<Tab>ToggleDebugMode
		    \ <Esc>:ToggleDebugMode<CR>a

	silent! aunmenu LaTeX.Toggle\ Call\ Back\ [on]
	silent! aunmenu LaTeX.Toggle\ Call\ Back\ [off]
	menu 550.80 &LaTeX.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback	
		    \ :<C-U>ToggleDebugMode<CR>
	cmenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback	
		    \ <C-U>ToggleDebugMode<CR>
	imenu 550.80 &LaTeX.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback	
		    \ <Esc>:ToggleDebugMode<CR>a
    endif "}}}

    if a:1 =~# 's\%[ilent]'
	let winnr=winnr()
	if t:atp_QuickFixOpen
	    cclose
	else
	    try
		cgetfile
	    catch /E40/
		echohl WarningMsg 
		echo "[ATP:] log file missing."
		echohl Normal
	    endtry
	    if a:bang == "!"
		exe "cwindow " . (max([1, min([len(getqflist()), g:atp_DebugModeQuickFixHeight])]))
		exe winnr . "wincmd w"
	    endif
	endif
    elseif a:1 =~# 'd\%[ebug]'
	let winnr=winnr()
	exe "copen " . (!exists("w:quickfix_title") 
		    \ ? (max([1, min([atplib#qflength(), g:atp_DebugModeQuickFixHeight])]))
		    \ : "" )
	exe winnr . "wincmd w"
	try
	    cgetfile
	catch /E40/
	    echohl WarningMsg 
	    echo "[ATP:] log file missing."
	    echohl Normal
	endtry
	" DebugMode is not changing when log file is missing!
    elseif a:1 =~# 'D\%[ebug]'
	let winnr=winnr()
	exe "copen " . (!exists("w:quickfix_title") 
		    \ ? (max([1, min([atplib#qflength(), g:atp_DebugModeQuickFixHeight])]))
		    \ : "" )
	exe winnr . "wincmd w"
	try
	    cgetfile
	catch /E40/
	    echohl WarningMsg 
	    echo "[ATP:] log file missing."
	    echohl Normal
	endtry
	try 
	    cc
	catch E42:
	    echo "[ATP:] no errors."
	endtry
    endif
endfunction
command! -buffer -bang -nargs=? -complete=custom,DebugComp DebugMode	:call <SID>SetDebugMode(<q-bang>,<f-args>)
function! DebugComp(A,L,P)
    return "silent\ndebug\nDebug\nverbose"
endfunction
"}}}1

" Python test if libraries are present
" {{{
function! <SID>TestPythonLibs()
python << END
import vim
try:
    import psutil
except ImportError:
    vim.command('echohl ErrorMsg|echomsg "[ATP:] needs psutil python library."')
    vim.command('echomsg "You can get it from: http://code.google.com/p/psutil/"')
    test=vim.eval("has('mac')||has('macunix')||has('unix')")
    if test != str(0):
	vim.command('echomsg "Falling back to bash"')
	vim.command("let g:atp_Compiler='bash'")
    vim.command("echohl Normal")
    vim.command("echomsg \"If you don't want to see this message (and you are on *nix system)\"") 
    vim.command("echomsg \"put let g:atp_Compiler='bash' in your vimrc or atprc file.\"")
    vim.command("sleep 2")
END
endfunction

if g:atp_Compiler == "python"
    if !executable(g:atp_Python) || !has("python")
	echohl ErrorMsg
	echomsg "[ATP:] needs: python and python support in vim."
	echohl Normal
	if has("mac") || has("macunix") || has("unix")
	    echohl ErrorMsg
	    echomsg "I'm falling back to bash (deprecated)."
	    echohl Normal
	    let g:atp_Compiler = "bash"
	    echomsg "If you don't want to see this message"
	    echomsg "put let g:atp_Compiler='bash' in your vimrc or atprc file."
	    if !has("python")
		echomsg "You Vim is compiled without pyhon support, some tools might not work."
	    endif
	    sleep 2
	endif
    else
	call <SID>TestPythonLibs()
    endif
endif
" }}}

"Make g:atp_TempDir, where log files are stored.
"{{{
function! <SID>TempDir() 
    " Return temporary directory, unique for each user.
if has("python")
function! ATP_SetTempDir(tmp)
    let g:atp_TempDir=a:tmp
endfunction
python << END
import tempfile, os
USER=os.getenv("USER")
tmp=tempfile.mkdtemp(suffix="", prefix="atp_")
vim.eval("ATP_SetTempDir('"+tmp+"')")
END
delfunction ATP_SetTempDir
else
    let g:atp_TempDir=substitute(tempname(), '\d\+$', "atp_debug", '')
    call mkdir(g:atp_TempDir, "p", 0700)
endif
endfunction
if g:atp_reload_functions == 0
    call <SID>TempDir()
endif
"}}}

" Remove g:atp_TempDir tree where log files are stored.
" {{{
function! <SID>RmTempDir()
if has("python") && executable(g:atp_Python)
python << END
import shutil
temp=vim.eval("g:atp_TempDir")
print(temp)
shutil.rmtree(temp)
END
elseif has("unix") && has("macunix")
    call system("rm -rf ".shellescape(g:atp_TempDir))
else
    echohl ErrorMsg
    echomsg "[ATP:] Leaving temporary directory ".g:atp_TempDir
    echohl Normal
endif
endfunction "}}}

" vim:fdm=marker:tw=85:ff=unix:noet:ts=8:sw=4:fdc=1
