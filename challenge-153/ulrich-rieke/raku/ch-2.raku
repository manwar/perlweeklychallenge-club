use v6 ;

sub factorial( Int $n is copy ) {
  if ( $n == 0 ) {
      return 1 ;
  }
  else {
      return [*](1 .. $n) ;
  }
}

sub MAIN( Int $n is copy ) {
  my @digits = (~$n).comb.map( {.Int} ) ;
  my $sum = 0 ;
  @digits.map( { $sum += factorial( $_ ) } ) ;
  if ( $sum == $n ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
