/*
|| Procedure to calculate size of a partitioned table
|| $Id: part_table_size.prc,v 1.1 2017/07/14 13:01:21 shmyg Exp $
*/

CREATE	OR REPLACE
PROCEDURE	part_table_size
	(
	i_segment_name	IN VARCHAR2,
	i_partition_name IN VARCHAR2,
	i_segment_owner	IN VARCHAR2 := USER,
	i_segment_type	IN VARCHAR2 := 'TABLE SUBPARTITION'
	)
AUTHID	CURRENT_USER
AS

	v_unformatted_blocks	NUMBER;
	v_unformatted_bytes	NUMBER;
	v_fs1_blocks		NUMBER;
	v_fs1_bytes		NUMBER;
	v_fs2_blocks		NUMBER;
	v_fs2_bytes		NUMBER;
	v_fs3_blocks		NUMBER;
	v_fs3_bytes		NUMBER;
	v_fs4_blocks		NUMBER;
	v_fs4_bytes		NUMBER;
	v_full_blocks		NUMBER;
	v_full_bytes		NUMBER;
	v_total_size	NUMBER := 0;

	PROCEDURE p( p_label IN VARCHAR2, p_num IN NUMBER )
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE( RPAD(p_label,40,'.') || p_num );
	END;

BEGIN

	FOR	data_rec IN
		(
		SELECT	partition_name
		FROM	dba_tab_partitions
		WHERE	table_name = i_segment_name
		AND	partition_name = i_partition_name
		)
	LOOP
			DBMS_SPACE.SPACE_USAGE
				(
				i_segment_owner,
				i_segment_name,
				i_segment_type,
				v_unformatted_blocks,
				v_unformatted_bytes,
				v_fs1_blocks,
				v_fs1_bytes,
				v_fs2_blocks,
				v_fs2_bytes,
				v_fs3_blocks,
				v_fs3_bytes,
				v_fs4_blocks,
				v_fs4_bytes,
				v_full_blocks,
				v_full_bytes,
				data_rec.partition_name
				);


	p( 'Unformatted blocks', v_unformatted_blocks );
	p( 'Unformatted bytes', v_unformatted_bytes );
	p( '0-25% free blocks', v_fs1_blocks );
	p( '0-25% free bytes', v_fs1_bytes );
	p( '25-50% free blocks', v_fs2_blocks );
	p( '25-50% free bytes', v_fs2_bytes );
	p( '50-75% free blocks', v_fs3_blocks );
	p( '50-75% free bytes', v_fs3_bytes );
	p( '75-100% free blocks', v_fs4_blocks 	);
	p( '75-100% free bytes', v_fs4_bytes );
	p( 'Full blocks', v_full_blocks );
	p( 'Full bytes', v_full_bytes );


	end	loop;
END;
/

