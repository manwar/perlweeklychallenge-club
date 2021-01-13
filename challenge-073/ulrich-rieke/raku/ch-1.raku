use v6 ;

sub enterArray( ) {
  my @array ;
  my $element = prompt "Enter a list element: (end to end) : " ;
  while ( $element ne "end" ) {
      if ( +$element ~~ Int ) {
    @array.push( $element ) ;
    $element = prompt "Enter a list element: (end to end) : " ;
      }
  }
  return @array ;
}

sub MAIN( Int $W ) {
  my @A = enterArray( ) ;
  my $len = @A.elems ;
  my @minimums ;
  if ( $len < $W ) {
      say "array too small for given window!" ;
  }
  else {
      for (0..$len - $W ) -> $i {
    @minimums.push( @A[$i..$i + $W - 1].min ) ;
      }
  }
  say @minimums ;
}
