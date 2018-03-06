SELECT owner , segment_name , segment_type FROM dba_extents WHERE file_id = &1 AND &2 BETWEEN block_id AND block_id + blocks -1;
