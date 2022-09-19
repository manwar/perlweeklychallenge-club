use v6 ;

sub findCycles( Int $n is copy ) {
  my $numberstring = ~$n ;
  my @cycle ;
  my $rotated = $numberstring.substr( 1 ) ~ $numberstring.substr( 0 , 1 ) ;
  @cycle.push( +$rotated ) ;
  while ( $rotated ne $numberstring ) {
      $rotated = $rotated.substr( 1 ) ~ $rotated.substr(0 , 1 ) ;
      @cycle.push( +$rotated ) ;
  }
  return @cycle ;
}

my @circularPrimes ;
my $current = 100 ;
while ( @circularPrimes.elems != 10 ) {
  if ( ~$current !~~ /0/ ) {
      my @cycle = findCycles( $current ) ;
      my @selected = grep ( { $_ >= $current } ) , @cycle ;
      if ( (so is-prime @cycle.all) && (@selected.elems == @cycle.elems) ) {
    @circularPrimes.push( $current ) ;
      }
  }
  $current++ ;
}
say @circularPrimes.join( ', ' ) ;
