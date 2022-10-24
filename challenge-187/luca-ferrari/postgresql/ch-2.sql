-- Perl Weekly Challenge 187
-- Task 2


CREATE SCHEMA IF NOT EXISTS pwc187;

CREATE OR REPLACE FUNCTION
pwc187.task2_plpgsql( a int[] )
RETURNS int[]
AS $CODE$
BEGIN
	RETURN pwc187.task2_plperl( a );
END
$CODE$
LANGUAGE plpgsql;
