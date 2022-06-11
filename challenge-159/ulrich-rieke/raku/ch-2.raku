use v6 ;

#for theoretical reasons, the smallest divisor of a number must be prime

subset Positive of Int where * > 0 ;
sub primeDecomposition( Positive $n is copy ) {
  my @primeNumbers ;
  my $current = 1 ;
  while ( $n != 1 ) {
      repeat {
    $current++ ;
      } until ( $n %% $current ) ;
      @primeNumbers.push( $current ) ;
      $n div= $current ;
      $current-- ; # a prime factor might be repeated, in the non-squarefree
              # numbers
  }
  return @primeNumbers ;
}

sub MAIN( Positive $n is copy ) {
  my @primeNumbers = primeDecomposition( $n ) ;
  my $primeSet = @primeNumbers.Set ;
  my $setLen = $primeSet.elems ;
  my $arrayLen = @primeNumbers.elems ;
  if ( $setLen == $arrayLen ) { # square-free!
      if ( $arrayLen %% 2 ) {
    say 1 ;
      }
      else {
    say -1 ;
      }
  }
  else {
      say 0 ;
  }
}
