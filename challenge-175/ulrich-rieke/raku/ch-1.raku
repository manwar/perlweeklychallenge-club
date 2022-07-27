use v6 ;

sub MAIN( Int $year ) {
  my @lastDays = ( 31 , 28 , 31 , 30 , 31 , 30 , 31 , 31 , 30 , 31 , 30 ,
    31 ) ;
  if ( Date.new("$year-01-01").is-leap-year) {
      @lastDays[ 1 ] = 29 ;
  }
  my @lastSundays ;
  for (1 .. 12 ) -> $month {
      my $d = Date.new( year => $year , month => $month , day =>
        @lastDays[ $month - 1 ] ) ;
      while ( $d.day-of-week != 7 ) {
    $d = $d.earlier( day => 1 ) ;
      }
      @lastSundays.push( $d ) ;
  }
  .say for @lastSundays.map( { .Str } ) ;
}
