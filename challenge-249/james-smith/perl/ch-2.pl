sub DI_string_match {
  my( $n, $x ) = ( 0, length $_[0] );
  map( { 'I' eq $_ ? $n++ : $x-- } split //, $_[0] ), $n
}
