use v6 ;

sub findDifference( $firstTime is copy , $secondTime is copy ) {
  $firstTime ~~ s/0(\d)\:0(\d)/$0:$1/ ;
  $secondTime ~~ s/0(\d)\:0(\d)/$0:$1/ ;
  my ( $firstHours , $firstMinutes ) = $firstTime.split( /':'/ ) ;
  my ( $secondHours, $secondMinutes ) = $secondTime.split( /':'/ ) ;
  my $firstminutes = +$firstHours * 60 + +$firstMinutes ;
  my $secondminutes = +$secondHours * 60 + +$secondMinutes ;
  my $diff = $secondminutes - $firstminutes ;
  if ( $diff < 0 ) {
      $secondminutes += 24 * 60 ;
      $diff = $secondminutes - $firstminutes ;
  }
  return $diff ;
}

say "Please enter some times, separated by blanks, ':' to separate hours and minutes!" ;
my $line = $*IN.get ;
my @times = $line.words ;
my $len = @times.elems ;
my @permutedTimes = @times.permutations ;
my @differences ;
for @permutedTimes -> $permu {
  for (0..$len - 2 ) -> $i {
      @differences.push( findDifference( ~$permu[ $i ] , ~$permu[ $i + 1 ] ) ) ;
  }
}
say @differences.min ;
