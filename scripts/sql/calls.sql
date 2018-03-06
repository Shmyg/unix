SET PAGESIZE 100
SET VERIFY OFF
BREAK ON REPORT SKIP 1
COMP SUM OF total_amount ON REPORT
COMP SUM OF total_length ON REPORT
COMP SUM OF real_amount ON REPORT
COL service for a30
COL b_party for a20
COL call_type for a20
COL start_time for a20
SELECT	SUBSTR( TO_CHAR( start_time_timestamp + start_time_offset/86400, 'DD.MM hh24:mi'), 1, 15) AS start_time,
	DECODE( follow_up_call_type, 1, 'Outgoing', 2, 'Incoming' ) AS call_type,
	sn.des AS service,
	SUBSTR( o_p_number_address, 1, 16 ) AS b_party,
	SUBSTR(o_p_normed_num_address, 1, 20) AS normed_b_party,
	rated_volume,
	ROUND( rated_flat_amount, 2),
	ROUND( free_charge_amount, 2)
FROM	rtx_lt,
	mpusntab	sn
WHERE	cust_info_customer_id = &&1
AND	cust_info_contract_id = &&2
AND	tariff_info_sncode = sn.sncode
AND	follow_up_call_type IN ( 1, 2 )
ORDER	BY start_time,
	b_party
/

SET PAGESIZE 50
