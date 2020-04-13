use v6 ;

sub myFlip( Str $n --> Str ) {
  return $n.comb.map( { $_ eq "1" ?? "0" !! "1" } ).join ;
}

sub countChar( Str $string , Str $searched --> Int ) {
  return $string.comb.grep( {$_ eq $searched} ).elems ;
}

sub MAIN( Int $num ) {
  my $binary = $num.base( 2 ).Str ;
  $binary.say ;
  my $len = $binary.chars ;
  my @pairs ;
  for (0..$len - 1 ) -> $l {
      for ( $l..$len - 1 ) -> $r {
    my $flipped = $binary.substr(0 , $l ) ~
        myFlip( $binary.substr( $l, $r - $l ) ) ~
        $binary.substr( $r ) ;
    @pairs.push( ( $l , $r , $flipped ) ) ;
      }
  }
  my @changedPairs ;
  for @pairs <-> $element {
      @changedPairs.push( ( $element[ 0 ] , $element[ 1] ,
          countChar( $element[ 2] , "1" ) ) ) ;
  }
  my @sorted = @changedPairs.sort( { $^b[ 2 ] <=> $^a[ 2 ] } ) ;
  say "L {@sorted[0][0] } , R { @sorted[0][1 ] }" ;
  my $i = 1 ;
  while ( @sorted[ $i ][2] == @sorted[ 0 ][ 2 ] ) {
      say "L {@sorted[$i][0] } , R { @sorted[$i][1 ] }" ;
      $i++ ;
  }
}
