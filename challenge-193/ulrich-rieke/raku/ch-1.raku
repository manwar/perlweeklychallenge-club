use v6 ;

sub change( Str $binary , Int $len ) {
  my $changed ;
  if ( $binary.chars < $len ) {
      $changed = ( '0' x $len - $binary.chars ) ~ $binary ;
  }
  else {
      $changed = $binary ;
  }
  return $changed ;
}

sub MAIN( $n where $n > 0 ) {
  my $limit = ('1' x $n).parse-base( 2 ) ;
  my @combis ;
  for (0..$limit) -> $num {
      @combis.push( $num.base( 2 ) ) ;
  }
  my @changed = @combis.map( { &change( $_ , $n ) } ) ;
  say @changed.join( ',' ) ;
}
