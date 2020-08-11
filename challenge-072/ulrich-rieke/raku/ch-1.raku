use v6 ;

sub postfix:<!>( Int $n ) {
  [*](1..$n) ;
}

sub MAIN( Int $N ) {
  my $zeroes = 0 ;
  my $numstr = ~($N!).flip ;
  my $n = 0 ;
  while ( $numstr.substr( $n , 1 ) eq "0" ) {
      $zeroes++ ;
      $n++ ;
  }
  $zeroes.say ;
}
