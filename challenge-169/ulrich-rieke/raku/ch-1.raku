use v6 ;

sub primeDecompose( Int $n is copy ) {
  my @primeFactors ;
  my $current = 2 ;
  while ( $n != 1 ) {
      while ( not ( $n %% $current ) ) {
        $current++ ;
      }
      @primeFactors.push( $current ) ;
      $n div= $current ;
  }
  return @primeFactors ;
}

sub isBrilliant( Int $n is copy --> Bool ) {
  my @primeFactors = primeDecompose( $n ) ;
  return ( @primeFactors.elems == 2 ) && ( ~(@primeFactors[0]).chars ==
    ~(@primeFactors[1].chars )) ;
}

my @brilliantNumbers ;
my $current = 2 ;
while ( @brilliantNumbers.elems != 20 ) {
  if ( isBrilliant( $current ) ) {
      @brilliantNumbers.push( $current ) ;
  }
  $current++ ;
}
say @brilliantNumbers.join( ',') ;
