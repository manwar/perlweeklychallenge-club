--
-- Perl Weekly Challenge 234
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-234/>
--

CREATE SCHEMA IF NOT EXISTS pwc234;

CREATE OR REPLACE FUNCTION
pwc234.task2_plperl( int[] )
RETURNS TABLE( i int, j int, k int )
AS $CODE$
   my ( $nums ) = @_;

   for my $i ( 0 .. $nums->@* - 3 ) {
       for my $j ( $i + 1 .. $nums->@* - 2 ) {
       	   for my $k ( $j + 1 .. $nums->@* - 1 ) {
	       return_next( { i => $i, j => $j, k => $k  } )
	       	       if ( $nums->[ $i ] != $nums->[ $j ]
	       	       	  && $nums->[ $j ] != $nums->[ $k ]
			  && $nums->[ $k ] != $nums->[ $i ] );
	   }
       }
   }

   return undef;
$CODE$
LANGUAGE plperl;
