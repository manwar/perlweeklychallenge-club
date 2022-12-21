-- Perl Weekly Challenge 196
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc196;

CREATE OR REPLACE FUNCTION
pwc196.task2_plperl( int[] )
RETURNS SETOF int[]
AS $CODE$
  my ( $array ) = $_[0];
  my ( $start, $end ) = ( 0, 0 );

  while ( $start < $array->@* ) {
     $end = $start;
     $end++ while ( $end < $array->@* &&   $array->[ $end + 1 ] == $array->[ $end ] + 1 );
     return_next( [ $start, $end ] ) if ( $end > $start );
     $start += $end + 1;
  }

return undef;
  
$CODE$
LANGUAGE plperl;
