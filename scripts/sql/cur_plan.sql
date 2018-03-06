COL operation FOR A50
SELECT	id,
	parent_id,
	LPAD (' ', LEVEL - 1) || operation || ' ' || options operation,
	object_name,
	cost,
	cardinality,
	access_predicates,
	filter_predicates,
	time
FROM	(
	SELECT	DISTINCT id,
		parent_id,
		operation,
		options,
		object_name,
		cost,
		cardinality,
		access_predicates,
		filter_predicates,
		TO_CHAR( TRUNC( time / 3600 ), '00' ) || ':' ||
                LTRIM( TO_CHAR( TRUNC( time / 60 ) - TRUNC ( time / 3600 ) * 60, '00' ) ) || ':' ||
                LTRIM( TO_CHAR( MOD( time , 60 ), '00' ) ) AS  time
	FROM	v$sql_plan,
		v$session,
		v$sql
	WHERE	v$session.sql_address = v$sql.address
	AND	v$sql_plan.address = v$sql.address
	AND	v$sql_plan.hash_value = v$sql.hash_value
	AND	v$sql_plan.child_number = v$sql.child_number
	AND	v$session.sid = :v_sid
	)
START	WITH id = 0
CONNECT	BY PRIOR id = parent_id
ORDER BY id, parent_id
/
