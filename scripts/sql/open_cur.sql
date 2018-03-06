select count(sql_text) c, sql_text
  from v$sqlarea
  group by sql_text
  order by c desc, sql_text
/
