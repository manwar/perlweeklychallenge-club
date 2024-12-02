--
-- Perl Weekly Challenge 298
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-298>
--

CREATE SCHEMA IF NOT EXISTS pwc298;

CREATE OR REPLACE FUNCTION
pwc298.task1_plpgsql( matrix int[][] )
RETURNS int
AS $CODE$
DECLARE
	r int;
	c int;
	ok boolean;
	square int;
BEGIN

	create temporary table if not exists t_squares( s int, from_row int, from_col int );
	truncate t_squares;

	for r in 1 .. array_length( matrix, 1 ) loop

	    for c in 1 .. array_length( matrix, 2 ) loop

	    	if matrix[ r ][ c ] <> 1 then
		   continue;
		end if;


		square := 1;
		ok := true;
		<<restart>>

		while ok and r + square < array_length( matrix, 1 ) and c + square < array_length( matrix, 2 ) loop
		      for rr in r .. r + square loop
		      	  if not ok then
			     exit;
			  end if;

		      	  for cc in c .. c + square loop
			      if matrix[ rr ][ cc ] <> 1 then
			      	 ok := false;
				 square := square - 1;
				 exit;
			      end if;
			  end loop;

		      end loop;

		     insert into t_squares
		     values( square + 1, r, c );

		     square := square + 1;

		end loop restart;
		      raise info 'Fine while';
	    end loop;
	end loop;



        select max( s )
	into r
	from t_squares;

	return r;
END
$CODE$
LANGUAGE plpgsql;
