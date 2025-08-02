use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @valid_pairs ;
for @numbers.combinations( 2 ) -> $combi {
   my $difference = ($combi[0] - $combi[1]).abs ;
   my $mini = ($combi[0] , $combi[1]).min ;
   if ( 0 < $difference && $difference < $mini ) {
      @valid_pairs.push( $combi ) ;
   }
}
say @valid_pairs.unique.elems ;
