CREATE OR REPLACE FUNCTION
  f_working_days_per_year( yy int default extract( year from current_date ) )
  RETURNS int
AS $CODE$
  SELECT count( v )
  FROM generate_series( make_date( yy, 01, 01 ),
                       make_date( yy, 12, 31 ),
                       '1 days' ) v
  WHERE
     extract( dow from v ) NOT IN ( 0, 6 );
  $CODE$
  LANGUAGE sql;
