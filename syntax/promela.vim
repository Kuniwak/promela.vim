" Vim syntax file
" Language:	Promela
" Maintainer:	Pieter Loubser <ploubser@cs.sun.ac.za>
" Last Change:	04 September 2003
" Filenames:	*.prom, *.prm, *.promela
" URL:		http://www.cs.sun.ac.za/~ploubser/
" Comments:	Promela is a language for describing
"		protocol validation models in SPIN


" Version 0.2 Changes:
" #define multi-line highlighting is now fixed, to be one color.
" Version 0.3 Changes:
" Other C-like comments '//' highlighting added



" Clear current syntax from system
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" Promela is a case sensitive language
syntax case match


" Some usefull Promela keywords
syn keyword	promStatement		goto break skip timeout atomic d_step inline
syn keyword	promOperator		of
syn match	promBinOperator		"[<>+=;&^|!*%-]\|??\|!!\|->\|[=<>]=\|>>\|<<"
syn keyword     promAttribute		active hidden show
syn keyword	promBuiltinFunc		printf run
syn keyword	promFunction		proctype init never trace notrace
syn keyword	promConditional		if fi assert else
syn keyword	promRepeat		do od
syn keyword	promType		bool bit byte short int
syn keyword	promType		chan mtype typedef


" Labels
syn match       promLabel		display "^[a-zA-Z_][a-zA-Z_0-9]*:" contains=promSpecialLabel
syn match       promSpecialLabel	display "^\(end\|progress\|accept\)[a-zA-Z_0-9]*:" contained


" Adding matches for special strings in comments
syn keyword	promTodo	contained TODO FIXME XXX BUG
syn cluster	cCommentGroup	contains=cTodo


" Some special character strings used
syn match	promOptions	"^\s*::"


" Integer numbers (for both '-' and '+')
syn match	promNumber	"[+-]\=\<[0-9]\+\>"


" Strings (must be able to give arguments to printf-like function)
syn match	promFormat	display "%\(d\|u\|x\|o\|c\|e\)" contained
syn match	promFormat	display "%%" contained
syn match	promFormat	display "\\\(n\|t\|\\\|\"\|\)"  contained
syn region	promString	start=+"+ skip=+\\"+ end=+"+ contains=promFormat


" For C-like comments (comments cannot be nested)
syn region	promComment		start="/\*" end="\*/" contains=promTodo
syn match	promCommentError	"\*/"
syn sync 	ccomment 		promComment 	minlines=30
syn region	promComment		start="//" skip="\\$" end="$" keepend contains=promTodo


" Initialize useful constants
syn keyword	promConstant	true false TRUE FALSE _ _last _nr_pr _pid np_ STDIN


" Macros (very C-like)
syn region	promMacro	start="^\s*#\s*\(define\|ifdef\|ifndef\|if\|else\|endif\|undef\|include\)\>" skip="\\$" end="$" end="//"me=s-1


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_c_syn_inits")
	if version < 508
		let did_c_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif
	HiLink promOptions		Function
	HiLink promPanctuation		Function
	HiLink promCommands		Operator
	HiLink promFunction		promType
	HiLink promAttribute		promFunction
	HiLink promFormat		promSpecial
	HiLink promConditional		Conditional
	HiLink promRepeat		Repeat
	HiLink promNumber		Number
	HiLink promOperator		Operator
	HiLink promBinOperator		Operator
	HiLink promMacro		Macro
	HiLink promSartCommentError	promError
	HiLink promCommentError		promError
	HiLink promError		Error
	HiLink promStatement		Statement
	HiLink promType			Type
	HiLink promConstant		Constant
	HiLink promString		String
	HiLink promComment		Comment
	HiLink promSpecial		SpecialChar
	HiLink promTodo			Todo
	HiLink promLabel		Macro
	HiLink promSpecialLabel		Statement
	HiLink promReservedSymbol	Operator
	delcommand HiLink
endif

let b:current_syntax = "promela"



" vim: ts=8
