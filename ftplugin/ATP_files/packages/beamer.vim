" This file is a part of ATP.
" Written by Marcin Szamotulski <atp-list@lists.sourceforge.net>
" beamer loads hyperref and its options are available using
" \documentclass[hyperref=<hyperref_option>"]{beamer}
" The same for xcolor package.
let g:atp_documentclass_beamer_options=["ucs", "utf8", "utf8x", "handout", "hyperref=", "xcolor=", "dvips", 
	    \ "draft", "compress", "t", "c", "aspectratio=", "usepdftitle=", "envcountsect", "notheorems", "noamsthm", 
	    \ "8pt", "9pt", '10pt', '11pt', '12pt', 'smaller', 'bigger', '14pt', '17pt', '20pt', 'trans',
	    \ 'ignorenonframetext', 'notes']
" usepdftitle=[true/false]
let g:atp_package_beamer_environments = ["frame", "beamercolorbox", "onlyenv", "altenv", 
	    \ "visibleenv", "uncoverenv", "invisibleenv", "overlayarea", "overprint", "actionenv",
	    \ 'description', 'structureenv', 'alertenv', 'block', 'alertblock', 'exampleblock', 'beamercolorbox',
	    \ 'beamerboxesrounded', 'columns', 'semiverbatim' ]

let g:atp_package_beamer_commands = ["\\alert{", "\\frametitle{", "\\framesubtitle", "\\titlepage", "\\setbeamercolor{", 
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
		    \ '\setbeamerfont{', "\\setbeamertemplate{", '\mode', '\insertframetitle' ]

    
let g:Local_BeamerThemes=
	\ map(map(
	    \ split(globpath(g:texmf."/tex/latex/beamer/themes/theme", "*.sty"), "\n"), 'fnamemodify(v:val, ":t:r")'),
	\ 'substitute(v:val, ''^beamertheme'', "", "")')
let g:Local_BeamerInnerThemes=
	\ map(map(
	    \ split(globpath(g:texmf."/tex/latex/beamer/themes/inner", "*.sty"), "\n"), 'fnamemodify(v:val, ":t:r")'),
	\ 'substitute(v:val, ''^beamerinnertheme'', "", "")')
let g:Local_BeamerOuterThemes=
	\ map(map(
	    \ split(globpath(g:texmf."/tex/latex/beamer/themes/outer", "*.sty"), "\n"), 'fnamemodify(v:val, ":t:r")'),
	\ 'substitute(v:val, ''^beameroutertheme'', "", "")')
let g:Local_BeamerColorThemes=
	\ map(map(
	    \ split(globpath(g:texmf."/tex/latex/beamer/themes/color", "*.sty"), "\n"), 'fnamemodify(v:val, ":t:r")'),
	\ 'substitute(v:val, ''^beamercolortheme'', "", "")')
let g:Local_BeamerFontThemes=
	\ map(map(
	    \ split(globpath(g:texmf."/tex/latex/beamer/themes/font", "*.sty"), "\n"), 'fnamemodify(v:val, ":t:r")'),
	\ 'substitute(v:val, ''^beamerfonttheme'', "", "")')
let g:BeamerThemes = g:Local_BeamerThemes+[ "default", "boxes", "Bergen", "Boadilla", "Madrid", "AnnArbor", 
	    \ "CambridgeUS", "Pittsburgh", "Rochester", "Antibes", "JuanLesPins", "Montpellier", 
	    \ "Berkeley" , "PalAlto", "Gottingen", "Marburg", "Hannover", "Berlin", "Ilmenau", 
	    \ "Dresden", "Darmstadt", "Frankfurt", "Singapore", "Szeged", "Copenhagen", "Luebeck", "Malmoe", 
	    \ "Warsaw", ]
let g:BeamerInnerThemes = g:Local_BeamerInnerThemes+[ "default", "circles", "rectangles", "rounded", "inmargin" ]
let g:BeamerOuterThemes = g:Local_BeamerOuterThemes+[ "default", "infolines", "miniframes", "smoothbars", "sidebar",
	    \ "split", "shadow", "tree", "smoothtree" ]
let g:BeamerColorThemes = g:Local_BeamerColorThemes+[ "default", "structure", "sidebartab", "albatross", "beetle", "crane", 
	    \ "dove", "fly", "seagull", "wolverine", "beaver", "lily", "orchid", "rose", "whale", "seahorse", 
	    \ "dolphin" ]
let g:BeamerFontThemes = g:Local_BeamerFontThemes+[ "default", "serif", "structurebold", "structureitalicserif",
	    \ "structuresmallcapsserif" ]
let g:atp_package_beamer_command_values = {
	    \ '\\usetheme{$' : g:BeamerThemes,
	    \ '\\useinnertheme{$' : g:BeamerInnerThemes,
	    \ '\\useoutertheme{$' : g:BeamerOuterThemes,
	    \ '\\usecolortheme{$' : g:BeamerColorThemes,
	    \ '\\usefonttheme{$' : g:BeamerFontThemes
	    \ }
