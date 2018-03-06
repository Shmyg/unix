/*
|| Script returning tracefile name for the current session
|| $Id: tfile.sql,v 1.1 2017/07/14 13:01:21 shmyg Exp $
*/

DECLARE

	v_retcode	PLS_INTEGER;
	v_num_value	PLS_INTEGER;
	v_str_value	VARCHAR2(100);
	v_file_name	VARCHAR2(12);
	v_db_name	VARCHAR2(30);

BEGIN

	v_retcode := DBMS_UTILITY.GET_PARAMETER_VALUE
			(
			'user_dump_dest',
			v_num_value,
			v_str_value
			);

	SELECT	LTRIM( spid, '0' )
	INTO	v_file_name
	FROM	v$process	pr,
		v$session	ss
	WHERE	pr.addr = ss.paddr
	AND	ss.audsid = USERENV('SESSIONID');

	SELECT	SUBSTR( LOWER( global_name ), 1, INSTR( global_name, '.', 1 ) - 1 )
	INTO	v_db_name
	FROM	global_name;

	DBMS_OUTPUT.PUT_LINE( v_str_value || '\' || v_db_name || '_ora_' ||
		v_file_name || '.trc' );

END;
/
