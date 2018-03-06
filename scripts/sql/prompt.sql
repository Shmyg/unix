SET TERMOUT OFF
COL x NEW_VALUE y

SELECT	SUBSTR( global_name, 1, INSTR( global_name, '.', 1) - 1) x
FROM	global_name
/

COL username NEW_VALUE my_username

SELECT	USER "username"
FROM	DUAL
/

SET SQLPROMPT '&my_username@&y> ';


SET TERMOUT ON
