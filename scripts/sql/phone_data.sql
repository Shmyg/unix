SELECT	pv.port_num,
	dn.dn_num,
	dn.hlcode,
	dn.dealer_id,
	ca.tmcode,
	ca.customer_id,
	pv.co_id,
	ip.in_des
FROM	(
	SELECT	cs.port_num,
		cs.co_id,
		cs.dn_id,
		pv.prm_description,
		ROW_NUMBER() OVER (PARTITION BY pv.prm_value_id ORDER BY prm_seqno DESC) AS pv_rn
	FROM	(
		SELECT	cd.port_num,
			cs.co_id,
			cs.dn_id,
			ROW_NUMBER() OVER (PARTITION BY cs.co_id ORDER BY seqno DESC) AS cs_rn
		FROM	(
			SELECT	pt.port_num,
				cd.co_id,
				ROW_NUMBER() OVER (PARTITION BY cd.co_id ORDER BY cd_seqno DESC ) AS cd_rn
			FROM	port	pt,
				contr_devices	cd
			WHERE	cd.port_id = pt.port_id
			AND	cd.cd_deactiv_date IS NULL
			AND	pt.port_num = :p
			)	cd,
			contr_services_cap	cs
		WHERE	cs.co_id = cd.co_id
		AND	cd.cd_rn = 1
		)	cs,
		profile_service	ps,	
		parameter_value	pv
	WHERE	cs.co_id = ps.co_id
	AND	ps.prm_value_id = pv.prm_value_id
	AND	cs.cs_rn = 1
	AND	ps.sncode = :s
	)	pv,
	directory_number	dn,
	contract_all		ca,
	in_platform		ip
WHERE	dn.dn_id = pv.dn_id
AND	pv.co_id = ca.co_id
AND	ip.in_des = pv.prm_description
AND	pv.pv_rn = 1
/
