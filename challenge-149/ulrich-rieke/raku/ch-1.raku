use v6 ;

sub inFibo( $n , @numbers ) {
  return $n == 0 || $n == 1 || $n (elem) @numbers[2..@numbers.elems - 1].Set ;
}

sub MAIN( Int $N ) {
  my @fibonaccis = (0 , 1) ;
  while ( @fibonaccis.elems < 8 ) {
      @fibonaccis.push( @fibonaccis[*-1] + @fibonaccis[*-2] ) ;
  }
  my @fibonacciDigitSum ;
  my $current = -1 ;
  my $sumOfDigits ;
  while ( @fibonacciDigitSum.elems < $N ) {
      $current++ ;
      $sumOfDigits = (~$current).comb.map( {.Int} ).sum ;
      if ( inFibo( $sumOfDigits , @fibonaccis) ) {
    @fibonacciDigitSum.push( $current ) ;
      }
      if ( $sumOfDigits > @fibonaccis[*-1] ) {
    repeat {
        @fibonaccis.push( @fibonaccis[*-1] + @fibonaccis[*-2] ) ;
    } until ( $sumOfDigits < @fibonaccis[*-1] ) ;
      }
    }
  say @fibonacciDigitSum.join( ',' ) ;
}
