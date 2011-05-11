" Author:	Marcin Szamotulski
" Description:	This file sets up the menu.
" Note:		This file is a part of Automatic Tex Plugin for Vim.
" URL:		https://launchpad.net/automatictexplugin
" Language:	tex
" Last Change:

let s:sourced = ( !exists("s:sourced") ? 0 : 1 )
if s:sourced
    finish
endif

let Compiler	= get(g:CompilerMsg_Dict, matchstr(b:atp_TexCompiler, '^\s*\zs\S*'), 'Compile')

let Viewer	= get(g:ViewerMsg_Dict, matchstr(b:atp_Viewer, '^\s*\zs\S*'), "")

if !exists("no_plugin_menu") && !exists("no_atp_menu")
execute "menu 550.5 LaTe&X.&".Compiler."<Tab>:TEX				:<C-U>TEX<CR>"
execute "cmenu 550.5 LaTe&X.&".Compiler."<Tab>:TEX				<C-U>TEX<CR>"
execute "imenu 550.5 LaTe&X.&".Compiler."<Tab>:TEX				<Esc>:TEX<CR>a"
execute "menu 550.6 LaTe&X.".Compiler."\\ debug<Tab>:TEX\\ debug		:<C-U>DTEX<CR>"
execute "cmenu 550.6 LaTe&X.".Compiler."\\ debug<Tab>:TEX\\ debug		<C-U>DTEX<CR>"
execute "imenu 550.6 LaTe&X.".Compiler."\\ debug<Tab>:TEX\\ debug		<Esc>:DTEX<CR>a"
execute "menu 550.7 LaTe&X.".Compiler."\\ &twice<Tab>:2TEX			:<C-U>2TEX<CR>"
execute "cmenu 550.7 LaTe&X.".Compiler."\\ &twice<Tab>:2TEX			<C-U>2TEX<CR>"
execute "imenu 550.7 LaTe&X.".Compiler."\\ &twice<Tab>:2TEX			<Esc>:2TEX<CR>a"
nmenu 550.8 LaTe&X.&MakeLatex<Tab>:MakeLatex					:<C-U>MakeLatex<CR>
cmenu 550.8 LaTe&X.&MakeLatex<Tab>:MakeLatex					<C-U>MakeLatex<CR>
imenu 550.8 LaTe&X.&MakeLatex<Tab>:MakeLatex					<Esc>:MakeLatex<CR>a
menu 550.9 LaTe&X.&Bibtex<Tab>:Bibtex						:<C-U>Bibtex<CR>
cmenu 550.9 LaTe&X.&Bibtex<Tab>:Bibtex						<C-U>Bibtex<CR>
imenu 550.9 LaTe&X.&Bibtex<Tab>:Bibtex						<Esc>:Bibtex<CR>a
if Viewer != ""
    execute "menu 550.10 LaTe&X.&View\\ with\\ ".Viewer."<Tab>:ViewOutput 	:<C-U>ViewOutput<CR>"
    execute "cmenu 550.10 LaTe&X.&View\\ with\\ ".Viewer."<Tab>:ViewOutput 	<C-U>ViewOutput<CR>"
    execute "imenu 550.10 LaTe&X.&View\\ with\\ ".Viewer."<Tab>:ViewOutput 	<Esc>:ViewOutput<CR>a"
else
    execute "menu 550.10 LaTe&X.&View\\ Output<Tab>:ViewOutput	 		:<C-U>ViewOutput<CR>"
    execute "cmenu 550.10 LaTe&X.&View\\ Output<Tab>:ViewOutput	 		<C-U>ViewOutput<CR>"
    execute "imenu 550.10 LaTe&X.&View\\ Output<Tab>:ViewOutput 		<Esc>:ViewOutput<CR>a"
endif
"
menu 550.20.1 LaTe&X.&Errors<Tab>:ShowErrors					:<C-U>ShowErrors<CR>
cmenu 550.20.1 LaTe&X.&Errors<Tab>:ShowErrors					<C-U>ShowErrors<CR>
imenu 550.20.1 LaTe&X.&Errors<Tab>:ShowErrors					<Esc>:ShowErrors<CR>
menu 550.20.1 LaTe&X.&Log.&Open\ Log\ File<Tab>:ShowErrors\ o			:<C-U>ShowErrors\ o<CR>
cmenu 550.20.1 LaTe&X.&Log.&Open\ Log\ File<Tab>:ShowErrors\ o			<C-U>ShowErrors\ o<CR>
imenu 550.20.1 LaTe&X.&Log.&Open\ Log\ File<Tab>:ShowErrors\ o			<Esc>:ShowErrors\ o<CR>
if t:atp_DebugMode ==? "debug"
    menu 550.20.5 LaTe&X.&Log.Toggle\ &Debug\ Mode\ [on]			:<C-U>ToggleDebugMode<CR>
    cmenu 550.20.5 LaTe&X.&Log.Toggle\ &Debug\ Mode\ [on]			<C-U>ToggleDebugMode<CR>
    imenu 550.20.5 LaTe&X.&Log.Toggle\ &Debug\ Mode\ [on]			<Esc>:ToggleDebugMode<CR>a
else
    menu 550.20.5 LaTe&X.&Log.Toggle\ &Debug\ Mode\ [off]			:<C-U>ToggleDebugMode<CR>
    cmenu 550.20.5 LaTe&X.&Log.Toggle\ &Debug\ Mode\ [off]			<C-U>ToggleDebugMode<CR>
    imenu 550.20.5 LaTe&X.&Log.Toggle\ &Debug\ Mode\ [off]			<Esc>:ToggleDebugMode<CR>a
endif  
menu 550.20.20 LaTe&X.&Log.-ShowErrors-						:
menu 550.20.20 LaTe&X.&Log.&Warnings<Tab>:ShowErrors\ w 			:<C-U>ShowErrors w<CR>
cmenu 550.20.20 LaTe&X.&Log.&Warnings<Tab>:ShowErrors\ w 			<C-U>ShowErrors w<CR>
imenu 550.20.20 LaTe&X.&Log.&Warnings<Tab>:ShowErrors\ w 			<Esc>:ShowErrors w<CR>
menu 550.20.20 LaTe&X.&Log.&Citation\ Warnings<Tab>:ShowErrors\ c		:<C-U>ShowErrors c<CR>
cmenu 550.20.20 LaTe&X.&Log.&Citation\ Warnings<Tab>:ShowErrors\ c		<C-U>ShowErrors c<CR>
imenu 550.20.20 LaTe&X.&Log.&Citation\ Warnings<Tab>:ShowErrors\ c		<Esc>:ShowErrors c<CR>
menu 550.20.20 LaTe&X.&Log.&Reference\ Warnings<Tab>:ShowErrors\ r		:<C-U>ShowErrors r<CR>
cmenu 550.20.20 LaTe&X.&Log.&Reference\ Warnings<Tab>:ShowErrors\ r		<C-U>ShowErrors r<CR>
imenu 550.20.20 LaTe&X.&Log.&Reference\ Warnings<Tab>:ShowErrors\ r		<Esc>:ShowErrors r<CR>
menu 550.20.20 LaTe&X.&Log.&Font\ Warnings<Tab>ShowErrors\ f			:<C-U>ShowErrors f<CR>
cmenu 550.20.20 LaTe&X.&Log.&Font\ Warnings<Tab>ShowErrors\ f			<C-U>ShowErrors f<CR>
imenu 550.20.20 LaTe&X.&Log.&Font\ Warnings<Tab>ShowErrors\ f			<Esc>:ShowErrors f<CR>
menu 550.20.20 LaTe&X.&Log.Font\ Warnings\ &&\ Info<Tab>:ShowErrors\ fi		:<C-U>ShowErrors fi<CR>
cmenu 550.20.20 LaTe&X.&Log.Font\ Warnings\ &&\ Info<Tab>:ShowErrors\ fi	<C-U>ShowErrors fi<CR>
imenu 550.20.20 LaTe&X.&Log.Font\ Warnings\ &&\ Info<Tab>:ShowErrors\ fi	<Esc>:ShowErrors fi<CR>
menu 550.20.20 LaTe&X.&Log.&Show\ Files<Tab>:ShowErrors\ F			:<C-U>ShowErrors F<CR>
cmenu 550.20.20 LaTe&X.&Log.&Show\ Files<Tab>:ShowErrors\ F			<C-U>ShowErrors F<CR>
imenu 550.20.20 LaTe&X.&Log.&Show\ Files<Tab>:ShowErrors\ F			<Esc>:ShowErrors F<CR>
"
menu 550.20.20 LaTe&X.&Log.-PdfFotns- 						:
menu 550.20.20 LaTe&X.&Log.&Pdf\ Fonts<Tab>:PdfFonts				:<C-U>PdfFonts<CR>
cmenu 550.20.20 LaTe&X.&Log.&Pdf\ Fonts<Tab>:PdfFonts				<C-U>PdfFonts<CR>
imenu 550.20.20 LaTe&X.&Log.&Pdf\ Fonts<Tab>:PdfFonts				<Esc>:PdfFonts<CR>

menu 550.20.20 LaTe&X.&Log.-Delete-						:
menu 550.20.20 LaTe&X.&Log.&Delete\ Tex\ Output\ Files<Tab>:Delete		:<C-U>Delete<CR>
cmenu 550.20.20 LaTe&X.&Log.&Delete\ Tex\ Output\ Files<Tab>:Delete		<C-U>Delete<CR>
imenu 550.20.20 LaTe&X.&Log.&Delete\ Tex\ Output\ Files<Tab>:Delete		<Esc>:Delete<CR>
menu 550.20.20 LaTe&X.&Log.Set\ Error\ File<Tab>:SetErrorFile			:<C-U>SetErrorFile<CR> 
cmenu 550.20.20 LaTe&X.&Log.Set\ Error\ File<Tab>:SetErrorFile			<C-U>SetErrorFile<CR> 
imenu 550.20.20 LaTe&X.&Log.Set\ Error\ File<Tab>:SetErrorFile			<Esc>:SetErrorFile<CR>a
"
menu 550.25 LaTe&X.-Print- 							:
menu 550.26 LaTe&X.&SshPrint<Tab>:SshPrint					:<C-U>SshPrint 
cmenu 550.26 LaTe&X.&SshPrint<Tab>:SshPrint					<C-U>SshPrint 
imenu 550.26 LaTe&X.&SshPrint<Tab>:SshPrint					<Esc>:SshPrinta
"
menu 550.30 LaTe&X.-TOC- 							:
menu 550.30 LaTe&X.&Table\ of\ Contents<Tab>:TOC				:<C-U>TOC<CR>
cmenu 550.30 LaTe&X.&Table\ of\ Contents<Tab>:TOC				<C-U>TOC<CR>
imenu 550.30 LaTe&X.&Table\ of\ Contents<Tab>:TOC				<Esc>:TOC<CR>
menu 550.30 LaTe&X.L&abels<Tab>:Labels						:<C-U>Labels<CR>
cmenu 550.30 LaTe&X.L&abels<Tab>:Labels						<C-U>Labels<CR>
imenu 550.30 LaTe&X.L&abels<Tab>:Labels						<Esc>:Labels<CR>
"
menu 550.40 LaTe&X.&Go\ to.&GotoFile<Tab>:GotoFile				:GotoFile<CR>
cmenu 550.40 LaTe&X.&Go\ to.&GotoFile<Tab>:GotoFile				GotoFile<CR>
imenu 550.40 LaTe&X.&Go\ to.&GotoFile<Tab>:GotoFile				<Esc>:GotoFile<CR>
menu 550.40 LaTe&X.&Go\ to.&GotoLabel<Tab>:GotoLabel				:GotoLabel<CR>
cmenu 550.40 LaTe&X.&Go\ to.&GotoLabel<Tab>:GotoLabel				GotoLabel<CR>
imenu 550.40 LaTe&X.&Go\ to.&GotoLabel<Tab>:GotoLabel				<Esc>:GotoLabel<CR>
menu 550.40 LaTe&X.&Go\ to.&GotoNamedDest<Tab>(Xpdf\ only)			:GotoNamedDest 
cmenu 550.40 LaTe&X.&Go\ to.&GotoNamedDest<Tab>(Xpdf\ only)			GotoNamedDest 
imenu 550.40 LaTe&X.&Go\ to.&GotoNamedDest<Tab>(Xpdf\ only)			<Esc>:GotoNamedDest 
"
menu 550.40 LaTe&X.&Go\ to.-Environment- 					:
menu 550.40 LaTe&X.&Go\ to.Next\ Definition<Tab>:NEnv\ definition		:<C-U>NEnv definition<CR>
cmenu 550.40 LaTe&X.&Go\ to.Next\ Definition<Tab>:NEnv\ definition		<C-U>NEnv definition<CR>
imenu 550.40 LaTe&X.&Go\ to.Next\ Definition<Tab>:NEnv\ definition		<Esc>:NEnv definition<CR>
menu 550.40 LaTe&X.&Go\ to.Previuos\ Definition<Tab>:PEnv\ definition		:<C-U>PEnv definition<CR>
cmenu 550.40 LaTe&X.&Go\ to.Previuos\ Definition<Tab>:PEnv\ definition		<C-U>PEnv definition<CR>
imenu 550.40 LaTe&X.&Go\ to.Previuos\ Definition<Tab>:PEnv\ definition		<Esc>:PEnv definition<CR>
menu 550.40 LaTe&X.&Go\ to.Next\ Environment<Tab>:NEnv\ [pattern]		:<C-U>NEnv 
cmenu 550.40 LaTe&X.&Go\ to.Next\ Environment<Tab>:NEnv\ [pattern]		<C-U>NEnv 
imenu 550.40 LaTe&X.&Go\ to.Next\ Environment<Tab>:NEnv\ [pattern]		<Esc>:NEnv 
menu 550.40 LaTe&X.&Go\ to.Previuos\ Environment<Tab>:PEnv\ [pattern]		:<C-U>PEnv 
cmenu 550.40 LaTe&X.&Go\ to.Previuos\ Environment<Tab>:PEnv\ [pattern]		<C-U>PEnv 
imenu 550.40 LaTe&X.&Go\ to.Previuos\ Environment<Tab>:PEnv\ [pattern]		<Esc>:PEnv 
"
menu 550.40 LaTe&X.&Go\ to.-Section- 						:
menu 550.40 LaTe&X.&Go\ to.&Next\ Section<Tab>:NSec				:NSec<CR>
cmenu 550.40 LaTe&X.&Go\ to.&Next\ Section<Tab>:NSec				NSec<CR>
imenu 550.40 LaTe&X.&Go\ to.&Next\ Section<Tab>:NSec				<Esc>:NSec<CR>
menu 550.40 LaTe&X.&Go\ to.&Previuos\ Section<Tab>:PSec				:<C-U>PSec<CR>
cmenu 550.40 LaTe&X.&Go\ to.&Previuos\ Section<Tab>:PSec			<C-U>PSec<CR>
imenu 550.40 LaTe&X.&Go\ to.&Previuos\ Section<Tab>:PSec			<Esc>:PSec<CR>
menu 550.40 LaTe&X.&Go\ to.Next\ Chapter<Tab>:NChap				:<C-U>NChap<CR>
cmenu 550.40 LaTe&X.&Go\ to.Next\ Chapter<Tab>:NChap				<C-U>NChap<CR>
imenu 550.40 LaTe&X.&Go\ to.Next\ Chapter<Tab>:NChap				<Esc>:NChap<CR>
menu 550.40 LaTe&X.&Go\ to.Previous\ Chapter<Tab>:PChap				:<C-U>PChap<CR>
cmenu 550.40 LaTe&X.&Go\ to.Previous\ Chapter<Tab>:PChap			<C-U>PChap<CR>
imenu 550.40 LaTe&X.&Go\ to.Previous\ Chapter<Tab>:PChap			<Esc>:PChap<CR>
menu 550.40 LaTe&X.&Go\ to.Next\ Part<Tab>:NPart				:<C-U>NPart<CR>
cmenu 550.40 LaTe&X.&Go\ to.Next\ Part<Tab>:NPart				<C-U>NPart<CR>
imenu 550.40 LaTe&X.&Go\ to.Next\ Part<Tab>:NPart				<Esc>:NPart<CR>
menu 550.40 LaTe&X.&Go\ to.Previuos\ Part<Tab>:PPart				:<C-U>PPart<CR>
cmenu 550.40 LaTe&X.&Go\ to.Previuos\ Part<Tab>:PPart				<C-U>PPart<CR>
imenu 550.40 LaTe&X.&Go\ to.Previuos\ Part<Tab>:PPart				<Esc>:PPart<CR>
"
menu 550.50 LaTe&X.-Bib-							:
menu 550.50 LaTe&X.Bib\ Search<Tab>:Bibsearch\ [pattern]			:<C-U>BibSearch 
cmenu 550.50 LaTe&X.Bib\ Search<Tab>:Bibsearch\ [pattern]			<C-U>BibSearch 
imenu 550.50 LaTe&X.Bib\ Search<Tab>:Bibsearch\ [pattern]			<Esc>:BibSearch 
menu 550.50 LaTe&X.Input\ Files<Tab>:InputFiles					:<C-U>InputFiles<CR>
cmenu 550.50 LaTe&X.Input\ Files<Tab>:InputFiles				<C-U>InputFiles<CR>
imenu 550.50 LaTe&X.Input\ Files<Tab>:InputFiles				<Esc>:InputFiles<CR>
"
menu 550.60 LaTe&X.-Viewer-							:
menu 550.60 LaTe&X.Set\ &XPdf\ (forward\ search)<Tab>:SetXpdf			:<C-U>SetXpdf<CR>
cmenu 550.60 LaTe&X.Set\ &XPdf\ (forward\ search)<Tab>:SetXpdf			<C-U>SetXpdf<CR>
imenu 550.60 LaTe&X.Set\ &XPdf\ (forward\ search)<Tab>:SetXpdf			<Esc>:SetXpdf<CR>
menu 550.60 LaTe&X.Set\ &Okular\ (forward\/reverse\ search)<Tab>:SetOkular	:<C-U>SetOkular<CR>
cmenu 550.60 LaTe&X.Set\ &Okular\ (forward\/reverse\ search)<Tab>:SetOkular	<C-U>SetOkular<CR>
imenu 550.60 LaTe&X.Set\ &Okular\ (forward\/reverse\ search)<Tab>:SetOkular	<Esc>:SetOkular<CR>
menu 550.60 LaTe&X.Set\ X&Dvi\ (forward\/reverse\ search)<Tab>:SetXdvi		:<C-U>SetXdvi<CR>
cmenu 550.60 LaTe&X.Set\ X&Dvi\ (forward\/reverse\ search)<Tab>:SetXdvi		<C-U>SetXdvi<CR>
imenu 550.60 LaTe&X.Set\ X&Dvi\ (forward\/reverse\ search)<Tab>:SetXdvi		<Esc>:SetXdvi<CR>
"
menu 550.70 LaTe&X.-Editting-							:
"
" ToDo: show options doesn't work from the menu (it disappears immediately, but at
" some point I might change it completely)
menu 550.70 LaTe&X.&Options.&Show\ Options<Tab>:ShowOptions[!]			:<C-U>ShowOptions 
cmenu 550.70 LaTe&X.&Options.&Show\ Options<Tab>:ShowOptions[!]			<C-U>ShowOptions 
imenu 550.70 LaTe&X.&Options.&Show\ Options<Tab>:ShowOptions[!]			<Esc>:ShowOptions 
if g:atp_callback
    menu 550.70 LaTe&X.&Options.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback	:<C-U>ToggleCallBack<CR>
    cmenu 550.70 LaTe&X.&Options.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback	<C-U>ToggleCallBack<CR>
    imenu 550.70 LaTe&X.&Options.Toggle\ &Call\ Back\ [on]<Tab>g:atp_callback	<Esc>:ToggleCallBack<CR>a
else
    menu 550.70 LaTe&X.&Options.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	:<C-U>ToggleCallBack<CR>
    cmenu 550.70 LaTe&X.&Options.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	<C-U>ToggleCallBack<CR>
    imenu 550.70 LaTe&X.&Options.Toggle\ &Call\ Back\ [off]<Tab>g:atp_callback	<Esc>:ToggleCallBack<CR>a
endif  
menu 550.70 LaTe&X.&Options.-set\ options- 					:
" There is menu for ToggleAuTeX
" menu 550.70 LaTe&X.&Options.Automatic\ TeX\ Processing<Tab>b:atp_autex		:<C-U>let b:atp_autex=
" imenu 550.70 LaTe&X.&Options.Automatic\ TeX\ Processing<Tab>b:atp_autex		<Esc>:let b:atp_autex=
menu 550.70 LaTe&X.&Options.Set\ TeX\ Compiler<Tab>:Compiler			:<C-U>Compiler 
cmenu 550.70 LaTe&X.&Options.Set\ TeX\ Compiler<Tab>:Compiler			<C-U>Compiler 
imenu 550.70 LaTe&X.&Options.Set\ TeX\ Compiler<Tab>:Compiler			<Esc>:Compiler 
menu 550.70 LaTe&X.&Options.Set\ Debug\ Mode<Tab>:DebugMode\ {mode}		:<C-U>DebugMode
cmenu 550.70 LaTe&X.&Options.Set\ Debug\ Mode<Tab>:DebugMode\ {mode}		<C-U>DebugMode
imenu 550.70 LaTe&X.&Options.Set\ Debug\ Mode<Tab>:Compiler\ {compiler}		<Esc>:DebugMode 
menu 550.70 LaTe&X.&Options.Set\ Runs<Tab>b:atp_auruns				:<C-U>let b:atp_auruns=
cmenu 550.70 LaTe&X.&Options.Set\ Runs<Tab>b:atp_auruns				<C-U>let b:atp_auruns=
imenu 550.70 LaTe&X.&Options.Set\ Runs<Tab>b:atp_auruns				<Esc>:let b:atp_auruns=
menu 550.70 LaTe&X.&Options.Set\ Viewer<Tab>:Viewer\ {viewer}			:<C-U>Viewer 
cmenu 550.70 LaTe&X.&Options.Set\ Viewer<Tab>:Viewer\ {viewer}			<C-U>Viewer 
imenu 550.70 LaTe&X.&Options.Set\ Viewer<Tab>:Viewer\ {viewer}			<Esc>:Viewer 
menu 550.70 LaTe&X.&Options.Set\ Output\ Directory<Tab>b:atp_OutDir		:<C-U>let b:atp_OutDir="
cmenu 550.70 LaTe&X.&Options.Set\ Output\ Directory<Tab>b:atp_OutDir		<C-U>let b:atp_OutDir="
imenu 550.70 LaTe&X.&Options.Set\ Output\ Directory<Tab>b:atp_OutDir		<Esc>:let b:atp_OutDir="
menu 550.70 LaTe&X.&Options.Set\ Viewer\ Options				:<C-U>let b:atp_{matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')}Options=
cmenu 550.70 LaTe&X.&Options.Set\ Viewer\ Options 				<C-U>let b:atp_{matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')}Options=
imenu 550.70 LaTe&X.&Options.Set\ Viewer\ Options				<Esc>:let b:atp_{matchstr(b:atp_Viewer, '^\s*\zs\S\+\ze')}Options=
menu 550.70 LaTe&X.&Options.Set\ Output\ Directory\ to\ the\ default\ value<Tab>:SetOutDir	:<C-U>SetOutDir<CR> 
cmenu 550.70 LaTe&X.&Options.Set\ Output\ Directory\ to\ the\ default\ value<Tab>:SetOutDir	<C-U>SetOutDir<CR> 
imenu 550.70 LaTe&X.&Options.Set\ Output\ Directory\ to\ the\ default\ value<Tab>:SetOutDir	<Esc>:SetOutDir<CR> 
" The title is misleading! I think it is not needed here.
" menu 550.70 LaTe&X.&Options.Ask\ for\ the\ Output\ Directory<Tab>g:askfortheoutdir		:<C-U>let g:askfortheoutdir="
" imenu 550.70 LaTe&X.&Options.Ask\ for\ the\ Output\ Directory<Tab>g:askfortheoutdir		<Esc>:let g:askfortheoutdir="
menu 550.70 LaTe&X.&Options.Set\ Error\ File<Tab>:SetErrorFile			:<C-U>SetErrorFile<CR> 
cmenu 550.70 LaTe&X.&Options.Set\ Error\ File<Tab>:SetErrorFile			<C-U>SetErrorFile<CR> 
imenu 550.70 LaTe&X.&Options.Set\ Error\ File<Tab>:SetErrorFile			<Esc>:SetErrorFile<CR> 
menu 550.70 LaTe&X.&Options.Which\ TeX\ files\ to\ copy<Tab>g:keep		:<C-U>let g:keep="
cmenu 550.70 LaTe&X.&Options.Which\ TeX\ files\ to\ copy<Tab>g:keep		<C-U>let g:keep="
imenu 550.70 LaTe&X.&Options.Which\ TeX\ files\ to\ copy<Tab>g:keep		<Esc>:let g:keep="
menu 550.70 LaTe&X.&Options.Tex\ extensions<Tab>g:atp_tex_extensions		:<C-U>let g:atp_tex_extensions="
cmenu 550.70 LaTe&X.&Options.Tex\ extensions<Tab>g:atp_tex_extensions		<C-U>let g:atp_tex_extensions="
imenu 550.70 LaTe&X.&Options.Tex\ extensions<Tab>g:atp_tex_extensions		<Esc>:let g:atp_tex_extensions="
menu 550.70 LaTe&X.&Options.Default\ Bib\ Flags<Tab>g:defaultbibflags		:<C-U>let g:defaultbibflags="
cmenu 550.70 LaTe&X.&Options.Default\ Bib\ Flags<Tab>g:defaultbibflags		<C-U>let g:defaultbibflags="
imenu 550.70 LaTe&X.&Options.Default\ Bib\ Flags<Tab>g:defaultbibflags		<Esc>:let g:defaultbibflags="
"
if b:atp_autex
    menu 550.75 &LaTeX.&Toggle\ AuTeX\ [on]<Tab>b:atp_autex	:<C-U>ToggleAuTeX<CR>
    cmenu 550.75 &LaTeX.&Toggle\ AuTeX\ [on]<Tab>b:atp_autex	<C-U>ToggleAuTeX<CR>
    imenu 550.75 &LaTeX.&Toggle\ AuTeX\ [on]<Tab>b:atp_autex	<ESC>:ToggleAuTeX<CR>a
else
    menu 550.75 &LaTeX.&Toggle\ AuTeX\ [off]<Tab>b:atp_autex	:<C-U>ToggleAuTeX<CR>
    cmenu 550.75 &LaTeX.&Toggle\ AuTeX\ [off]<Tab>b:atp_autex	<C-U>ToggleAuTeX<CR>
    imenu 550.75 &LaTeX.&Toggle\ AuTeX\ [off]<Tab>b:atp_autex	<ESC>:ToggleAuTeX<CR>a
endif
menu 550.78 LaTe&X.&Toggle\ Space\ [off]<Tab>cmap\ <space>\ \\_s\\+ 		:<C-U>ToggleSpace<CR>
cmenu 550.78 LaTe&X.&Toggle\ Space\ [off]<Tab>cmap\ <space>\ \\_s\\+ 		<C-U>ToggleSpace<CR>
imenu 550.78 LaTe&X.&Toggle\ Space\ [off]<Tab>cmap\ <space>\ \\_s\\+ 		<Esc>:ToggleSpace<CR>a
tmenu LaTe&X.&Toggle\ Space\ [off] cmap <space> \_s\+ is curently off
" ToggleNn menu is made by s:LoadHistory
if g:atp_mapNn
    menu 550.79 LaTe&X.Toggle\ &Nn\ [on]<Tab>:ToggleNn				:<C-U>ToggleNn<CR>
    cmenu 550.79 LaTe&X.Toggle\ &Nn\ [on]<Tab>:ToggleNn				<C-U>ToggleNn<CR>
    imenu 550.79 LaTe&X.Toggle\ &Nn\ [on]<Tab>:ToggleNn				<Esc>:ToggleNn<CR>a
    tmenu LaTeX.Toggle\ Nn\ [on] n,N vim normal commands.
else
    menu 550.79 LaTe&X.Toggle\ &Nn\ [off]<Tab>:ToggleNn				:<C-U>ToggleNn<CR>
    cmenu 550.79 LaTe&X.Toggle\ &Nn\ [off]<Tab>:ToggleNn				<C-U>ToggleNn<CR>
    imenu 550.79 LaTe&X.Toggle\ &Nn\ [off]<Tab>:ToggleNn			<Esc>:ToggleNn<CR>a
    tmenu LaTeX.Toggle\ Nn\ [off] atp maps to n,N.
endif
if g:atp_MathOpened
    menu 550.80 LaTe&X.Toggle\ &Check\ if\ in\ Math\ [on]<Tab>g:atp_MathOpened   :<C-U>ToggleCheckMathOpened<CR>
    cmenu 550.80 LaTe&X.Toggle\ &Check\ if\ in\ Math\ [on]<Tab>g:atp_MathOpened   <C-U>ToggleCheckMathOpened<CR>
    imenu 550.80 LaTe&X.Toggle\ &Check\ if\ in\ Math\ [on]<Tab>g:atp_MathOpened  <Esc>:ToggleCheckMathOpened<CR>a
else
    menu 550.80 LaTe&X.Toggle\ &Check\ if\ in\ Math\ [off]<Tab>g:atp_MathOpened  :<C-U>ToggleCheckMathOpened<CR>
    cmenu 550.80 LaTe&X.Toggle\ &Check\ if\ in\ Math\ [off]<Tab>g:atp_MathOpened  <C-U>ToggleCheckMathOpened<CR>
    imenu 550.80 LaTe&X.Toggle\ &Check\ if\ in\ Math\ [off]<Tab>g:atp_MathOpened <Esc>:ToggleCheckMathOpened<CR>a
endif
endif

" vim:fdm=marker:tw=85:ff=unix:noet:ts=8:sw=4:fdc=1
