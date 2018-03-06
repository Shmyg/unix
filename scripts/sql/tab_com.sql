/*
|| Report on all table comments for a schema
|| $Log: tab_com.sql,v $
|| Revision 1.1  2017/07/14 13:01:21  shmyg
|| Merged with shmyg_mis
||
|| Revision 1.1  2014/11/14 08:17:16  shmyg
|| *** empty log message ***
||
*/

SET PAGESIZE 0
SET TRIMSPOOL ON
SET LINESIZE 32767
SET TAB OFF
SET FEEDBACK OFF
SET ECHO OFF
SET VERIFY OFF
SET TERMOUT OFF
SET RECSEP OFF

COLUMN begin_date new_val start_date
SELECT  TO_CHAR( SYSDATE, 'YYYYMMDDHH24MI' ) begin_date
FROM    DUAL; 


SPOOL tab_com_&&start_date..csv

SELECT	table_name || ';' ||
	comments
FROM	dba_tab_comments
WHERE	owner = UPPER ('&1')
/

SPOOL OFF

SET PAGESIZE 50
SET TERMOUT ON
