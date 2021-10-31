use v6 ;

sub MAIN( Int $n is copy ) {
  my @fibonacci = (1 , 2 ) ;
  my $sequencesFound = 0 ;
  if ( $n == 1 || $n == 2 ) {
      say 1 ;
      exit( 0 ) ;
  }
  else {
      repeat {
    @fibonacci.push( @fibonacci[* - 1] + @fibonacci[ * - 2] ) ;
      } until ( @fibonacci[ * - 1] >= $n ) ;
  }
  for (2 .. @fibonacci.elems - 1) -> $i {
      my @combis = @fibonacci.combinations( $i ) ;
      $sequencesFound += @combis.grep( {$_.sum == $n} ) ;
  }
  if ( $n (elem) @fibonacci.Set ) {
      $sequencesFound++ ; #we should add one sequence that contains $n only
  }
  say $sequencesFound ;
}
