COLUMN	owner FORMAT A8
COLUMN	index_name FORMAT A20
SELECT	owner, index_name, table_type, uniqueness, blevel, leaf_blocks, distinct_keys, avg_leaf_blocks_per_key, avg_data_blocks_per_key, clustering_factor, status
FROM	all_indexes
WHERE	table_name=UPPER('&1');
