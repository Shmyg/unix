/*
||
|| $Log: all_puk_data.sql,v $
|| Revision 1.1  2017/07/14 13:01:20  shmyg
|| Merged with shmyg_mis
||
|| Revision 1.1  2006/10/09 14:10:29  shmyg
|| *** empty log message ***
||
|| Revision 1.1.1.1  2005-06-07 11:16:08  serge
||
||
*/

SET PAGESIZE 0
SET TRIMSPOOL ON
SET LINESIZE 32767
SET TAB OFF
SET FEEDBACK OFF
SET ECHO OFF
SET VERIFY OFF
SET TERMOUT OFF
SET RECSEP OFF

COLUMN begin_date new_val start_date
SELECT  TO_CHAR( SYSDATE, 'YYYYMMDDHH24MI' ) begin_date
FROM    DUAL; 


SPOOL all_puk_data_&&start_date..txt

SELECT	dn.dn_num,
	sm.sm_pin,
	sm.sm_puk,
	sm.sm_pin2,
	sm.sm_puk2
FROM	directory_number	dn,
	contr_devices		cd,
	storage_medium		sm,
	contr_services_cap	cs
WHERE	sm.sm_serialnum = cd.cd_sm_num
AND	cs.dn_id = dn.dn_id
AND	cd.co_id = cs.co_id
AND	cd.cd_seqno =
	(
	SELECT	MAX( cd_seqno )
	FROM	contr_devices
	WHERE	co_id = cd.co_id
	)
AND	cs.seqno =
	(
	SELECT	MAX( seqno )
	FROM	contr_services_cap
	WHERE	co_id = cs.co_id
	)
/

SPOOL OFF

SET PAGESIZE 50
SET TERMOUT ON
