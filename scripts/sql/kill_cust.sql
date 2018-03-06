SET VERIFY OFF
ACCEPT	customer PROMPT 'Enter username: '
DECLARE
	CURSOR	customer_cur IS
	SELECT	sid,
		serial#
	FROM	v$session
	WHERE	username = UPPER( '&customer' );

	customer_rec customer_cur%ROWTYPE;

BEGIN

	OPEN	customer_cur;
	LOOP 
		FETCH	customer_cur
		INTO	customer_rec;
		EXIT	when customer_cur%notfound;
		
		EXECUTE	IMMEDIATE
			'ALTER SYSTEM KILL SESSION' || '''' ||
			customer_rec.sid || ',' ||
			customer_rec.serial# || '''';
	
	END	LOOP;

	CLOSE	customer_cur;
END;
/