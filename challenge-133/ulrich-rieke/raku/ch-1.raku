use v6 ;

sub MAIN( Int $N is copy ) {
  my Int $current = 0 ;
  repeat {
      $current++ ;
  } until ( $current * $current > $N ) ;
  say --$current ;
}
