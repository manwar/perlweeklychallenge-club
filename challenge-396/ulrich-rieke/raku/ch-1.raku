use v6 ;

sub findPairs( $element , @allPairs ) {
   for @allPairs -> @pair {
      if ( @pair[1] == $element ) {
         return @pair ;
      }
   }
}

say "Enter n integers from 1 to n in any order!" ;
my $line = $*IN.get ;
my @order = $line.words.map( {.Int} ) ;
say "Enter a subset of these numbers in strictly ascending order!" ;
$line = $*IN.get ;
my @friends = $line.words.map( {.Int} ) ;
my @letterpositions ;
for (0..@order.elems - 1) -> $pos {
   my @subarray = ($pos , @order[$pos] ) ;
   @letterpositions.push( @subarray ) ;
}
my @reordered ;
for @friends -> $f {
   @reordered.push( findPairs( $f , @letterpositions )) ;
}
my @sorted = @reordered.sort( {@^a[0] <=> @^b[0]} ) ;
my @solution ;
for @sorted -> @subarray {
   @solution.push( @subarray[1] ) ;
}
say '(' ~ @solution.join( ',' ) ~ ')' ;
