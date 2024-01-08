use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @selected ;
for (0..@numbers.elems - 1 ) -> $pos {
   if ( $pos % 10 == @numbers[ $pos ] ) {
      @selected.push( $pos ) ;
   }
}
if ( @selected ) {
   say @selected.min ;
}
else {
   say "-1" ;
}
