use v6 ;

say "Enter some item prices separated by blanks!" ;
my $priceline = $*IN.get ;
my @prices = $priceline.words.map( {.Int} ) ;
my @solution ;
my $len = @prices.elems ;
for (0..$len - 2 ) -> $pos {
   my @followers = @prices[$pos + 1 .. $len - 1].grep( {$_ <= @prices[$pos] } ) ;
   if ( @followers.elems == 0 ) {
      @solution.push( @prices[$pos] ) ;
   }
   else {
      @solution.push( @prices[$pos] - @followers[0] ) ;
   }
}
@solution.push( @prices[*-1] ) ;
say '(' ~ @solution.join( ',' ) ~ ')' ;
