" Vim syntax file
" Language:	SQL, PL/SQL (Oracle 8i)
" Maintainer:	Paul Moore <pf_moore AT yahoo.co.uk>
" Last Change:	2005 Dec 23

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" The SQL reserved words, defined as keywords.

syn keyword sqlSpecial  false null true

syn keyword sqlKeyword	access add as asc begin by check cluster column
syn keyword sqlKeyword	compress connect current cursor decimal default desc
syn keyword sqlKeyword	else elsif end exception exclusive file for from
syn keyword sqlKeyword	function group having identified if immediate increment
syn keyword sqlKeyword	index initial into is level loop maxextents mode modify
syn keyword sqlKeyword	nocompress nowait of offline on online start
syn keyword sqlKeyword	successful synonym table then to trigger uid
syn keyword sqlKeyword	unique user validate values view whenever
syn keyword sqlKeyword	where with option order pctfree privileges procedure
syn keyword sqlKeyword	public resource return row rowlabel rownum rows
syn keyword sqlKeyword	session share size smallint type using DECODE
syn keyword sqlKeyword	pragma constant autonomous_transaction
syn keyword sqlKeyword	replace package body when others raise
syn keyword sqlKeyword	partition values less than logging nologging compress
syn keyword sqlKeyword	range byte cascade primary key constraints
syn keyword sqlKeyword	constraint subpartition list template
syn keyword sqlKeyword	datafile autoextend extent management local uniform size
syn keyword sqlKeyword	move autoallocate maxsize temporary bigfile tempfile
syn keyword sqlKeyword  unlimited undo undo_retention trace_enabled
syn keyword sqlKeyword  db_flashback_retention_target each before declare
syn keyword sqlKeyword  pctused organization references foreign
syn keyword sqlKeyword  nulls first last dual pagesize trim trimspool linesize
syn keyword sqlKeyword	tab feedback echo verify termout recsep word_wrapped
syn keyword sqlKeyword	format deterministic parallel_enable prompt
syn keyword sqlKeyword	no_data_found enable var variable initrans exec
syn keyword sqlKeyword	maxvalue partition partitions hash after disable
syn keyword sqlKeyword	unusable row pipelined exit show errors error
syn keyword sqlKeyword	referencing new old returning case too_many_rows
syn keyword sqlKeyword	materialized build refresh bulk collect continue
syn keyword sqlKeyword	sequence currval nextval

syn keyword sqlOperator	not and or upper to_char to_number to_date
syn keyword sqlOperator	in any some all between exists regexp_replace
syn keyword sqlOperator	like escape nvl lag over max trunc min
syn keyword sqlOperator union intersect minus sys_connect_by_path
syn keyword sqlOperator prior distinct count CONNECT_BY_ROOT
syn keyword sqlOperator	sysdate out substr instr row_number

syn keyword sqlStatement alter analyze audit comment commit create
syn keyword sqlStatement delete drop execute explain grant insert lock noaudit
syn keyword sqlStatement rename revoke rollback savepoint select set
syn keyword sqlStatement truncate update tablespace spool on off
syn keyword sqlStatement dbms_metadata get_dependent_ddl set_transform_param
syn keyword sqlStatement session_transform dbms_stats create_stat_table
syn keyword sqlStatement gather_schema_stats gather_database_stats gather_table_stats
syn keyword sqlStatement dbms_lock sleep dbms_random random dbms_scheduler
syn keyword sqlStatement create_job drop_job stop_job run_job parallel
syn keyword sqlStatement noparallel force ddl import_schema_stats
syn keyword sqlStatement drop_stat_table dbms_output put_line
syn keyword sqlStatement DBMS_REDEFINITION CAN_REDEF_TABLE CONS_USE_PK
syn keyword sqlStatement START_REDEF_TABLE COPY_TABLE_DEPENDENTS CONS_ORIG_PARAMS
syn keyword sqlStatement SYNC_INTERIM_TABLE FINISH_REDEF_TABLE col_mapping 
syn keyword sqlStatement options_flag define

syn keyword sqlType	boolean char character date float integer long
syn keyword sqlType	mlslabel number raw rowid varchar varchar2 varray
syn keyword sqlType	pls_integer binary_integer signint

" Strings and characters:
syn region sqlString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region sqlString		start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers:
syn match sqlNumber		"-\=\<\d*\.\=[0-9_]\>"

" Comments:
syn region sqlComment    start="/\*"  end="\*/" contains=sqlTodo
syn match sqlComment	"--.*$" contains=sqlTodo

syn sync ccomment sqlComment

" Todo.
syn keyword sqlTodo contained TODO FIXME XXX DEBUG NOTE

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sql_syn_inits")
  if version < 508
    let did_sql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink sqlComment	Comment
  HiLink sqlKeyword	sqlSpecial
  HiLink sqlNumber	Number
  HiLink sqlOperator	sqlStatement
  HiLink sqlSpecial	Special
  HiLink sqlStatement	Statement
  HiLink sqlString	String
  HiLink sqlType	Type
  HiLink sqlTodo	Todo

  delcommand HiLink
endif

let b:current_syntax = "sql"

" vim: ts=8
