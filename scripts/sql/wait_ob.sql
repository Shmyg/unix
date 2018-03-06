SELECT	owner,
	object_name,
	subobject_name,
	object_type,
	ss.event
FROM	dba_objects	do,
	v$session	ss
WHERE	ss.row_wait_obj# = do.data_object_id
AND	ss.event IN
	(
	'db file sequential read',
	'db file scattered read'
	)
/
