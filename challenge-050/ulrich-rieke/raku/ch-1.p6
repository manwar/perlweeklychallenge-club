use v6 ;

sub mergeRanges( $fstRange, $sndRange ) {
  my $firstSet = ($fstRange[0]..$fstRange[1]).Set ;
  my $secondSet = ($sndRange[0]..$sndRange[1]).Set ;
  my $solution ;
  if ($firstSet (&) $secondSet ) {
      $solution[0] = min( $fstRange[0] , $sndRange[0] ) ;
      $solution[1] = max( $fstRange[1] , $sndRange[1] ) ;
  }
  else {
      if ( $fstRange[1] == $sndRange[0] - 1 ) {
    $solution[0] = $fstRange[0] ;
    $solution[1] = $sndRange[1] ;
      }
  }
  return $solution ;
}

my @intervals = ([2,7] , [3,9] , [10,12] , [15,19] , [18,22] ) ;
my @merged ;
while ( @intervals ) {
  my $result = mergeRanges( @intervals[0] , @intervals[1] ) ;
  if ( $result ) {
      @merged.push( $result ) ;
      @intervals.splice( 0 , 2 ) ;
  }
  else {
      @merged.push( @intervals[0] ) ;
      @intervals.shift ;
  }
}
say @merged ;
