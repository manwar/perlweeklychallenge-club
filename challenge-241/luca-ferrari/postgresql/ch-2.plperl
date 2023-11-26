--
-- Perl Weekly Challenge 241
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-241/>
--

CREATE SCHEMA IF NOT EXISTS pwc241;

CREATE OR REPLACE FUNCTION
pwc241.task2_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $nums ) = @_;

   my $factors = sub {
      my ( $n ) = @_;
      my $primes = [];

      for ( 2 .. $n ) {
      	  while ( $n % $_ == 0 ) {
	  	push $primes->@*, $_;
		$n /= $_;
	  }

	  last if $n == 1;
      }

      return $primes;
   };

   my $sorted = {};
   push $sorted->{ scalar( $factors->( $_ )->@* ) }->@*, $_ for ( $nums->@* );
   
   for my $key ( sort keys $sorted->%* ) {
       return_next( $_ ) for ( $sorted->{ $key }->@* );
   }

return undef;
$CODE$
LANGUAGE plperl;
