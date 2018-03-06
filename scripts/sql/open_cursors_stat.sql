SELECT	'session_cached_cursors'  parameter,
	LPAD(value, 5)  value,
	DECODE(value, 0, '  n/a', to_char(100 * used / value, '990') || '%')  usage
FROM	(    
	SELECT	max(s.value)  used
	FROM	v$statname  n,
		v$sesstat  s
	WHERE	n.name = 'session cursor cache count'
	AND	s.statistic# = n.statistic#
	),   
	(    
	SELECT	value
	FROM	v$parameter
	WHERE	name = 'session_cached_cursors'
	)    
UNION ALL    
SELECT	'OPEN_cursors',
	LPAD(value, 5),
	TO_CHAR(100 * used / value,  '990') || '%'
FROM	(    
	SELECT	max(sum(s.value))  used
	FROM	v$statname  n,
		v$sesstat  s
	WHERE	n.name in ('opened cursors current', 'session cursor cache count')
	AND	s.statistic# = n.statistic#
	GROUP	by s.sid
	),   
	(    
	SELECT	value
	FROM	v$parameter
	WHERE
	NAME = 'open_cursors'
	)    
/