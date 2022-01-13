use v6 ;

my $current = 1 ;
my $number_of_primes = 0 ;
repeat {
  $current++ ;
  if ( $current.is-prime ) {
      $number_of_primes++ ;
  }
} until ( $number_of_primes == 10001 ) ;
say $current ;
