SELECT	owner,
	segment_name
FROM	dba_extents
WHERE	file_id = &1
AND	block_id <= &2
AND	block_id + blocks >= &2
/
