CREATE OR REPLACE FUNCTION
  f_split_numbers( n int default 9801 )
  RETURNS int
AS $CODE$
  DECLARE
  sqrt int := sqrt( n );
  digits int[] := regexp_split_to_array( n::text, '' );
  aggregation int := 0;
  sum_left int := 0;
  sum_right int := 0;
BEGIN
  RAISE DEBUG 'Operating for % (sqrt = %)', n, sqrt;

  FOR aggregation IN 1 .. length( n::text ) LOOP
    RAISE DEBUG 'Aggregation index %', aggregation;

    SELECT array_to_string( digits[1:aggregation], '' )::int
           , sum( r )
      FROM ( SELECT unnest( digits[ aggregation + 1: length( n::text ) ] ) AS r ) rr
      INTO sum_left, sum_right;

    RAISE DEBUG '% + %', sum_left, sum_right;

    IF ( sum_left + sum_right ) = sqrt THEN
      RETURN 1;
    END IF;
  END LOOP;

  RETURN 0;
END
  $CODE$
  LANGUAGE plpgsql;


