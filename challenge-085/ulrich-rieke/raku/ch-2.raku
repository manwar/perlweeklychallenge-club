use v6 ;
sub MAIN( Int $N ) {
#the integer can't be greater than the square root
  my $upperLimit = floor( sqrt( $N ) ) ;
  my $powerCombis = 0 ;
  for (2 .. $upperLimit) -> $i {
      my $exponent = 2 ;
      my $power = $i ** $exponent ;
      while ( $power < $N ) {
    $exponent++ ;
    $power = $i ** $exponent ;
      }
#if the power is equal $N we have a solution, otherwise not
      if ( $power == $N ) {
    $powerCombis = 1 ;
    last ;
      }
  }
  say $powerCombis ;
}
