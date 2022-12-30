-- Perl Weekly Challenge 197
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc197;

CREATE OR REPLACE FUNCTION
pwc197.task2_plpgsql( l int[] )
RETURNS int[]
AS $CODE$
DECLARE
    i int;
    v int[];
    need_change bool := false;
    t int;
BEGIN
    need_change := true;
    v := l;
    raise info 'array %', v;

    WHILE need_change LOOP
      need_change := false;
      FOR i IN 0 .. array_length( v, 1 ) - 1 LOOP

          IF i % 2 = 0 THEN
  	   IF v[ i ] <= v[ i + 1 ] THEN
  	      need_change := true;
  	   END IF;
  	ELSE
  	  IF v[i] >= v[ i + 1 ] THEN
  	     need_change := true;
  	  END IF;
  	END IF;


  	IF need_change THEN
  	  t := v[i];
  	  v[i] := v[i + 1];
  	  v[ i + 1 ]:= t;
  	END IF;
      END LOOP;

    END LOOP;



    RETURN v;
END
$CODE$
LANGUAGE plpgsql;
