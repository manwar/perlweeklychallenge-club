CREATE SCHEMA IF NOT EXISTS pwc198;

CREATE OR REPLACE FUNCTION
pwc198.task1_plpgsql( l int[] )
RETURNS int
AS $CODE$

   with counting as (
      select v, v - lag( v, 1, v ) over w as d
      from unnest( l ) v
      window w as (order by v asc )
   )
   , max_counting as (
     select max( d ) from counting
   )
   select count(*)
   from counting
   where d = ( select * from max_counting );


$CODE$
LANGUAGE sql;
