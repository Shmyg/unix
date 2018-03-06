COLUMN DATA_TYPE FORMAT A30
SET PAGESIZE 200
SET TERMOUT OFF
SET MARKUP HTML ON
COLUMN COLUMN_NAME HEADING 'Column name'
COLUMN COMMENTS HEADING 'Description'

SPOOL &&1..html

SELECT	dc.column_name AS "Column name",
	DECODE( dt.nullable, 'N', 'NOT NULL', NULL ) "Null?",
	dt.data_type AS "Data type",
	dc.comments AS "Description"
FROM	all_tab_columns		dt,
	all_col_comments	dc
WHERE	dc.owner = dt.owner
AND	dc.table_name = dt.table_name
AND	dc.column_name = dt.column_name
AND	dc.table_name = UPPER( '&1' )
ORDER	BY dc.column_name
/

SELECT	ac.column_name AS "Column name",
	ai.index_name AS "Index name",
	ai.index_type AS "Index type",
	ai.uniqueness AS "Unique?"
FROM	all_indexes	ai,
	all_ind_columns	ac
WHERE	ai.index_name = ac.index_name
AND	ai.table_name = UPPER( '&1' )
ORDER	BY uniqueness DESC,
	ai.index_name,
	ac.column_position
/

SELECT	ac.column_name AS "Column name",
	ao.constraint_name AS "Constraint name",
	DECODE (ao.constraint_type,
		'C', 'Check',
		'R', 'Referential',
		'P', 'Primary key',
		'U', 'Unique'
		) AS "Constraint type",
	ao.search_condition AS "Condition",
	DECODE (ao.constraint_type, 'R', al.table_name || '.' || ao.r_constraint_name ) AS "References"
FROM	all_cons_columns	ac,
	all_constraints		ao,
	all_constraints		al
WHERE	ao.constraint_name = ac.constraint_name
AND	ao.r_constraint_name = al.constraint_name(+)
AND	ac.table_name = UPPER( '&1' )
ORDER	BY ac.column_name
/

SPOOL OFF
SET MARKUP HTML OFF
SET TERMOUT ON
SET PAGESIZE 50
CLEAR BREAKS

PROMPT Your file is saved. Filename: &&1..html