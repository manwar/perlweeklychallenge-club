use v6 ;

sub primeFactors( Int $n is copy ) {
  if ( $n == 1 ) {
      return ( ) ;
  }
  my @primeFactors ;
  my $current = 2 ;
  while ( $n != 1 ) {
      if ( $n %% $current ) {
    @primeFactors.push( $current ) ;
    $n div= $current ;
      }
      else {
    repeat {
        $current++ ;
    } until $current.is-prime ;
      }
  }
  return @primeFactors ;
}

sub isAttractive( Int $n --> Bool ) {
  my @primeFactors = primeFactors( $n ) ;
  return @primeFactors.elems.is-prime ;
}

.say for (1..50).grep( {isAttractive( $_ ) } ) ;

