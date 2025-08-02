sub target_index {
  my( $k, @c ) = ( pop, 0, 0, 0 );
  $c[ $_ <=> $k ]++ for @_;
  $c[2] .. $c[2] + $c[0] - 1
}
