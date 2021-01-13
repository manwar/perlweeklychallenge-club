use v6 ;

sub findDivisors( Int $n ) {
  my @divisors = (1 .. $n).grep( { $n %% $_ } ) ;
  return @divisors ;
}

sub MAIN( Int $M, Int $N ) {
  my @divisorsM = findDivisors( $M ) ;
  my @divisorsN = findDivisors( $N ) ;
  say "{(@divisorsM.Set (&) @divisorsN.Set)}" ;
}
