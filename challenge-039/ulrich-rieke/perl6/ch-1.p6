use v6 ;

#the basic idea is to read in the file, to convert the access( IN )
#and the departure times to minutes and to add a tag whether we move
#in( "i" ) or out ("o"). If we then order the times by minutes we can
#keep a count of people inside and determine the number of minutes
#that elapsed between first person arriving and last person leaving

sub readFile( Str $filename ) {
  my @accesstimes ;
  my $fh = open $filename, :r ;
  for $fh.lines -> $line {
      my @fields = $line.split(/\s+/) ;
      my $start = @fields[3] ;
      my $stop = @fields[5] ;
      @accesstimes.push( convertToMinutes( $start ).Str ~ "i" ) ;
      @accesstimes.push( convertToMinutes( $stop ).Str ~ "o" ) ;
  }
  $fh.close ;
  return @accesstimes ;
}

sub convertToMinutes( Str $time --> Int ) {
  (my $hours , my $minutes ) = $time.split( /':'/ ) ;
  return $hours * 60 + $minutes ;
}

sub orderByTime( *@times ) {
  my @ordered = @times.sort( { $^a.substr(0 , $^a.chars - 1 ).Int <=>
    $^b.substr(0 , $^b.chars - 1 ).Int } ) ;
  return @ordered ;
}

sub MAIN( Str $filename ) {
  my @times = readFile( $filename ) ;
  my @orderedTimes = orderByTime( @times ) ;
  my $starttime = @orderedTimes[0] ;
  my $people_Inside = 0 ;
  my $minutes_On ;
  for @orderedTimes -> $time {
      if ($time.substr( *-1 , 1 ) eq "i" ) {
    $people_Inside++ ;
      }
      else {
    $people_Inside-- ;
    if ( $people_Inside == 0 ) {
        $minutes_On = $time.substr(0 , $time.chars - 1 ).Int -
          $starttime.substr(0 , $starttime.chars - 1 ).Int ;
        last ;
    }
      }
  }
  say ("Longest time lights on is " ~ $minutes_On.Str ~ " minutes!") ;
}
