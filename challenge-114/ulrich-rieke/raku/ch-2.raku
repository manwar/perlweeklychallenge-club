use v6 ;

sub countOnes( Str $numberstr ) {
  my $sum = 0 ;
  my $len = $numberstr.chars ;
  for (0 .. $len - 1 ) -> $i {
      if ( $numberstr.substr( $i , 1 ) eq "1" ) {
    $sum++ ;
      }
  }
  return $sum ;
}

sub MAIN( Int $N  is copy ) {
  my $ones = countOnes( $N.base( 2 ) ) ;
  repeat {
      ++$N ;
  } until ( countOnes( $N.base( 2 )) == $ones) ;
  say $N ;
}
