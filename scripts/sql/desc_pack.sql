COLUMN  object_name new_value oname NOPRINT
TTITLE LEFT oname
BREAK ON object_name skip page
COL my_row FOR A100
SET PAGESIZE 200
SET HEADING OFF

SELECT	aa.object_name,
	aa.argument_name || ';' ||
	aa.in_out || ';' ||
	DECODE( data_type, 'VARCHAR2', data_type || '(' || data_length || ')', data_type ) || ';' || 
	DECODE( in_out, 'IN', DECODE (default_length, NULL, 'M', NULL), NULL )
FROM	all_arguments		aa
WHERE	aa.package_name = UPPER( '&1' )
AND	aa.owner = 'COMMON'
ORDER	BY aa.object_name, 
	aa.overload,
	DECODE( argument_name, NULL, NULL, aa.position ) NULLS LAST
/
