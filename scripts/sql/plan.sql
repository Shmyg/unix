col "Query plan" for A70
col other_tag for A50

SELECT	id,
	cardinality AS "Rows",
	LPAD (' ',2*level) ||
	RTRIM( operation ) ||
	DECODE (id, 0, ' Cost = '||position)||' '||
	RTRIM( options )||' '||
	RTRIM( object_name )	as "Query plan",
	other_tag
FROM	plan_table
CONNECT	BY prior id=parent_id
START	WITH id=0
/

TRUNCATE TABLE plan_table
/