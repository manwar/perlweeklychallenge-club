sub merge_items {
  my %c;
  for( @_ ) {
    $c{ $_->[0] } += $_->[1] for @{$_}
  }
  map { [ 0 + $_ => $c{$_} ] } keys %c
}
