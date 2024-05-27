use v6 ;

#the strategy is as follows : if all integers are the same , 0 is the result
#otherwise sum of the differences of all numbers that are smaller than the 
#greatest number( differences from this greatest number )
#then see how you can combine 1's and 2's to get this difference number
#multiply all possible combinations of 1 and 2 with x and y respectively and
#find the smallest number

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter two integers x and y to denote costs for one and two-level operations!" ;
my $costline = $*IN.get ;
my ($x , $y ) = $costline.words.map( {.Int} ) ;
#if all numbers are equal we print out 0
if ( @numbers.grep( { $_ == @numbers[0] } ).elems == @numbers.elems ) {
   say 0 ;
}
else {
   my $maximum = @numbers.max ;
   my @smaller = @numbers.grep( {$_ < $maximum} ) ;
   my $totaldiff = [+] @smaller.map( {$maximum - $_} ) ;
   my $len = @smaller.elems ;
   if ( $len == 1 ) { #we can only do level-1-operations !
      say ( $totaldiff * $x ) ;
   }
   else {
      my @costs ;
      for (0..$totaldiff div 2 ) -> $twos {
	 my $ones = $totaldiff - $twos * 2 ;
#enter the costs to the @costs array !
	 @costs.push( $ones * $x + $twos * $y )
      }
      say @costs.min ;
   }
}
