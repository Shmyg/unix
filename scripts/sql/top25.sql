DECLARE
	top25	NUMBER;
	text1	VARCHAR2(1000);
	x	NUMBER;
	len1	NUMBER;
	CURSOR	c1
	IS
	SELECT	buffer_gets,
		sql_text
	FROM	v$sqlarea
	ORDER	BY buffer_gets DESC;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Gets'||'    '||'Text');
	DBMS_OUTPUT.PUT_LINE('-----'||' '||'-----------');
	OPEN	c1;
		FOR	i IN 1..25
		LOOP
		FETCH	c1
		INTO	top25,
			text1;

		DBMS_OUTPUT.PUT_LINE(RPAD(TO_CHAR(top25),9)||' '||SUBSTR(text1,1,66));

		len1:= LENGTH(text1);
		x:=66;
		WHILE	len1 > x-1
		LOOP
			DBMS_OUTPUT.PUT_LINE('"         '|| SUBSTR(text1,x,66));
			x:=x + 66;
		END	LOOP;
	END	LOOP;
END;
/
