/*
|| This scripts finds all the customers that have exceeded credit limit
|| threshold
||
|| $Log: credit_threshold.sql,v $
|| Revision 1.1  2017/07/14 13:01:20  shmyg
|| Merged with shmyg_mis
||
|| Revision 1.1  2004/11/16 14:22:56  serge
|| *** empty log message ***
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

COLUMN begin_date new_val start_date
SELECT	TO_CHAR( SYSDATE, 'YYYYMMDDHH24MI' ) begin_date
FROM	DUAL; 

SPOOL crlimit_exceeded_&&start_date..TXT

SELECT	tr.trtext,
	dn.dn_num,
	cu.custcode,
	cc.cclname || cc.ccname || cc.ccfname
FROM	mputrtab	tr,
	mpuubtab	ub,
	contract_all	ca,
	contr_services_cap	cs,
	directory_number	dn,
	customer_all	cu,
	ccontact_all	cc
WHERE	ub.crd_tickler_o_tr = tr.tr_id
AND	ub.customer_id = ca.customer_id
AND	ca.co_id = cs.co_id
AND	cs.dn_id = dn.dn_id
AND	cu.customer_id = ca.customer_id
AND	ca.customer_id = cc.customer_id
AND	cc.ccuser = 'X'
AND	cc.ccseq =
	(
	SELECT	MAX( ccseq )
	FROM	ccontact_all
	WHERE	customer_id = ca.customer_id
	AND	ccuser = 'X'
	)
AND	cs.cs_deactiv_date IS NULL
AND	cs.main_dirnum = 'X'
ORDER	BY 1, 2
/

SPOOL OFF
