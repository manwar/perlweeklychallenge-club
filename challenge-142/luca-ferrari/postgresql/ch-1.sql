CREATE OR REPLACE FUNCTION
  f_divisors_last_digit( m int, n int )
  RETURNS SETOF int
AS $CODE$
  WITH RECURSIVE numbers AS (
    SELECT 1 as num
     UNION
    SELECT num + 1
      FROM numbers
     WHERE num + 1 <= m )
  , divisors AS (
    SELECT num as div
      FROM numbers
      WHERE m % num = 0 )
  SELECT count(*)
  FROM divisors
  WHERE div::text LIKE ( '%' || n::text );

  $CODE$
  LANGUAGE sql;
