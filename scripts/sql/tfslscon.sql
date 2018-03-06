SET ECHO off 
REM NAME:    TFSLSCON>SQL 
REM USAGE:"@path/tfslscon schema_name table_name" 
REM ------------------------------------------------------------------------ 
REM REQUIREMENTS: 
REM    SELECT on DBA_CONSTRAINTS 
REM ------------------------------------------------------------------------ 
REM PURPOSE: 
REM    Lists a given table's constraints and their associated 
REM    tables and constraints. 
REM ------------------------------------------------------------------------ 
REM Main text of script follows: 
 
def owner 	= &&1 
def tab 	= &&2 
 
ttitle - 
  center  'Table &owner..&tab Constraints'  skip 2 
 
col name	format a30 heading 'Name'			justify c 
col type	format a5  heading 'Type'			justify c 
col stat	format a4  heading 'Stat'			justify c 
col ref_tab	format a30 heading 'Reference|Object'		justify c 
col ref_con	format a22 heading 'Reference|Constraint'	justify c 
 
select 
  a.constraint_name	name, 
  decode(a.constraint_type,'C','Check','R','FK','P','PK','U','Uniq', 
    'C','Check','*') type, 
  decode(a.status,'ENABLED','Y','DISABLED','N','*') stat, 
  b.owner||'.'||b.table_name ref_tab, 
  a.r_constraint_name	ref_con 
from 
  dba_constraints a, 
  dba_constraints b 
where 
  a.owner = upper('&owner') and 
  a.table_name = upper('&tab') and 
  a.r_constraint_name = b.constraint_name (+) 
order by 
  1 
/ 
 
undef owner 
undef tab 
 