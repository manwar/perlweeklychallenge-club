use v6 ;

sub find ( @array , $element ) {
   my $pos = 0 ;
   while ( @array[$pos] != $element ) {
      $pos++ ;
   }
   return $pos ;
}

sub isAscending( $array ) {
   my $len = $array.elems ;
   for (0..$len - 2) -> $pos {
      if ( $array[$pos + 1 ] - $array[$pos] != 1 ) {
	 return False ;
      }
   }
   return True ;
}
#we create a list of the position of every integer in the first array
#and of the sum of the positions in the first and in the second array
#if part of the array is reversed the sum of the positions in the 2
#arrays must be the same. We make these sums the keys of a hash and
#associate the positions in the first array with it
#output must be true if there is exactly one sum that is associated
#to an ascending list of length > 1
say "Enter a list of integers!" ;
my $line = $*IN.get ;
my @firstnums = $line.words.map( {.Int} ) ;
say "Enter another list with the same integers!" ;
$line = $*IN.get ;
my @secondnums = $line.words.map( {.Int} ) ;
if ( @firstnums.elems == 1 && @secondnums.elems == 1 ) {
   say "True" ;
}
else {
   my @positionsums ;
   for (0..@firstnums.elems - 1) -> $pos {
      @positionsums.push( ($pos , $pos + find( @secondnums ,
		  @firstnums[$pos]))) ;
   }
   my %sums ;
   for @positionsums -> @elt {
      %sums{@elt[1]}.push( @elt[0] ) ;
   }
   my @selected = %sums.values.grep( {$_.elems > 1 && isAscending( $_ )} ) ;
   say ( @selected.elems == 1 ) ;
}
