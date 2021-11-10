use v6 ;

sub MAIN( Int $year is copy ) {
  while ( ~$year !~~ /^ \d ** 4 $/ ) {
      say "Enter year as a four-digit-number!" ;
      $year = $*IN.get.Int ;
  }
  my $workdays = 0 ;
  my $currentDate = Date.new( $year , 1 , 1 ) ;
  while ( $currentDate.year == $year ) {
      my $day = $currentDate.day-of-week( ) ;
      if ( 1 <= $day <= 5 ) {
    $workdays++ ;
      }
      $currentDate = $currentDate.succ ;
  }
  say $workdays ;
}
