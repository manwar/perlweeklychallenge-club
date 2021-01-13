use v6 ;

sub rotationNumber( Str $string --> Int ) {
  return 0 unless $string ~~ /^<[xy]>+$/ ;
  my $rotations = 0 ;
  my $i = 1 ;
  my $len = $string.chars ;
  my $rotated = $string ;
  $rotated = $rotated.comb.List.rotate( $i % $len ).join ;
  while ( $rotated ne $string ) {
      $rotations++ ;
      $i++ ;
      $rotated = $rotated.comb.List.rotate( $i % $len ).join ;
  }
#rotations are counted in the loop, so we have to add 1 to the final
#result after getting the original string again
  return ++$rotations ;
}

say rotationNumber( "xyxx" ) ;
