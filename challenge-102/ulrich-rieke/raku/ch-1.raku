use v6 ;

sub isPerfectSquare( Int $N --> Bool ) {
  my $root = sqrt( $N ) ;
  return $root == floor( $root ) ;
}

sub isRare( Int $N is copy --> Bool ) {
  my $reversed = $N.Str.flip.Int ;
  return ( isPerfectSquare( $N + $reversed ) and
    isPerfectSquare( $N - $reversed ) ) ;
}

sub MAIN( Int $N ) {
  my $range = ( 10 ** ($N - 1 ) .. (10 ** $N) - 1 ) ;
  say $range.grep( {isRare( $_ )} ) ;
}
