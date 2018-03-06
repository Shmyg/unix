  select  table_name, 'TABLE' as llevel, null as part_name, null as 
subpart_name, num_rows, last_analyzed
  from user_tables
WHERE	table_name = '&1'
union ALL
  select  table_name, 'PARTITION' as llevel, PARTITION_NAME, null as 
subpart_name, num_rows, last_analyzed
  from user_tab_partitions
  where TO_DATE(SUBSTR( partition_name, 6, 8), 'DDMMYYYY') < SYSDATE
AND	table_name = '&1'
union ALL
  select  table_name, 'SUBPARTITION' as llevel, PARTITION_NAME, 
SUBPARTITION_NAME, num_rows, last_analyzed
  from user_tab_subpartitions
  where TO_DATE(SUBSTR( partition_name, 6, 8), 'DDMMYYYY') < SYSDATE
AND	table_name = '&1'
/
