use v6 ;

sub count( @array , $elt ) {
   return @array.grep( {$_ == $elt} ).elems ;
}

say "Enter some 0 and 1 separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my $first = @numbers[0] ;
#if all elements are equal we return 0 !
if so $first = @numbers.all {
   say 0 ;
}
else {
   my @pairs ; #for pairs of numbers of 1 and 0
#we start at every point from the beginning to the second from bottom
#and go to the next up until the last element
   for (0..$len - 2 ) -> $start {
      for ($start + 1 .. $len - 1 ) -> $end {
	 my @subarray = @numbers[$start..$end] ;
	 my $count_ones = count( @subarray, 1 ) ;
	 my $count_zeroes = $end + 1 - $start - $count_ones ;
	 @pairs.push( ($count_zeroes , $count_ones) ) ;
      }
   }
   my @selected = @pairs.grep( {$_[0] == $_[1]} ) ;
   my $sellen = @selected.elems ;
   @selected .= sort( {$^a[0] <=> $^b[0]} ) ;
   if ( @selected ) {
      say @selected[$sellen - 1][0] + @selected[$sellen - 1][1] ;
   }
   else {
      say 0 ;
   }
}
