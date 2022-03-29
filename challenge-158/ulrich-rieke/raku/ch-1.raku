use v6 ;

sub isAdditivePrime( Int $n is copy --> Bool ) {
  my $sum = [+] (~$n).comb.map( {.Int} ) ;
  return $sum.is-prime && $n.is-prime ;
}

my @additivePrimes ;
my $current = 1 ;
repeat {
  $current++ ;
  if ( isAdditivePrime( $current ) ) {
      @additivePrimes.push( $current ) ;
  }
} until ( @additivePrimes[*-1] > 100 ) ;
say @additivePrimes[0 .. @additivePrimes.elems - 2].join( ',' ) ;
