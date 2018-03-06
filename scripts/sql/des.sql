SELECT	dc.column_name || ';' || 
	dt.data_type || 
	DECODE( dt.data_type, 'VARCHAR2', '(' || dt.data_length || ')', NULL ) || ';' ||
	dc.comments
FROM	all_tab_columns		dt,
	all_col_comments	dc
WHERE	dc.owner = dt.owner
AND	dc.table_name = dt.table_name
AND	dc.column_name = dt.column_name
AND	dt.table_name = UPPER ( '&1' )
/

