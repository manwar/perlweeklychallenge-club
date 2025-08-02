use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @evens ;
my @odds ;
my $len = @numbers.elems ;
for (0..$len - 1 ) -> $pos {
   if ( $pos %% 2 ) {
      @evens.push( @numbers[$pos] ) ;
   }
   else {
      @odds.push( @numbers[$pos] ) ;
   }
}
@evens .= sort ;
@odds .= sort( {$^b leg $^a} ) ;
my @merged ;
for (0..$len - 1) -> $pos {
   my $number ;
   if ( $pos %% 2 ) {
      $number = @evens.shift ;
   }
   else {
      $number = @odds.shift ;
   }
   @merged.push( $number ) ;
}
say '(' ~ join( ',' , @merged ) ~ ')' ;
