SELECT	caxact,
	customer_id,
	carecdate,
	caentdate,
	cachknum,
	cachkamt_gl,
	cacuramt_gl,
	catype,
	careasoncode,
	catransfer,
	causername
FROM	cashreceipts_all
WHERE	customer_id = &1
ORDER	BY carecdate
/
