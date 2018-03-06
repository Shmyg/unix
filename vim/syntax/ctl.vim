" Vim syntax file
" Language:	SQL*Loader
" Maintainer:	Serge Shmygelsky aka Shmyg
" Last Change:	12.12.2006

if exists("b:current_syntax")
  finish
endif

syn case ignore

syn keyword sqlldrStatement	load data infile into table fields terminated by
syn keyword sqlldrStatement	optionally enclosed begindata append filler
syn keyword sqlldrStatement	to_number truncate trailing nullcols

syn keyword sqlldrType	boolean char character date float integer long external
syn keyword sqlldrType	mlslabel number raw rowid varchar varchar2 varray pls_integer constant

" Strings and characters:
syn region sqlldrString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region sqlldrString		start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers:
syn match sqlldrNumber		"-\=\<\d*\.\=[0-9_]\>"

if version >= 508 || !exists("did_sqlldr_syn_inits")
  if version < 508
    let did_sqlldr_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink sqlldrStatement   Statement
  HiLink sqlldrString      String
  HiLink sqlldrType        Type

  delcommand HiLink
endif

let b:current_syntax = "sqlldr"
