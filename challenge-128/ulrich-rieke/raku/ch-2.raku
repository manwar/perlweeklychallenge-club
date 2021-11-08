use v6 ;

sub enterTimes( ) {
#regex for valid times
  my $point_in_time = /^^'(' ((0<[0..9]> || 1<[0..9]> || 2<[0..3]> ) ':'
    <[0..5]><[0..9]>','* \s* )+ ')' $$/ ;
  say "Enter times, starting with a ( and ending with a ), pattern :
      <hours>:<minutes>" ;
  my $line = $*IN.get ;
  my @times ;
  while ( $line !~~ /<$point_in_time>/ ) {
      say "Please enter times , starting with a ( and ending "
    ~ "with )!" ;
      say "see above for general pattern!" ;
      $line = $*IN.get ;
  }
  if ( $line ~~ /<$point_in_time>/ ) {
      given $line {
#find all given times by collecting them into an array
    my @matches = m:global/\d ** 2 ':' \d ** 2 / ;
    my $len = @matches.elems ;
    for (0 .. $len - 1 ) -> $i { #find hours and minutes
        my ( $hours , $minutes ) = @matches[ $i ].split( /':'/ ) ;
#create a DateTime object
        my $time = DateTime.new( year => 2021 , month => 8 ,
          day => 30 , hour => +$hours , minute => +$minutes ) ;
        @times.push( $time ) ;
    }
      }
  }
  return @times ;
}

sub MAIN( ) {
  say "Enter arrival times, they should be ordered by time of arrival!" ;
  my @arrivals = enterTimes( ) ;
  my $len = @arrivals.elems ;
  for (0 .. $len - 2 ) -> $i {
      unless ( @arrivals[ $i ] < @arrivals[ $i + 1 ] ) {
    say "arrivals should be ordered!" ;
    say "Enter new arrival times!" ;
    @arrivals = enterTimes( ) ;
      }
  }
  say "Enter departure times, starting with ( and ending with ), pattern " ~
      "<hours>:<minutes> " ;
  my @departures = enterTimes( ) ;
  my $dlen = @departures.elems ;
  while ( $dlen != $len ) {
      say "There should be as many departures as arrivals!" ;
      @departures = enterTimes( ) ;
      $dlen = @departures.elems ;
  }
  for ( 0 .. $len - 1 ) -> $i {
      if ( @departures[ $i ] < @arrivals[ $i ] ) {
    say "train can't leave before arriving!" ;
    die "now I am leaving!" ;
      }
  }
  my @trainsInStation ;#how many trains are in station when a new one arrives?
  for ( 1 .. $len - 1 ) -> $i {
#all those trains who leave after the new train arrives are still in station
      @trainsInStation.push( @departures[0..$i - 1].grep( {$_ >
          @arrivals[ $i ]} ).elems ) ;
  }
#the maximum number of platforms is the maximum number of trains waiting at
#station at any one time + 1, the minimum number of platforms
  say @trainsInStation.max + 1 ;
}
