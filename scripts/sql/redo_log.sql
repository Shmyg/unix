SELECT	le.leseq	CURRENT_LOG_SEQUENCE#,
	100*cp.cpodr_bno/LE.lesiz	PERCENTAGE_FULL
from	x$kcccp cp,x$kccle le
WHERE	LE.leseq =CP.cpodr_seq
/

