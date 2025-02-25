--
-- Perl Weekly Challenge 297
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-297>
--

CREATE SCHEMA IF NOT EXISTS pwc297;

CREATE OR REPLACE FUNCTION
pwc297.task1_plpgsql( bits bit[] )
RETURNS int
AS $CODE$
DECLARE
	i_begin int;
	i_end   int;
	max_length int := 0;
	zeros int;
	ones  int;
	current_length int;
BEGIN

	for i_begin in 1 .. array_length( bits, 1 ) - 1 loop
	    for i_end in i_begin + 1 .. array_length( bits, 1 ) loop

	    	current_length := i_end - i_begin + 1;

	    	SELECT count( v )
		INTO ones
		FROM unnest( bits[ i_begin : i_end ] ) v
		WHERE v = 1::bit;

	    	SELECT count( v )
		INTO zeros
		FROM unnest( bits[ i_begin : i_end ] ) v
		WHERE v = 0::bit;

		IF zeros <> ones OR current_length < max_length THEN
		   continue;
		END IF;

		max_length := current_length;


	    end loop;
	end loop;

	return max_length;
END
$CODE$
LANGUAGE plpgsql;
