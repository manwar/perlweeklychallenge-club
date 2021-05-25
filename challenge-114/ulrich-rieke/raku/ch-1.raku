use v6 ;

sub isPalindrome( Int $number ) {
  return ~$number eq ~$number.flip ;
}

sub MAIN( Int $N is copy ) {
  repeat {
      ++$N ;
  } until ( isPalindrome( $N ) ) ;
  say $N ;
}
