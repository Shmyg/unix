rem Used for the SHOW ERRORS command
column LINE/COL format A8
column ERROR    format A65  WORD_WRAPPED
column column_name for A40

rem For backward compatibility
set pagesize 50
set wrap off
set termout on
set trimspool on
set trimout on
set feedback off
SET DESCRIBE DEPTH 3 LINENUM ON INDENT ON
set autoprint on
set tab off
set verify off
set arraysize 1000
rem Defaults for SET AUTOTRACE EXPLAIN report
column id_plus_exp format 990 heading i
column parent_id_plus_exp format 990 heading p
column plan_plus_exp format a60
column object_node_plus_exp format a8
column other_tag_plus_exp format a29
column other_plus_exp format a44
column object_name format a30
column subobject_name format a30
column segment_name format a30
column SM_SERIALNUM format a20
column index_name format a30
column profile format a20
column resource_name format a30
column limit format a20


set linesize 150
set long 5000
set wrap on

set serveroutput on size 1000000

col dn_num for a12
col custcode for a24
col customer_name for a30
col des for a30
col ch_status for a1
col b_number for a15
col trans_b_number for a15
col table_name for a30
col column_name for a30
col dn_num for a20
col owner for a15
col directory_name for a30
col directory_path for a100
col file_name for a80
col tablespace_name for a30
col name for a50
col grantee for a30
col privilege for a20
col grantor for a30
col blocker for a20
col username for a20
col description for a50
col member for a50
col job_name for a30
col object_type for a20
col object_name for a30
col operation for a30
col filename for a100
col last_oper_type for a20
col metric_name for a40
col access_predicates noprint
col filter_predicates noprint
col time for a12
col digits for a30
col osuser for a20
col action for a40
col reason for a150

/*
alter session set nls_sort = UKRAINIAN;
ALTER   SESSION ENABLE  PARALLEL DML;
alter session set nls_numeric_characters=".,";
ALTER SESSION SET NLS_DATE_FORMAT="DD.MM.YYYY";
*/

set sqlprompt "_USER'@'_CONNECT_IDENTIFIER> "
set editfile /tmp/aaa.sql
