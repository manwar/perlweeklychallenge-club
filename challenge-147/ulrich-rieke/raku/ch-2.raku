use v6 ;

sub isPentagonNumber( $n ) {
  return ((sqrt( 24 * $n + 1 ) + 1) / 6 ) %% 1 ;
}

sub toPentagon( Int $n ) {
  return ($n * ( 3 * $n - 1 )) div 2 ;
}

my @pentagons = ( 1, 5, 12, 22, 35, 51, 70, 92, 117 , 145 ) ;
my @combis = @pentagons.combinations( 2 ) ;
my @solutions = @combis.grep( { isPentagonNumber( $_[0] + $_[1] ) &&
      isPentagonNumber( abs( $_[0] - $_[1] ) ) } ) ;
if ( @solutions ) {
  say @solutions[ 0 ] ;
}
else {
  my $pair ;
  my Bool $pairFound = False ;
  while ( not $pairFound ) {
      my $len = @pentagons.elems ;
      @pentagons.push( toPentagon( $len + 1 ) ) ;
      for @pentagons[0 .. $len - 2] -> $i {
    if ( isPentagonNumber( $i + @pentagons[ *-1 ] ) &&
          isPentagonNumber( abs( $i - @pentagons[ *-1 ] ))) {
        $pair = ( $i , @pentagons[ *-1 ] ) ;
        $pairFound = True ;
        last ;
    }
      }
  }
  say $pair ;
}
