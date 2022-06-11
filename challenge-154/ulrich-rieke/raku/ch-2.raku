use v6 ;

my @padovans = ( 1 , 1 , 1 ) ;
my @padovanPrimes ;
while ( @padovanPrimes.elems < 10 ) {
  @padovans.push( @padovans[0] + @padovans[1] ) ;
  my $last = @padovans[*-1] ;
  if ( $last.is-prime and not $last (elem) @padovanPrimes.Set) {
      @padovanPrimes.push( $last ) ;
  }
  @padovans.shift ;
}
@padovanPrimes.join( ',' ).say ;
