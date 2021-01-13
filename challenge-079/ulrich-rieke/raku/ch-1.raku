use v6 ;

sub countOnes( Str $num ) {
  my $ones = 0 ;
  my $len = $num.chars ;
  for ( 0 .. $len - 1 ) -> $i {
      if ( $num.substr( $i , 1 ) eq "1" ) {
    $ones++ ;
      }
  }
  return $ones ;
}

sub MAIN( Int $N ) {
  my @array = (1 ..$N).map( {.base(2).Str} ) ;
  my $ones = [+] @array.map( { countOnes( $_ ) } ) ;
  say "$ones % 1000000007 = { $ones % 1000000007 }" ;
}
