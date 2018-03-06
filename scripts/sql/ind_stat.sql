SELECT	blevel,
	leaf_blocks,
	distinct_keys,
	AVG_LEAF_BLOCKS_PER_KEY,
	AVG_data_BLOCKS_PER_KEY,
	clustering_factor
FROM	dba_indexes
WHERE	index_name = UPPER( '&1' )
/
