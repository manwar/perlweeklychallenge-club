--
-- Perl Weekly Challenge 242
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-242/>
--

CREATE SCHEMA IF NOT EXISTS pwc242;

/*
testdb=> select pwc242.task1_plpgsql( array[1,2,3], array[2,4,6,7] );
 task1_plpgsql
---------------
 (FIRST,1)
 (FIRST,3)
 (SECOND,4)
 (SECOND,6)
 (SECOND,7)

*/
CREATE OR REPLACE FUNCTION
pwc242.task1_plpgsql( left_array int[], right_array int[] )
RETURNS TABLE( which_array text, v int )
AS $CODE$
	SELECT 'FIRST', la
	FROM  unnest( left_array ) la
	WHERE la NOT IN ( SELECT unnest( right_array ) )

	UNION ALL

	SELECT 'SECOND', ra
	FROM  unnest( right_array ) ra
	WHERE ra NOT IN ( SELECT unnest( left_array ) );
$CODE$
LANGUAGE sql;
