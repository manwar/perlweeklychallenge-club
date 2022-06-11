use v6 ;

sub isPernicious( Int $n is copy  --> Bool ) {
  my $binaryString = $n.base( 2 ) ;
  my $ones = 0 ;
  for (0 .. $binaryString.chars - 1) -> $i {
      if ( $binaryString.substr( $i , 1 ) eq "1" ) {
    $ones++ ;
      }
  }
  return $ones.is-prime ;
}

my @perniciousNumbers ;
my $current = 0;
while ( @perniciousNumbers.elems != 10 ) {
  $current++ ;
  if (isPernicious( $current ) ) {
      @perniciousNumbers.push( $current ) ;
  }
}
say @perniciousNumbers.join( ',' ) ;
