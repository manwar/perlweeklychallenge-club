--
-- Perl Weekly Challenge 253
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
--

CREATE SCHEMA IF NOT EXISTS pwc253;

/**
 * Example of invocation
 testdb=> select pwc253.task2_plperl( array[ [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1] ] );
*/
CREATE OR REPLACE FUNCTION
pwc253.task2_plperl( int[] )
RETURNS SETOF int
AS $CODE$

   my ( $matrix ) = @_;

   my $ones = {};

   for my $row_index ( 0 .. $matrix->@* - 1 ) {
       my $count = scalar grep { $_ == 1 } $matrix->[ $row_index ]->@*;
       push $ones->{ $count }->@*, $row_index;
   }

   for my $count ( sort keys $ones->%* ) {
       return_next( $_ ) for ( sort $ones->{ $count }->@* );
   }

return undef;
   
$CODE$
LANGUAGE plperl;
