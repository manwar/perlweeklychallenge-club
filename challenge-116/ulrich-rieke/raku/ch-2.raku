use v6 ;

sub MAIN( Int $N is copy ) {
  if ( $N < 10 ) {
      say "number must be greater than 10!" ;
      exit( 1 ) ;
  }
  my @digits = $N.comb ;
  my @squares = @digits.map( { +$_ ** 2 } ) ;
  my $squaresum = [+] @squares ;
  if (floor( sqrt ($squaresum)) == (sqrt( $squaresum ))) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
