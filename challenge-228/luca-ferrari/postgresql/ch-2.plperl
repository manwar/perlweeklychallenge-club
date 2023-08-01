--
-- Perl Weekly Challenge 228
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-228/>
--

CREATE SCHEMA IF NOT EXISTS pwc228;

CREATE OR REPLACE FUNCTION
pwc228.task2_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $array ) = @_;
   my $moves = 0;

   # a function to find out the min value
   my $min = sub {
      my $min = undef;
      for ( $_[0]->@* ) {
      	  $min = $_ if ( ! $min || $min > $_ );
      }

      return $min;
   };

   while ( scalar $array->@* ) {
   	 my ( $swap, $min ) = ( shift( $array->@* ), $min->( $array ) );
	 $moves++; 
	 last if ! $swap;
	 last if ! $min;
	 push $array->@*, $swap  if ( $swap > $min );

   }

   return $moves;
$CODE$
LANGUAGE plperl;
