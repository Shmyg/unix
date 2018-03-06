COLUMN DATA_TYPE FORMAT A30
SET PAGESIZE 200
SET TERMOUT OFF
BREAK ON "Method name" SKIP 1
--SET MARKUP HTML ON
COLUMN COLUMN_NAME HEADING 'Column name'
COLUMN COMMENTS HEADING 'Description'

--SPOOL &&1..html

SELECT	attr_name AS "Attribute name",
	DECODE (
		length, NULL, attr_type_name,
		attr_type_name || '(' || length || ')' 
		) AS "Type"
FROM	user_type_attrs
WHERE	type_name = UPPER( '&1' )
ORDER	BY attr_no
/

SELECT	am.method_name AS "Method name",
	aa.argument_name AS "Argument name",
	aa.in_out AS "In/Out",
	aa.data_type AS "Data type",
	aa.default_value AS "Default value"
FROM	all_type_methods	am,
	all_arguments		aa
WHERE	am.owner = aa.owner
AND	am.method_name = aa.object_name
AND	am.type_name = UPPER( '&1' )
AND	aa.argument_name != 'SELF'
ORDER	BY am.method_no,
	aa.sequence
/

--SPOOL OFF
--SET MARKUP HTML OFF
SET TERMOUT ON
SET PAGESIZE 50
CLEAR BREAKS

--PROMPT Your file is saved. Filename: &&1..html
