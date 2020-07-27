use v6 ;

sub MAIN( Int $limit ) {
  my $n = 1 ;
  my @current = ( "0" , "1" ) ;
  while ( $n < $limit ) {
      for @current.reverse -> $element {
    @current.push( $element ) ;
      }
      my $len = @current.elems ;
      for (0.. $len div 2  - 1) -> $i {
    @current[ $i ] = "0" ~ @current[ $i ] ;
      }
      for ( $len div 2 .. $len - 1 ) -> $i {
    @current[ $i ] = "1" ~ @current[ $i ] ;
      }
      $n++ ;
  }
  my @numbers = @current.map( {.parse-base( 2 ) } ) ;
  say @numbers ;
}
