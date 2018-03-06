grant alter session to javaserver;

create or replace TRIGGER javaserver.TraceLogonTrigger AFTER LOGON ON javaserver.SCHEMA
BEGIN
	execute immediate 'alter session set events ''10046 trace name context forever, level 4''';
	execute immediate 'alter session set tracefile_identifier=javaserver';
END;
/
