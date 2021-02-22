use v6 ;

sub MAIN( Str $S is copy ) {
  $S .= trim-leading ;
  $S .= trim-trailing ;
  my @words = $S.split( /\s+/ ) ;
  say @words.reverse.join( ' ' ) ;
}
