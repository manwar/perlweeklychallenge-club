use v6 ;

sub myCondition( $array ) {
  my $len = $array.elems ;
  my @differences ;
  for (0..$len - 2 ) -> $i {
      @differences.push( $array[ $i + 1 ] - $array[ $i ] ) ;
  }
  my $set = @differences.Set ;
  return $set.elems == 1 ;
}

say "Please enter some numbers, separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
if ( $len < 3 ) {
  say "()" ;
}
else {
  my $fulfilled = False ;
  for (3..$len) -> $l {
      for @numbers.combinations( $l ) -> $combi {
    if ( myCondition( $combi ) ) {
        say "(" ~ $combi ~ ")" ;
        $fulfilled = True ;
    }
      }
  }
  unless $fulfilled {
      say "()" ;
  }
}
