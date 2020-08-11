use v6 ;

my %daycount = "Jan" => 31 , "Feb" => 28 , "Mar" => 31 , "Apr" => 30 ,
  "May" => 31 , "Jun" => 30 , "Jul" => 31 , "Aug" => 31 , "Sep" => 30 ,
  "Oct" => 31 , "Nov" => 30 , "Dec" => 31 ;
my @months = <Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec> ;
my %weekdaycount ;
my $weekdays ;
for (1..12) -> $month {
  my $mon = @months[ $month - 1 ] ;
  for (1..%daycount{$mon}) -> $day {
      my $date = Date.new( 2019 , $month , $day ) ;
      if ( 1 <= $date.day-of-week <= 5 ) {
    $weekdays++ ;
      }
  }
  %weekdaycount{ $mon } = $weekdays ;
  $weekdays = 0 ;
}
for @months -> $month {
  say "$month: {%weekdaycount{ $month }} days" ;
}
