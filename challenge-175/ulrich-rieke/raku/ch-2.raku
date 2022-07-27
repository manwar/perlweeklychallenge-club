use v6 ;

sub myPhi( Int $n --> Int ) {
  return (1 .. $n - 1).grep( { $_ gcd $n == 1 }).elems ;
}

sub isPerfectTotient( Int $n is copy --> Bool ) {
  if ( $n == 1 ) {
      return False ;
  }
  my @totatives ;
  my Int $current = $n ;
  repeat {
      $current = myPhi( $current ) ;
      @totatives.push( $current ) ;
  } until ( $current == 1 ) ;
  return ([+] @totatives) == $n ;
}

my @perfectTotients ;
my Int $current = 1 ;
while ( @perfectTotients.elems != 20 ) {
  if ( isPerfectTotient( $current ) ) {
      @perfectTotients.push( $current ) ;
  }
  $current++ ;
}
say @perfectTotients ;
