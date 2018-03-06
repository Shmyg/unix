SELECT	index_name, column_name, column_position
FROM	all_ind_columns
WHERE	table_name = UPPER( '&1' )
ORDER	BY index_name, column_position
/
