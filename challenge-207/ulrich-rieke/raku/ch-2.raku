use v6 ;

say "Enter some integers, separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @sorted = @numbers.sort( { $^b <=> $^a } ) ;
my @possible_h ;
for (0..@sorted.elems - 1 )  -> $i {
  if ( @sorted[ $i ] >= ( $i + 1 ) ) {
      @possible_h.push( $i + 1 ) ;
  }
}
say @possible_h.max ;
