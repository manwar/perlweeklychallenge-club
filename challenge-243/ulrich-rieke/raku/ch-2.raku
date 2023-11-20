use v6 ;

say "Enter some integers >= 1, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
if ( @numbers.grep( { $_ == @numbers[0] } ).elems == $len ) {
   say ( @numbers[ 0 ] * $len ) ;
}
else {
   my $sum = 0 ;
   for (0..$len - 1 ) -> $i {
      $sum += @numbers[ $i ] div @numbers[ $i ] ;
      if ( $i < $len - 1 ) {
	 for ( $i + 1 .. $len - 1 ) -> $j {
	    if ( @numbers[ $i ] != @numbers[ $j ] ) {
	       $sum += @numbers[ $i ] div @numbers[ $j ] ;
	       $sum += @numbers[ $j ] div @numbers[ $i ] ;
	    }
	 }
      }
   }
   $sum.say ;
}
