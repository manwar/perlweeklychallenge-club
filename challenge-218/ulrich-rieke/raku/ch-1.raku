use v6 ;

say "Please enter at least 3 integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
if ( @numbers.elems == 3 ) {
  say [*] @numbers ;
}
else {
  my @products ;
  my @combinations = @numbers.combinations( 3 ) ;
  for @combinations -> $combi {
      my $prod = 1 ;
      for (0..2) -> $i {
    $prod *= $combi[ $i ] ;
      }
      @products.push( $prod ) ;
  }
  my @sorted = @products.sort( { $^b <=> $^a } ) ;
  say @sorted[ 0 ] ;
}
