use v6 ;

say "Enter an even amount of positive integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @solution ;
my $pos = 0 ;
while ( $pos < $len - 1 ) {
   my $howmany = @numbers[$pos] ;
   for (0..$howmany - 1 ) {
      @solution.push( @numbers[$pos + 1]) ;
   }
   $pos += 2 ;
}
say "(" ~ @solution.join( ',' ) ~ ")" ;
