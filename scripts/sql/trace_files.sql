/*
|| Script for creation of user and objects needed to get access to trace files
|| $Id: trace_files.sql,v 1.1 2017/07/14 13:01:21 shmyg Exp $
*/

SPOOL trace_files.txt

create user trace_files identified by files_1 default tablespace users quota unlimited on users;

GRANT	CREATE ANY DIRECTORY,
	CREATE SESSION,
	CREATE TABLE,
	CREATE VIEW,
	CREATE PROCEDURE,
	CREATE TYPE,
	CREATE TRIGGER,
	ADMINISTER DATABASE TRIGGER
TO	trace_files;

grant select on v_$process to trace_files;
grant select on v_$session to trace_files;
grant select on v_$instance to trace_files;

CONNECT trace_files/files_1

CREATE	VIEW session_trace_file_name
AS
SELECT	d.instance_name || '_ora_' || LTRIM( TO_CHAR( a.spid )) || '.trc' filename
FROM	v$process	a,
	v$session	b,
	v$instance	d
WHERE	a.addr = b.paddr
AND	b.audsid = SYS_CONTEXT ( 'userenv', 'sessionid' )
/

CREATE	TABLE avail_trace_files
	(
	username	VARCHAR2(30) DEFAULT USER,
	filename	VARCHAR2(512),
	time_stamp	TIMESTAMP DEFAULT SYSTIMESTAMP,
	CONSTRAINT	pk_aval_trace_files
	PRIMARY KEY
		(
		username,
		filename
		)
	)
ORGANIZATION	INDEX
/

CREATE	VIEW user_avail_trace_files
AS
SELECT	*
FROM	avail_trace_files
WHERE	username = USER
/

GRANT SELECT ON avail_trace_files TO PUBLIC
/

CREATE OR REPLACE DIRECTORY UDUMP_DIR
AS
'/u01/app/oracle/admin/rex/udump'
/

CREATE	OR REPLACE TRIGGER capture_trace_files
BEFORE	LOGOFF ON DATABASE
BEGIN
	FOR	x IN
		(
		SELECT	*
		FROM	session_trace_file_name
		)
	LOOP
		IF	( DBMS_LOB.FILEEXISTS( BFILENAME( 'UDUMP_DIR', x.filename ) ) = 1 )
		THEN
			INSERT	INTO avail_trace_files
				(
				filename
				)
			VALUES	(
				x.filename
				);
		END	IF;
	END	LOOP;
END;
/

CREATE	OR REPLACE TYPE vcarray
AS
TABLE	OF VARCHAR2(4000)
/

CREATE	OR REPLACE
FUNCTION	trace_file_contents
	(
	i_filename	IN VARCHAR2
	)
RETURN	vcarray
PIPELINED
AS
	v_bfile		BFILE := BFILENAME( 'UDUMP_DIR', i_filename );
	v_last		NUMBER := 1;
	v_current	NUMBER;
BEGIN
	SELECT	ROWNUM
	INTO	v_current
	FROM	user_avail_trace_files
	WHERE	filename = i_filename;

	DBMS_LOB.FILEOPEN( v_bfile );

	LOOP
		v_current := DBMS_LOB.INSTR( v_bfile, '0A', v_last, 1 );

		EXIT	WHEN ( NVL( v_current, 0 ) = 0 );

		PIPE	ROW
			(
			UTL_RAW.CAST_TO_VARCHAR2
				(
				DBMS_LOB.SUBSTR( v_bfile, v_current - v_last + 1, v_last )
				)
			);
		v_last := v_current + 1;
	END	LOOP;
	DBMS_LOB.FILECLOSE( v_bfile );
	RETURN;
END;
/

GRANT EXECUTE ON vcarray TO PUBLIC
/

GRANT EXECUTE ON trace_file_contents TO PUBLIC
/

PROMPT 'Connecting as sys'

CONNECT SYS AS SYSDBA

ALTER USER trace_files ACCOUNT LOCK
/
CREATE 	PUBLIC SYNONYM avail_trace_files FOR trace_files.avail_trace_files
/
CREATE PUBLIC SYNONYM trace_file_contents FOR trace_files.trace_file_contents
/

REVOKE	CREATE ANY DIRECTORY,
	CREATE SESSION,
	CREATE TABLE,
	CREATE VIEW,
	CREATE PROCEDURE,
	CREATE TYPE,
	CREATE TRIGGER,
	ADMINISTER DATABASE TRIGGER
FROM	trace_files;

ALTER	USER trace_files IDENTIFIED BY VALUES 'no_pass'
/

SPOOL OFF
