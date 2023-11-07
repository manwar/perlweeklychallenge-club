--
-- Perl Weekly Challenge 242
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-242/>
--

CREATE SCHEMA IF NOT EXISTS pwc242;

/*
 * testdb=> select * from pwc242.task1_plperl( array[1,2,3], array[2,4,6] );
 left  | right 
-------+-------
 {4,6} | {1,3}
*/
CREATE OR REPLACE FUNCTION
pwc242.task1_plperl( int[], int[] )
RETURNS TABLE( left int[], right int[] )
AS $CODE$
   my ( $left, $right ) = @_;

   my $missing_left = [];
   my $missing_right = [];

   for my $current ( $left->@* ) {
       push $missing_right->@*, $current if ( ! grep( { $_ == $current } $right->@* ) );
   }

   for my $current ( $right->@* ) {
       push $missing_left->@*, $current if ( ! grep( { $_ == $current } $left->@* ) );
   }

   return_next( { left => $missing_left,
   		  right => $missing_right } );

   return undef;
$CODE$
LANGUAGE plperl;
