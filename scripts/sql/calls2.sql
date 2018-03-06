SET PAGESIZE 100
SET VERIFY OFF
BREAK ON REPORT SKIP 1
COMP SUM OF total_amount ON REPORT
COMP SUM OF total_length ON REPORT
COMP SUM OF real_amount ON REPORT
COL service for a30
COL b_party for a30
--ACCEPT	customer_id PROMPT 'Enter customer_id: '
--ACCEPT	co_id PROMPT 'Enter co_id: '
SELECT	SUBSTR( TO_CHAR( start_time_timestamp + start_time_offset/86400, 'DD.MM hh24:mi'), 1, 15) AS start_time,
	DECODE( follow_up_call_type, 1, 'Outgoing', 2, 'Incoming' ),
	sn.des AS service,
--	s_p_equipment_number,
	SUBSTR( MAX( o_p_number_address ), 1, 16 ) AS b_party,
	MAX( rated_volume ) total_length,
	SUM( rated_flat_amount ) total_amount,
	DECODE( ROUND( SUM( rated_flat_amount - free_charge_amount ), 2 ),
			NULL, ROUND( SUM( rated_flat_amount ), 2),
			ROUND( SUM( rated_flat_amount - free_charge_amount ), 2 )) real_amount
FROM	rtx_lt,
	mpusntab	sn
WHERE	cust_info_customer_id = &&1
AND	cust_info_contract_id = &&2
AND	tariff_info_sncode = sn.sncode
AND	follow_up_call_type IN ( 1, 2 )
--GROUP	BY start_time_timestamp + start_time_offset/86400,
--	DECODE( follow_up_call_type, 1, 'Outgoing', 2, 'Incoming' ),
--	sn.des,
--	s_p_equipment_number,
--	o_p_number_address,
--	rated_volume
ORDER	BY 1
/

SET PAGESIZE 50
