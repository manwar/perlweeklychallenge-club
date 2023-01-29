use v6 ;

say "Please enter some unique integers, separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $numberset = @numbers.Set ;
my @missingNumbers ;
for (0..@numbers.elems) -> $n {
  unless ( $n (elem) $numberset ) {
      @missingNumbers.push( $n ) ;
  }
}
say @missingNumbers ;
