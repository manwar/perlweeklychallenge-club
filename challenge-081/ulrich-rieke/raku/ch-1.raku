use v6 ;

sub findDivisors( Int $num ) {
  my @divisors ;
  for (1..$num) -> $i {
      if ( $num %% $i ) {
    @divisors.push( $i ) ;
      }
  }
  return @divisors ;
}

sub findBaseStrings( Str $string ) {
  my @baseStrings ;
  my $len = $string.chars ;
  my @divisors = findDivisors( $len ) ;
  for @divisors -> $i {
      my $part = $string.substr( 0 , $i ) ;
      my $times = $len div $i ;
      if ( ($part xx $times).join eq $string ) {
    @baseStrings.push( $part ) ;
      }
  }
  return @baseStrings ;
}

sub MAIN( Str $A , Str $B ) {
  my @baseStringsA = findBaseStrings( $A ) ;
  my @baseStringsB = findBaseStrings( $B ) ;
  say "{ @baseStringsA.Set (&) @baseStringsB.Set }" ;
}
