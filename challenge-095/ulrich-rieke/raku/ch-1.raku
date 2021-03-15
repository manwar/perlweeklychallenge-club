use v6 ;

sub isPalindrome( Int $n --> Bool ) {
  my $numstring = $n.Str ;
  return $numstring eq $numstring.flip ;
}

sub MAIN( Int $N ) {
  say isPalindrome( $N ) ?? 1 !! 0 ;
}
