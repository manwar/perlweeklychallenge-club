-- Perl Weekly Challenge 170
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc170;

CREATE OR REPLACE FUNCTION
pwc170.task1_plperl( int)
RETURNS SETOF bigint
AS $CODE$
   my ($limit) = @_;

   # utility function to check if a
   # number if prime
   my $is_prime = sub {
      my ($value) = @_;
      for my $i ( 2 .. $value - 1 ) {
          return undef if $value % $i == 0;
      }

      return 1;
   };


   my @primes;
   for ( 1 .. 999999 ) {
       last if $#primes >= $limit;
       next if ! $is_prime->( $_ );
       push @primes, $_;

       my $v = 1;
       $v *= $_ for ( @primes );
       return_next( $v );
   }

   return undef;

$CODE$
LANGUAGE plperl;
