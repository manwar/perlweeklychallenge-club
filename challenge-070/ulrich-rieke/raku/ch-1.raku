use v6 ;

sub swapLetters( Str $word is copy , Int $firstPos, Int $secondPos --> Str) {
  my $temp = $word.substr( $secondPos , 1 ) ;
  $word.substr-rw( $secondPos , 1 ) = $word.substr( $firstPos , 1 ) ;
  $word.substr-rw( $firstPos , 1 ) = $temp ;
  return $word ;
}

sub MAIN( Str $word is copy, Int $C , Int $O ) {
  my $len = $word.chars ;
  for (1..$C) -> $i {
      $word = swapLetters( $word , $i % $len , ( $i + $O ) % $len ) ;
  }
  $word.say ;
}
