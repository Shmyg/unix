SET PAGESIZE 0
SET TRIMSPOOL ON
SET LINESIZE 32767
SET TAB OFF
SET FEEDBACK OFF
SET ECHO OFF
SET VERIFY OFF
SET TERMOUT OFF
SET RECSEP OFF

SPOOL complete_schema_des.csv
COL table_name noprint
BREAK ON table_name SKIP 1

SELECT	da.table_name,
	da.table_name || ';' ||
	da.comments || ';' ||
	dc.column_name || ';' || 
	dt.data_type || DECODE( dt.data_type, 'VARCHAR2', '(' || dt.data_length || ')', NULL ) || ';' ||
	dc.comments
FROM	dba_tab_columns		dt,
	dba_col_comments	dc,
	dba_tab_comments	da
WHERE	dc.owner = dt.owner
AND	dc.table_name = dt.table_name
AND	da.table_name = dt.table_name
AND	dc.column_name = dt.column_name
AND	da.owner = UPPER ( '&1' )
/

SPOOL OFF
