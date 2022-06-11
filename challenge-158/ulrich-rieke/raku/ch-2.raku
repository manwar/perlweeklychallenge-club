use v6 ;

my @cubanPrimes ;
my $current = 0 ;
repeat {
  $current++ ;
  my $sum = 3 * $current ** 2 + 3 * $current + 1 ;
  if ( $sum.is-prime ) {
      @cubanPrimes.push( $sum ) ;
  }
} until ( @cubanPrimes[*-1] > 1000 ) ;

say @cubanPrimes[0 .. @cubanPrimes.elems - 2].join( ',' ) ;
