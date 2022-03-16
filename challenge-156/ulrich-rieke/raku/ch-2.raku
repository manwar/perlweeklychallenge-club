use v6 ;

sub findDivisors( Int $n is copy ) {
  my @divisors = ( 1 ) ;
  my $current = 2 ;
  while ( $current < $n div 2 + 1 ) {
      if ( $n %% $current ) {
    @divisors.push( $current ) ;
      }
      $current++ ;
  }
  return @divisors ;
}

sub MAIN( $n is copy ) {
  my @divisors = findDivisors( $n ) ;
  my Bool $isWeird = True ;
  if ( ([+] @divisors) <= $n ) {
      $isWeird = False ;
  }
  else {
      for ( 2 .. @divisors.elems - 1 ) -> $i {
    my @sums = @divisors.combinations( $i ).map( {.sum} ) ;
    for (0 .. @sums.elems - 1 ) -> $j {
        if ( @sums[ $j ] == $n ) {
          $isWeird = False ;
        }
    }
      }
  }
  if ( $isWeird ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
