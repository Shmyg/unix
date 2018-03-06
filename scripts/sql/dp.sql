SELECT	plan_table_output
FROM	TABLE
	(
	dbms_xplan.display
		(
		'dynamic_plan_table',
		(
		SELECT	rawtohex( sql_address ) || '_' || sql_child_number
		FROM	v$session
		WHERE	sid = :v_sid
		),
		'serial'
		)
	)
/
