use v6 ;

say "Enter more than 4 integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
#if all numbers are greater than or equal to 0 or all are smaller than 0 ,
#we sort the array in ascending order. In the first of the above cases, we
#subtract the product of the last 2 numbers from that of the first 2 , 
#otherwise the other way round. If numbers are both negative and positive , 
#we sort in ascending order of absolute values 
my $all_positive = @numbers.grep( {$_ >= 0} ).elems == $len  ;
my $all_negative =  @numbers.grep( {$_ < 0} ).elems == $len ; 
if ( $all_positive || $all_negative ) {
   @numbers .= sort ;
   if ( $all_positive ) {
      say (@numbers[$len - 2] * @numbers[$len - 1] - @numbers[0] * 
	 @numbers[1] ) ;
   }
   if ( $all_negative ) {
      say ( @numbers[0] * @numbers[1] - @numbers[$len - 2] * @numbers[$len 
	    - 1] ) ;
   }
}
else {
   @numbers .= sort( {$^a.abs <=> $^b.abs} ) ;
   say ( @numbers[0] * @numbers[1] - @numbers[$len - 2] * @numbers[$len - 1] )
      ;
}
