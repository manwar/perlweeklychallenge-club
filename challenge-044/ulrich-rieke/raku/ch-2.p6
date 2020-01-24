use v6 ;

sub doublingSteps( Int $n is copy ) {
  my $count = 0 ;
  while ( $n < 200 ) {
      $count++ ;
      $n *= 2 ;
  }
  return ( $n div= 2 , --$count ) ;
}

#we assume that we go to a starting point in steps of 1 , then
#keep doubling and then move forward to 200 in steps of 1
sub computeSteps( Int $n is copy --> Int ) {
  my @result = doublingSteps( $n ) ;
  return ( $n - 1 + @result[1] + 200 - @result[0] ) ;
}

my $moves = (1..100).map( { computeSteps( $_ ) } ).sort( {$^a <=> $^b})[0] ;
say "The minimum number of moves is $moves!" ;
