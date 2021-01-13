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

sub MAIN( ) {
  my @neighbours ;
  my @A = enterArray( ) ;
  my $len = @A.elems ;
  @neighbours.push( 0 , @A[ 0 ] ) ;
  for ( 2..$len - 1 ) -> $i {
      if ( all (@A[0..$i - 1]) == @A[ 0 ] ) {
    @neighbours.push( 0 ) ;
      }
      else {
    @neighbours.push( @A[0..$i - 1].min ) ;
      }
  }
  say @neighbours ;
}
