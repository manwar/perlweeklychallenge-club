use v6 ;

say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @before_pairs = ((0..$len - 1) Z, @numbers) ;
my @sorted = @numbers.sort( {$^a <=> $^b} ) ;
my @after_pairs = ((0..$len - 1) Z, @sorted ) ;
my @changed_indices ;
for (0..$len - 1) -> $pos {
   if ( @before_pairs[$pos][1] != @after_pairs[$pos][1] ) {
      @changed_indices.push( $pos ) ;
   }
}
say '(' ~ @changed_indices.join( ',' ) ~ ')' ;
