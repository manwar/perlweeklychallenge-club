use v6 ;

sub count( Str $word, Str $c --> Int) {
      my Int $num = 0 ;
      for (0 .. $word.chars - 1 ) -> $i {
    if ( $word.substr( $i , 1 ) eq $c ) {
        $num++ ;
    }
      }
      return $num ;
}

sub myCondition( Int $n --> Bool ) {
  my $numberstring = ~$n ;
  my $len = $numberstring.chars ;
  return $n.is-prime  &&
      ($numberstring eq $numberstring.flip) &&
      ($numberstring.substr( $len div 2 , 1 ) eq "0")
      && count( $numberstring , '0' ) == 1 ;
}

my @cyclopses ;
my $current = 100 ;
while ( @cyclopses.elems != 20 ) {
  if ( myCondition( $current ) ) {
      @cyclopses.push( $current ) ;
  }
  $current++ ;
  if ( ~$current.chars %% 2 ) {
      $current *= 10 ;
  }
}
say @cyclopses.join( ',' ) ;
