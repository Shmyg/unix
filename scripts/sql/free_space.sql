COL free for 999g999d99
col tablespace for a30
SELECT	tablespace_name tablespace,
	TRUNC(SUM(bytes)/(1024*1024), 2) AS free
FROM	dba_free_space
GROUP	BY tablespace_name
ORDER	BY 1
/
