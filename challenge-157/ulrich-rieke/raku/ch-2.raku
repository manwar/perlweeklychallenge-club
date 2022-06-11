use v6 ;

sub allSame( Str $word --> Bool) {
  return $word.comb.grep( { $_ eq $word.substr(0 , 1 ) } ).elems ==
      $word.chars ;
}

sub MAIN( Int $n is copy ) {
  while ( $n < 3 ) {
      say "number should be at least 3! Re-enter!" ;
      my $line = $*IN.get ;
      $n = +$line ;
  }
  my Bool $isBrazilian = False ;
  for ( 2 .. $n - 2 ) -> $i {
      my $baseStr = $n.base( $i ) ;
      say $baseStr ;
      if ( allSame( $baseStr ) ) {
    $isBrazilian = True ;
    last ;
      }
  }
  if ( $isBrazilian ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
