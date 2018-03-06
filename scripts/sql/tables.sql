COLUMN my_comment FOR A100
COLUMN table_name FOR A20
COLUMN avg_row_len FOR A10
SELECT	ut.table_name,
	num_rows,
	last_analyzed,
	avg_row_len,
	partitioned,
	RTRIM( comments ) AS my_comment
FROM	user_tables	ut
	LEFT	OUTER JOIN
	user_tab_comments	uc
ON	ut.table_name = uc.table_name
ORDER	BY table_type,
	ut.table_name
/
