use v6 ;

sub prime-factorize( Int $n is copy ) {
  my @primeFactors = ( ) ;
  my $current = 2 ;
  while ( $n != 1 ) {
      if ( $n %% $current ) {
    $n div= $current ;
    @primeFactors.push( $current ) ;
      }
      else {
    repeat {
        $current++ ;
    } until ( $current.is-prime ) ;
      }
  }
  return @primeFactors ;
}

sub isComposite( Int $n is copy --> Bool ) {
  return ( (not $n.is-prime) && ($n != 1 ) ) ;
}

sub toDigitSum( Int $s is copy --> Int ) {
  if ( $s < 10 ) {
      return $s ;
  }
  else {
      return [+] (~$s).comb.map( {.Int} ) ;
  }
}

sub isSmithNumber( Int $d is copy --> Bool) {
  my $digitsum = toDigitSum( $d ) ;
  my @primeFactors = prime-factorize( $d ) ;
  my %factorCount ;
  @primeFactors.map( { %factorCount{$_}++ } ) ;
  my $factorSum ;
  for %factorCount.kv -> $key , $value {
      $factorSum += (toDigitSum( +$key ) * $value ) ;
  }
  return ($factorSum == $digitsum) ;
}

my @smithNumbers = ( ) ;
my Int $current = 0 ;
while ( @smithNumbers.elems < 10 ) {
  $current++ ;
  if ( ( isComposite( $current ) ) && isSmithNumber( $current ) ) {
      @smithNumbers.push( $current ) ;
  }
}
say @smithNumbers.join( ", ") ;
