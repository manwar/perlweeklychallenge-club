use v6 ;

sub divideByHand( Int $n is copy --> Str ) {
  my Str $quotientstring = "0." ;
  my $number = 10 ;
  my $remainder = 0 ;
  while ( $quotientstring.chars < 2 * ( $n - 1 ) + 2 ) { #length of $n + "0."
      my $quot = $number div $n ;
      $quotientstring ~= ~$quot ;
      $remainder = $number - $quot * $n ;
      if ( $remainder == 0 ) {
    last ;
      }
      if ( $quot == 0 ) {
    $number *= 10 ;
      }
      if ( $remainder != 0 ) {
    $number = $remainder * 10 ;
      }
  }
  return $quotientstring ;
}

my @longPrimes ;
my Int $current = 2 ;
while ( @longPrimes.elems < 5 ) {
  my $quotient = divideByHand( $current ) ;
  if ( $quotient ~~ /^0 '.' (\d+) $/ ) {
      my $afterPoint = ~$0 ;
      if ( $afterPoint.chars == (2 * ( $current - 1 )) ) {
    my Int $half = $afterPoint.chars div 2 ;
    if ( substr( $afterPoint , 0 , $half) eq substr( $afterPoint, $half )) {
        @longPrimes.push( $current ) ;
    }
      }
  }
  repeat {
      $current++ ;
  } until ( $current.is-prime ) ;
}
say @longPrimes ;
