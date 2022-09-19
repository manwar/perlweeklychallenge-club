use v6 ;

sub MAIN( Int $number ) {
  my @digits = (~$number).comb.map( {.Int} ) ;
  my $esthetic = so (@digits.rotor( 2 => -1).map( { abs( $_[0]
    - $_[1] ) } )).all == 1 ;
  if ( $esthetic ) {
      say "$number is esthetic!" ;
  }
  else {
      say "$number is not esthetic!" ;
  }
}
