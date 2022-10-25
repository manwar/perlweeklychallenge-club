use v6 ;

say "Enter 2 positive integers, separated by a blank!" ;
my $line = $*IN.get ;
my ( $x , $y ) = $line.split( /\s+/ ) ;
if ( $x == $y ) {
  say 1 ;
}
else {
  my $count = 0 ;
  while ( $x != $y ) {
      if ( $x > $y ) {
    $x -= $y ;
      }
      else {
    $y -= $x ;
      }
      $count++ ;
  }
  $count++ ;
  say $count ;
}
