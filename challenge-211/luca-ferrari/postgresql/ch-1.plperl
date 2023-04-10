--
-- Perl Weekly Challenge 211
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-211/>
--

CREATE SCHEMA IF NOT EXISTS pwc211;

/*
testdb=> select pwc211.task1_plperl( array[ array[4,3,2,1], array[ 5,4,3,2], array[6,5,4,3] ] );
 task1_plperl 
--------------
 t
(1 row)

*/
CREATE OR REPLACE FUNCTION
pwc211.task1_plperl( int[][] )
RETURNS bool
AS $CODE$
   my ( $array ) = @_;

   my $diag;
   $diag->{ $array->[ $_ ]->[ $_ ] }++ for ( 0 .. scalar( $array->@* ) - 1 );
   return 0 if ( keys( $diag->%* ) != 1 );
   return 0 if ( $diag->{ $array->[ 0 ]->[ 0 ] } != scalar( $array->@* ) );
   return 1;
$CODE$
LANGUAGE plperl;
