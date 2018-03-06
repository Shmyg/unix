/*
The script shows currently allocated and used space for a tablespace

$Log: ts_data.sql,v $
Revision 1.1  2017/07/14 13:01:21  shmyg
Merged with shmyg_mis

Revision 1.1  2010/09/14 16:30:48  shmyg
*** empty log message ***

*/

SELECT	tablespace_name,
	SUM( bytes ) / (1024 * 1024 ) AS total_size,
	(
	SELECT	SUM( bytes ) / (1024 * 1024 )
	FROM	dba_segments
	WHERE	tablespace_name = dba_data_files.tablespace_name
	GROUP	BY tablespace_name
	) AS used_size
FROM	dba_data_files
WHERE	tablespace_name = UPPER( '&1' )
GROUP	BY tablespace_name
/
