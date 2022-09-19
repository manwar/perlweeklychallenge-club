use v6 ;

say "Please enter a date time in the form 'year-month-dayThour:minute'!" ;
my $dateTimeStr = $*IN.get ;
while ( $dateTimeStr !~~ /^(\d+) '-' (\d+) '-' (\d+) 'T' (\d+) ':' (\d+) $/ ) {
  say "Please enter a date time in the form 'year-month-dayThour:minute'!" ;
  $dateTimeStr = $*IN.get ;
}
my $dateTime = DateTime.new( year => +$0 , month => +$1 , day => +$2 ,
      hour => +$3 , minute => +$4 ) ;
say "Please enter duration as hours , possibly hours.(fractions of hour)!" ;
my $durationStr = $*IN.get ;
while ( $durationStr !~~ /^\d+'.'*(\d+)*$/ ) {
  say "Please enter duration as hours , possibly hours.(fractions of hour)!" ;
}
my $duration = +$durationStr ;
my $daysLater = floor($duration) div 9 ; #working day has 9 hours
my $hoursLater = $duration - $daysLater * 24 ;
my $businessDate = $dateTime.later( days => $daysLater ) ;
my $weekDay = $businessDate.day-of-week ;
if ( $weekDay == 6 ) {
  $businessDate = $businessDate.later( days => 2 ) ;
}
if ( $weekDay == 7 ) {
  $businessDate = $businessDate.later( days => 1 ) ;
}
$businessDate = $businessDate.later( minutes => $hoursLater * 60 ) ;
if ( $businessDate.hour + $hoursLater > 18 ) {
  $businessDate = $businessDate.later( days => 1 ) ;
  $weekDay = $businessDate.day-of-week ;
  if ( $weekDay == 6 ) {
      $businessDate = $businessDate.later( days => 2 ) ;
  }
  if ( $weekDay == 7 ) {
      $businessDate = $businessDate.later( days => 1 ) ;
  }
  $businessDate = $businessDate.earlier( minutes => $hoursLater * 60 ) ;
}
say $businessDate ;
