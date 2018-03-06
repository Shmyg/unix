col tnam for a30
col cnam for a30
col stat for a10
col coln for a30

SELECT
    a.owner || '.' || a.table_name tnam,
    a.constraint_name cnam,
    a.constraint_type type,
    a.status stat,
    b.column_name coln
FROM
    all_constraints a,
    all_cons_columns b
WHERE
    a.owner = b.owner
    AND a.constraint_name = b.constraint_name
    AND a.table_name like NVL(UPPER('&1'), '%')
ORDER BY
    a.owner,
    a.table_name,
    a.constraint_name,
    b.position
;

