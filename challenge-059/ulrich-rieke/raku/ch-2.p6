use v6 ;

sub myF( Int $a , Int $b --> Int ) {
  my $numstring1 = $a.base(2).Str ;
  my $numstring2 = $b.base(2).Str ;
  my $len1 = $numstring1.chars ;
  my $len2 = $numstring2.chars ;
  if ( $len1 < $len2 ) {
      $numstring1 = ("0" xx ($len2 - $len1)).join ~ $numstring1 ;
  }
  if ( $len2 < $len1 ) {
      $numstring2 = ("0" xx ($len1 - $len2)).join ~ $numstring2 ;
  }
  my Int $diff = 0 ;
  for (0..$numstring1.chars - 1 ) -> $i {
      if ( $numstring1.substr( $i , 1 ) ne $numstring2.substr( $i , 1 ) ) {
    $diff++ ;
      }
  }
  return $diff ;
}

sub MAIN( *@ARGS ) {
  my $sum = 0 ;
  my @combinations = @ARGS.combinations( 2 ) ;
  for @combinations -> $combi {
      $sum += myF( $combi[ 0 ] , $combi[ 1 ] ) ;
  }
  say "The sum is $sum!" ;
}
