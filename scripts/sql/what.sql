COLUMN head     FORMAT A79  WORD_WRAP
COLUMN sql_text FORMAT A79  WORD_WRAP NEWLINE

exec dbms_application_info.set_client_info('me');

SELECT /*+ ORDERED */
    'SID: ' || s.sid || ', ' ||
    'User: ' || s.username || ', ' || 
    'Session: ''' || s.sid || ',' || s.serial# || '''' || 
    'OS User: ' || s.osuser || ', ' || 
    'Machine: ' || NVL(s.machine, '?') || ', ' || 
    'Program: ' || NVL(s.program, '?') || 
    'Foreground: ' || s.process || ', ' || 
    'Background: ' || p.spid AS who, 
    x.sql_text
--    RPAD('*', 79, '*')
FROM
    v$session s,
    v$process p,
    v$sqlarea x
WHERE s.paddr = p.addr 
AND s.type != 'BACKGROUND' 
AND s.sql_address = x.address
AND s.sql_hash_value = x.hash_value
AND	status = 'ACTIVE'
--AND	s.sid NOT IN
--	(
--	SELECT	sid
--	FROM	v$session
--	WHERE	client_info = 'me'
--	)
ORDER BY
    s.sid
/

