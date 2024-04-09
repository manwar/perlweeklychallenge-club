--
-- Perl Weekly Challenge 264
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-264>
--

CREATE SCHEMA IF NOT EXISTS pwc264;

CREATE OR REPLACE FUNCTION
pwc264.task2_plpgsql( s_a int[], i_a int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	target_index int;
	current_index int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS target( i int, v int );
	TRUNCATE target;

	FOR current_index IN SELECT v::int FROM unnest( i_a ) v LOOP
	    target_index := i_a[ current_index ];

	    PERFORM *
	    FROM target
	    WHERE i = target_index;

	    IF FOUND THEN
		UPDATE target
		SET i = i + 1
		WHERE i >= target_index;

	    END IF;

	    INSERT INTO target( i, v )
	    VALUES ( target_index, s_a[ current_index ] );

	END LOOP;

	RETURN QUERY
	SELECT v
	FROM target
	ORDER BY i;

END
$CODE$
LANGUAGE plpgsql;
