-- Perl Weekly Challenge 174
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc174;

CREATE OR REPLACE FUNCTION
pwc174.task2_plpgsql_permutation2rank( input int[] )
RETURNS int
AS $CODE$
BEGIN
        RETURN pwc174.task2_permutation2rank( input );
END
$CODE$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION
pwc174.task2_plpgsql_rank2permutation( i int, input int[] )
RETURNS int[]
AS $CODE$
BEGIN
RETURN pwc174.task2_rank2permutation( i, input );
END
$CODE$
LANGUAGE plpgsql;
