SELECT	dn.dn_num,
	cu.custcode,
	cu.customer_id,
	cu.cscurbalance,
	ca.co_id co_id,
	tm.des,
	cc.cclname || ' ' || cc.ccfname as customer_name,
	ch.ch_status,
	ch.ch_validfrom,
	pt.port_num
FROM	contract_all		ca,
	contr_services_cap	cs,
	directory_number	dn,
	customer_all		cu,
	mputmtab		tm,
	ccontact_all		cc,
	contract_history	ch,
	port			pt,
	contr_devices		cd
WHERE	dn.dn_id = cs.dn_id
AND	cu.customer_id = ca.customer_id
AND	cs.co_id = ca.co_id
AND	tm.tmcode = ca.tmcode
AND	cc.customer_id = ca.customer_id
AND	ch.co_id = ca.co_id
AND	cd.co_id = ca.co_id
AND	cd.port_id = pt.port_id
AND	cd.cd_deactiv_date IS NULL
AND	cs.cs_deactiv_date IS NULL
AND	tm.vscode = 0
AND	dn.dn_num = '&1'
AND     cc.ccbill = 'X'
AND	ch.ch_seqno =
	(
	SELECT	MAX( ch_seqno )
	FROM	contract_history
	WHERE	co_id = ca.co_id
	)
AND     cc.ccseq =
        (
        SELECT  MAX( ccseq )
        FROM    contract_all
        WHERE   customer_id = cc.customer_id
        AND     ccbill = 'X'
        )
/
