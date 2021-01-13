use v6 ;

sub MAIN( Int $N ) {
  my @selected = (1..50).pick( $N ) ;
  my @peaks ;
  if ( @selected[0] > @selected[1] ) {
      @peaks.push( @selected[ 0 ] ) ;
  }
  for (1..$N - 2 ) -> $i {
      if (( @selected[ $i ] > @selected[ $i - 1 ] ) &&
        (@selected[ $i ] > @selected[ $i + 1 ] ) ) {
    @peaks.push( @selected[ $i ] ) ;
      }
  }
  if ( @selected[ $N - 1 ] > @selected[ $N - 2 ] ) {
      @peaks.push( @selected[ $N - 1 ] ) ;
  }
  say @selected ;
  say @peaks ;
}
