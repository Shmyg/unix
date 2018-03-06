select object_type, object_name, status
from user_objects
WHERE	object_type NOT IN
	( 'INDEX',
	'TABLE SUBPARTITION',
	'TABLE_PARTITION',
	'TABLE PARTITION',
	'INDEX PARTITION',
	'INDEX SUBPARTITION')
order by 1, 2 
/

