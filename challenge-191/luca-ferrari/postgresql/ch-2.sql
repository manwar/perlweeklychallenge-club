-- Perl Weekly Challenge 191
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc191;

CREATE OR REPLACE FUNCTION
pwc191.task2_plpgsql( n int )
RETURNS int
AS $CODE$
DECLARE
	cute_counter int := 0;
	i int;
	src int[];
	permutation int[];
	is_cute bool;
BEGIN

	FOR i IN 1 .. n LOOP
	    src = src || i;
	END LOOP;



	FOR permutation IN
	with recursive
	data as (select src as arr),
        keys as (select generate_subscripts(d.arr, 1) as rn from data d),
        cte  as (
           select d.arr initial_arr, array[d.arr[k.rn]] new_arr, array[k.rn] used_rn
           from data d
           cross join keys k
           union all
           select initial_arr, c.new_arr || c.initial_arr[k.rn], used_rn || k.rn
           from cte c
           inner join keys k on not (k.rn = any(c.used_rn))
    )
    select new_arr
    from cte
    WHERE array_length( new_arr, 1 ) = n
    LOOP

	 is_cute := 1;
	 FOR i IN 1 .. array_length( permutation, 1 ) LOOP
	 	 IF permutation[i] % i <> 0  THEN
		    is_cute = false;
		    EXIT;
		 END IF;
	 END LOOP;

	 IF is_cute THEN
	    cute_counter := cute_counter + 1;
	 END IF;

	 is_cute := 1;
	 FOR i IN 1 .. array_length( permutation, 1 ) LOOP
	 	 IF i % permutation[i] <> 0  THEN
		    is_cute = false;
		    EXIT;
		 END IF;
	 END LOOP;
	 IF is_cute THEN
		 cute_counter := cute_counter + 1;
	 END IF;

    END LOOP;


RETURN cute_counter;
END
$CODE$
LANGUAGE plpgsql;
