use v6 ;

#is the second time later than the first time?
sub isLater( @times ) {
   my ( $firstHour , $firstMinutes ) = @times[0].split( ':' ) ;
   my ( $secondHour , $secondMinutes ) = @times[1].split( ':' ) ;
   if ($firstHour ne $secondHour ) {
      return $secondHour > $firstHour ;
   }
   else {
      return $secondMinutes > $firstMinutes ;
   }
}

say "Enter the start and end times of a first event!" ;
my $firstEvent = $*IN.get ;
say "Enter the start and end times of a second event!" ;
my $secondEvent = $*IN.get ;
my $result = True ;
my @firstEventTimes = $firstEvent.words ;
my @secondEventTimes = $secondEvent.words ;
if ( @firstEventTimes[0] eq @secondEventTimes[0] ) {
#there is a collision , so result remains unchanged!
}
else {
   my @times = ( @firstEventTimes[1] , @secondEventTimes[0] ) ;
   if ( isLater( @times ) || @times[1] eq @times[0] ) {
      $result = False ;
   }
   else {
   }
}
$result.say ;
