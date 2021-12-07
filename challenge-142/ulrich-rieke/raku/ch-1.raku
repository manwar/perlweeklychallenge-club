use v6 ;

subset Positive of Int where * > 0 ;
sub MAIN( Positive $m , Positive $n ) {
  my @divisors ;
  for (1 .. $m) -> $i {
      if ( $m %% $i ) {
    @divisors.push( $i ) ;
      }
  }
  say @divisors.grep( { $_ % 10 == $n } ).elems ;
}
