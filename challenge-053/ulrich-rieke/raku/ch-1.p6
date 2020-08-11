use v6 ;

sub rotate90( @array ) {
  my @rotated ;
  my $len = @array.elems ;
  for (0..$len - 1 ) -> $j {
      my $element ;
      loop (my $i = $len - 1 ; $i > -1 ; $i-- ) {
    $element.push( @array[$i][$j] ) ;
      }
      @rotated.push( $element ) ;
  }
  return @rotated ;
}

sub MAIN( Int $n where 90 <= $n <= 270 ) {
  my @array = ([1 , 2 , 3 ] , [ 4 , 5 , 6 ] , [ 7 , 8 , 9 ] ) ;
  my $times = $n div 90 ;
  my @rotated ;
  if ( $times == 1 ) {
      @rotated = rotate90( @array ) ;
  }
  else {
      @rotated = @array ;
      for (0..$times ) {
    @rotated = rotate90( @rotated ) ;
      }
  }
  .say for @rotated ;
}
