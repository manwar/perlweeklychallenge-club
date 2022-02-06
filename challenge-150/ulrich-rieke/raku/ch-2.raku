use v6 ;

sub primeFactorization( Int $n is copy ) {
  my @possibleFactors ;
  my @factors ;
  if ( $n == 1 ) {
      @factors.push( 1 ) ;
  }
  else {
      if ( $n.is-prime ) {
    @factors.push( 1 , $n ) ;
      }
      else {
    @possibleFactors = (2 .. $n div 2).grep( {.is-prime} ) ;
    @factors.push( 1 ) ;
    while ( $n != 1 ) {
        my $nextFactor = @possibleFactors.shift ;
        while ( $n %% $nextFactor ) {
          @factors.push( $nextFactor ) ;
          $n div= $nextFactor ;
        }
    }
      }
  }
  return @factors ;
}

sub isSquareFree( Int $n is copy --> Bool ) {
  my @primeFactors = primeFactorization( $n ) ;
  my $primeSet = @primeFactors.Set ;
  return $primeSet.elems == @primeFactors.elems ;
}

my @square-frees ;
my $current = 1 ;
while ( $current < 501 ) {
  if ( isSquareFree( $current ) ) {
      @square-frees.push( $current ) ;
  }
  $current++ ;
}
say join( ',' , @square-frees ) ;
