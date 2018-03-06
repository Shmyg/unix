COLUMN year FORMAT a5
select	low_value,
	((to_number(substr(low_value,1,2),'xx')-100) * 10) ||  (to_number(substr(low_value,3,2),'xx')-100 ) as year,
	to_number(substr(low_value,5,2),'xx') month,
	to_number(substr(low_value,7,2),'xx') day,
	to_number(substr(low_value,9,2),'xx')-1 hour,
	to_number(substr(low_value,11,2),'xx')-1 min,
	to_number(substr(low_value,13,2),'xx')-1 second
FROM	dba_tab_columns
where	table_name = UPPER( '&1' )
AND	column_name = UPPER( '&2' )
/
