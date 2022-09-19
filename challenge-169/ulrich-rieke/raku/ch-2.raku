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

sub isAchillesNumber( Int $n is copy --> Bool ) {
  my @primeFactors = primeDecompose( $n ) ;
  my %achilles ;
  for @primeFactors -> $i {
      %achilles{~$i}++ ;
  }
  return (%achilles.values.min >= 2) && (([gcd] %achilles.values) == 1 ) ;
}

my @achillesNumbers ;
my $current = 2 ;
while (@achillesNumbers.elems != 20 ) {
  if ( isAchillesNumber( $current ) ) {
      @achillesNumbers.push( $current ) ;
  }
  $current++ ;
}
say @achillesNumbers.join( ', ' ) ;
