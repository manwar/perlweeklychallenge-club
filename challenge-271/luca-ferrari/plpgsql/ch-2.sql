--
-- Perl Weekly Challenge 271
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-271>
--

CREATE SCHEMA IF NOT EXISTS pwc271;

CREATE OR REPLACE FUNCTION
pwc271.task2_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	current_number int;
	binary_number bit(8);
	ones int;
BEGIN
	CREATE TABLE IF NOT EXISTS binary_table( i int, v int );
	TRUNCATE binary_table;

	FOREACH current_number IN ARRAY nums LOOP
		binary_number := current_number::bit( 8 );

		SELECT count(*)
		INTO ones
		FROM regexp_split_to_table( binary_number::text, '' ) v
		WHERE v::int = 1;

		INSERT INTO binary_table
		VALUES( ones, current_number );
	END LOOP;

	RETURN QUERY SELECT v
	FROM binary_table
	ORDER BY i ASC, v ASC;

END
$CODE$
LANGUAGE plpgsql;
