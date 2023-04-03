--
-- Perl Weekly Challenge 211
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-211/>
--

CREATE SCHEMA IF NOT EXISTS pwc211;

-- see <https://wiki.postgresql.org/wiki/Permutations>
CREATE FUNCTION pwc211.permute(anyarray)
  RETURNS SETOF anyarray
  LANGUAGE SQL IMMUTABLE
AS $f$
  SELECT (WITH RECURSIVE r(n,p,a,b)
               AS (SELECT i, $1[1:0], $1, array_upper($1,1)
                   UNION ALL
                   SELECT n / b, p || a[n % b + 1], a[1:n % b] || a[n % b + 2:b], b-1
                     FROM r
                    WHERE b > 0)
          SELECT p FROM r WHERE b=0)
  FROM generate_series(0,factorial( (array_upper($1,1)) )::integer-1) i;
$f$;




CREATE OR REPLACE FUNCTION
pwc211.task2_plpgsql( a int[] )
RETURNS SETOF int[]
AS $CODE$
DECLARE
	split_at int := 0;
	current_array int[];
	l int[];
	r int [];
	avg_l numeric;
	avg_r numeric;
BEGIN
	split_at := array_length( a, 1 ) / 2;

	FOR current_array IN SELECT * FROM pwc211.permute( a ) LOOP
	    l := current_array[ 1:split_at ];
	    r := current_array[ (split_at + 1): array_length( a, 1 ) ];


	    SELECT avg( v )
	    INTO   avg_l
	    FROM   unnest( l ) v;

	    SELECT avg( v )
	    INTO   avg_r
	    FROM   unnest( r ) v;

	    IF avg_r = avg_l THEN
	       RETURN NEXT l;
	       RETURN NEXT r;
	       RETURN;
	    END IF;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
