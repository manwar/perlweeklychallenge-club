use v6 ;

say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
while ( @numbers.elems > 1 ) {
   @numbers .= sort ;
   my $len = @numbers.elems ;
   if ( @numbers[$len - 2] == @numbers[$len - 1] ) {
      @numbers.pop ;
      @numbers.pop ;
   }
   else {
      @numbers[ $len - 1 ] = @numbers[ $len - 1 ] - @numbers[ $len - 2] ;
      @numbers.splice( $len - 2 , 1 ) ;
   }
}
if ( @numbers.elems == 1 ) {
   say @numbers[0] ;
}
else {
   say 0 ;
}
