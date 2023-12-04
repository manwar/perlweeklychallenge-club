--
-- Perl Weekly Challenge 246
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-246/>
--

CREATE SCHEMA IF NOT EXISTS pwc246;

CREATE OR REPLACE FUNCTION
pwc246.task2_plperl( int[] )
RETURNS bool
AS $CODE$
   my ( $nums ) = @_;

   die "Need 5 numbers" if ( $nums->@* != 5 );
   my $ok = 0;
   my $ko = $nums->@* - 2;
   
   for ( 2 .. $nums->@* - 1 ) {
       for ( my $p = 1; ; $p++ ) {
       	   for ( my $q = 1; ; $q++ ) {
	      if ( $nums->@[ $_ ] == ( $p * $nums->[ $_ - 2 ] + $q * $nums->[ $_ - 1 ] )
	         || $nums->@[ $_ ] == ( $p * -1 * $nums->[ $_ - 2 ] + $q * $nums->[ $_ - 1 ] )
	         || $nums->@[ $_ ] == ( $p * -1 * $nums->[ $_ - 2 ] + $q * -1 * $nums->[ $_ - 1 ] )
	         || $nums->@[ $_ ] == ( $p * $nums->[ $_ - 2 ] + $q * -1 * $nums->[ $_ - 1 ] ) ) {

	         $ok = 1;
		 $ko--;
	         last;
	      }
          }

          last if $ok;
      }
   }

   return ( $ko == 0 );
$CODE$
LANGUAGE plperl;
