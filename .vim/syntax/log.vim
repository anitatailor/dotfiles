" Quit when a syntax file was already loaded.
if exists("b:current_syntax")
    finish
endif


"syntax match date contained "^\[[0-9]\{4}\-[0-9]\{2}\-[0-9]\{2} [0-9]\{2}:[0-9]\{2}:[0-9]\{2}:[0-9]\{3}\]" nextgroup=threadid
"syntax match threadid contained "\[.*\]" nextgroup=level

syntax match LogHigh	"\vFATAL"
syntax match LogHigh	"\vERROR"
syntax match LogMedium	"\vWARN"
syntax match LogNormal	"\vINFO"
syntax match LogLow		"\vDEBUG"
syntax match LogLowest	"\vTRACE"

highlight LogHigh	ctermfg=9 	guifg=#ff0000
highlight LogMedium	ctermfg=11	guifg=#ffff00
highlight LogNormal	ctermfg=14	guifg=#00ffff
highlight LogLow	ctermfg=10	guifg=#00ff00
highlight LogLowest	ctermfg=102 guifg=#878787


let b:current_syntax = 'log'
