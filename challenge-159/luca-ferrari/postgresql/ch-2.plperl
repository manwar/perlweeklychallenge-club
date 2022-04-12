CREATE SCHEMA IF NOT EXISTS pwc159;

/**
testdb=> select pwc159.mobius( 5 );
 mobius 
--------
     -1
(1 row)

*/
CREATE OR REPLACE FUNCTION
pwc159.mobius( int )
RETURNS int
AS $CODE$

   my ( $n ) = @_;

   # a routine to compute the prime
   # factors of the given number
   my $prime_factors = sub {
      my ( $number ) = @_;
      my %factors;

      my $factor = 2;
      while (  $number > 1 && $factor <= $number ) {
            if ( $number % $factor == 0 ) {
               $factors{ $factor }++;
               $number /= $factor;
            }
            else {
                 $factor++;
            }
      }

      return %factors;
   };


   my %prime_factors = $prime_factors->( $n );

   # to get the unique prime factors I have to "count"
   # them only once per key
   my @unique_prime_factors;
   my $occurrencies_prime_factors = 0;
   for ( keys %prime_factors ) {
       push @unique_prime_factors, $_;
       $occurrencies_prime_factors += $prime_factors{ $_ };
   }


   return 0 if @unique_prime_factors != $occurrencies_prime_factors;
   return 1 if @unique_prime_factors % 2 == 0;
   return -1;


$CODE$
LANGUAGE plperl;
