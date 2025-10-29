use v6 ;

say "Enter at least 3 integers!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @indices ;
for (1..@numbers.elems - 2) -> $pos {
   if (@numbers[$pos] > @numbers[$pos - 1] && @numbers[$pos] > @numbers[$pos + 1]) {
      @indices.push( $pos ) ;
   }
}
say '(' ~ @indices.join( ',' ) ~ ')' ;
