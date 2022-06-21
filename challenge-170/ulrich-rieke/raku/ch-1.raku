use v6 ;
my @primorials ;
my @firstPrimes = 1 ;
my $current = 2 ;
while ( @firstPrimes.elems != 10 ) {
  if ( $current.is-prime ) {
      @firstPrimes.push( $current ) ;
  }
  $current++ ;
}
for (0..9) -> $i {
  @primorials.push( [*] @firstPrimes[ 0 .. $i] ) ;
}
say @primorials.join( ',' ) ;
