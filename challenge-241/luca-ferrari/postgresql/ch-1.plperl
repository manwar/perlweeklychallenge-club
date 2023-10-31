--
-- Perl Weekly Challenge 241
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-241/>
--

CREATE SCHEMA IF NOT EXISTS pwc241;

CREATE OR REPLACE FUNCTION
pwc241.task1_plperl( int[], int )
RETURNS int
AS $CODE$
   my ( $nums, $diff ) = @_;
   my @triplets;

   for my $i ( 0 .. $nums->@* - 1) {
       for my $j ( $i + 1 .. $nums->@* - 1) {
       	   for my $k ( $j + 1 .. $nums->@* - 1) {
	       if ( ( $nums->[ $k ] - $nums->[ $j ] ) == ( $nums->[ $j ] - $nums->[ $i ] )
	       	  && ( $nums->[ $k ] - $nums->[ $j ] ) == $diff ) {
		  push @triplets, [ $nums->[ $k ], $nums->[ $j ], $nums->[ $i ] ];
	      }
	   }
       }
   }

   return scalar @triplets;
$CODE$
LANGUAGE plperl;
