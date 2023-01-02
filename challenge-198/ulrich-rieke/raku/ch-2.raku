use v6 ;

sub MAIN( Int $number ) {
  say (0..^$number).grep( {.is-prime} ).elems ;
}
