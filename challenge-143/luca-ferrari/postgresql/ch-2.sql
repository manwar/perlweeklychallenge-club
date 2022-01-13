CREATE OR REPLACE FUNCTION f_stealth( needle int )
  RETURNS int
AS $CODE$
  WITH numbers AS ( SELECT generate_series( 2, needle ) as n )
  , pairs AS ( 
    SELECT needle as n
           , n as divisor
           , needle / n as divisor_2
           , case needle % n
             when 0 then n + needle / n
             else null
             end as summix
      from numbers
  )
  , stealth as (
    select *
           , abs( summix - lag( summix, 1, summix )  over ( ORDER BY summix DESC ) ) as lag
           , abs( summix - lead( summix, 1, summix )  over ( ORDER BY summix DESC ) ) as lead
      FROM pairs
     where summix is not null
  )

  SELECT CASE count(*)
         WHEN 0 THEN 0
         ELSE 1
           END
  FROM stealth
  WHERE ( lag = 1 or lead = 1 );


  $CODE$
    LANGUAGE sql;
