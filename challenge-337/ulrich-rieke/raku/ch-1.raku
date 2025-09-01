use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @solution ;
for (0..@numbers.elems - 1 ) -> $pos {
   my $count = @numbers.grep( {$_ <= @numbers[$pos]} ).elems ;
#subtract 1 from $count if $count is greater than 0 to exclude the number itself
   if ( $count > 0 ) {
      @solution.push( $count - 1 ) ;
   }
   else {
      @solution.push( 0 ) ;
   }
}
say '(' ~ @solution.join( ',' ) ~ ')' ;
