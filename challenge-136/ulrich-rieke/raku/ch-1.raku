use v6 ;

sub MAIN( Int $m is copy , Int $n is copy ) {
  if ( log2( $m gcd $n) %% 1 ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
