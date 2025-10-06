use v6 ;
#if the difference of the number of letters and digits is greater than 1 the task
#can't be solved. If the the number of digits is greater than or equal to the number
#of letters we alternatingly take digits and letters from the sorted digits and letters,
#otherwise vice versa
say "Enter a string with lowercase English letters and digits only!" ;
my $word = $*IN.get ;
my @digits ;
my @letters ;
for $word.comb -> $l {
   if ( $l ~~ /\d/ ) {
      @digits.push( $l ) ;
   }
   else {
      @letters.push( $l ) ;
   }
}
if ( @digits.elems - @letters.elems).abs > 1 {
   say "\"\"" ;
}
else {
   @digits .= sort ;
   @letters .= sort ;
   my @solution ;
   if ( @digits.elems >= @letters.elems ) {
      while ( @digits ) {
	 @solution.push( @digits.shift ) ;
	 if ( @letters.elems > 0 ) {
	    @solution.push( @letters.shift ) ;
	 }
      }
   }
   else {
      while ( @letters ) {
	 @solution.push( @letters.shift ) ;
	 if ( @digits.elems > 0 ) {
	    @solution.push( @digits.shift ) ;
	 }
      }
   }
   say @solution.join('') ;
}
