COL osuser for A40
SELECT	username,
	osuser,
	sid,
	serial#,
	status,
	action
FROM	v$session
ORDER	BY status,
	username
/
