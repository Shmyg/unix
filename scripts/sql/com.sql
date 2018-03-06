SET	VERIFY OFF
COLUMN	comments FORMAT A50
SELECT	column_name, comments
FROM	dba_tab_comments
WHERE	table_name=UPPER('&v_col')
/
