use v6 ;

say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @permus = @numbers.permutations ;
my @allTotals ;
for @permus -> $permu {
   my $total ;
   for ( 0..$len - 1 ) -> $i {
      $total ~= ~$permu[$i] ;
   }
   @allTotals.push( $total ) ;
}
my @totalNums = @allTotals.map( {.Int} ) ;
say @totalNums.max ;
