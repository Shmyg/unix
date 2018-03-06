SELECT	username, 
	tablespace_name, 
	DECODE( GREATEST(max_bytes, -1),	-1, 'Unrestricted', 
						TO_CHAR( max_bytes/1024, '999,999,990') 
		) qota, 
	bytes/1024 used 
FROM	dba_ts_quotas 
WHERE	max_bytes != 0 
OR	bytes != 0 
ORDER	by 1, 2
/