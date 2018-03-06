SELECT to_number(decode(a.SID, 65535, NULL, a.SID)) sid,
	b.username,
       operation_type OPERATION,
       trunc(EXPECTED_SIZE/1024) ESIZE,
       trunc(ACTUAL_MEM_USED/1024) MEM,
       trunc(MAX_MEM_USED/1024) "MAX MEM",
       NUMBER_PASSES PASS,
       trunc(TEMPSEG_SIZE/1024) TSIZE
  FROM V$SQL_WORKAREA_ACTIVE a,
	v$session b
where a.sid = b.sid
 ORDER BY 1,2;
