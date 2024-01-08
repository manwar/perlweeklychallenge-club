--
-- Perl Weekly Challenge 248
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-248/>
--

CREATE SCHEMA IF NOT EXISTS pwc248;

CREATE OR REPLACE FUNCTION
pwc248.task2_plperl( int[] )
RETURNS int[]
AS $CODE$
   my ( $matrix ) = @_;

   my $result = [];

   for my $row ( 0 .. $matrix->@* - 1 ) {
       $result->[ $row ] = [];
       
       for my $col ( 0 .. $matrix->@* - 1 ) {
       	   $result->[ $row ][ $col ] = $matrix->[ $row ][ $col ] + $matrix->[ $row ][ $col + 1 ] + $matrix->[ $row + 1 ][ $col ] + $matrix->[ $row + 1 ][ $col + 1 ];
       }
   }

   return $result;
   
$CODE$
LANGUAGE plperl;
