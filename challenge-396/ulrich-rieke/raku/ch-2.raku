use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @differences ;
for (0..@numbers.elems - 2) -> $pos {
   @differences.push( @numbers[$pos] - @numbers[$pos + 1] ) ;
}
if so  0 == @differences.any {
   say False ;
}
else {
   my @firstPart ;
   my @secondPart ;
   my @thirdPart ;
   my $pos = 0 ;
   while ( $pos < @differences.elems && @differences[$pos] < 0  ) {
      @firstPart.push( @differences[$pos] ) ;
      $pos++ ;
   }
   while ( $pos < @differences.elems && @differences[$pos] > 0 ) {
      @secondPart.push( @differences[$pos] ) ;
      $pos++ ;
   }
   while ( $pos < @differences.elems && @differences[$pos] < 0) {
      @thirdPart.push( @differences[$pos] ) ;
      $pos++ ;
   }
   say @firstPart.elems + @secondPart.elems + @thirdPart.elems == 
      @differences.elems && @firstPart.elems > 0 && @secondPart.elems > 0
      && @thirdPart.elems > 0 ;
}
