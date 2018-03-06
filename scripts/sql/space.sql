/*
|| Procedure to show space for the object in ASSM tablespace
|| $Id: space.sql,v 1.1 2017/07/14 13:01:21 shmyg Exp $
*/

DECLARE

	i_segment_name	VARCHAR2(30);
	i_segment_owner	VARCHAR2(30) := USER;
	i_segment_type	VARCHAR2(30) := 'TABLE';

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
	v_total_blocks		NUMBER;
	v_total_bytes		NUMBER;
	v_unused_blocks		NUMBER;
	v_unused_bytes		NUMBER;
	v_last_used_extent_file_id	NUMBER;
	v_last_used_extent_block_id	NUMBER;
	v_last_used_block		NUMBER;
	v_partition_name	VARCHAR2(30);

	PROCEDURE p( p_label IN VARCHAR2, p_num IN NUMBER )
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE( RPAD(p_label,40,'.') || p_num );
	END;
BEGIN

	DBMS_OUTPUT.ENABLE(100000);
	DBMS_SPACE.SPACE_USAGE
		(
		i_segment_owner,
		UPPER( '&1' ),
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
		v_full_bytes
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

	DBMS_OUTPUT.NEW_LINE;
	DBMS_OUTPUT.PUT_LINE( 'Unused space' );
	DBMS_OUTPUT.NEW_LINE;

	DBMS_SPACE.UNUSED_SPACE
		(
		i_segment_owner,
		UPPER ( '&1' ),
		i_segment_type,
		v_total_blocks,
		v_total_bytes,
		v_unused_blocks,
		v_unused_bytes,
		v_last_used_extent_file_id,
		v_last_used_extent_block_id,
		v_last_used_block,
		v_partition_name
		);

	p( 'Total blocks', v_total_blocks );
	p( 'Total bytes', v_total_bytes );
	p( 'Unused blocks', v_unused_blocks );
	p( 'Unused bytes', v_unused_bytes );
	p( 'Last used extent file id', v_last_used_extent_file_id );
	p( 'Last used extent block id', v_last_used_extent_block_id );
	p( 'Last used block', v_last_used_block );
	p( 'Partition name', v_partition_name );

END;
/

