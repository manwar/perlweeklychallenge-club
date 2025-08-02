use v6 ;

sub cycle_take( @initial_array, $length) {
   my @final_array ;
   repeat {
      @final_array.push( |@initial_array ) ;
   } until ( @final_array.elems > $length ) ;
   while ( @final_array.elems > $length ) {
      @final_array.pop ;
   }
   return @final_array ;
}

say "Enter a list of 1 and 0 separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter a positive integer!" ;
my $num = $*IN.get ;
my $n = +$num ;
#if we entered only one 1 or 0 it must be false!
my $len = @numbers.elems ;
if ( $len == 1 ) {
   say "false" ;
}
else {
#if there are 2 neighbouring 1 it must be false!
   my $have_neighbouring = False ;
   for (0..$len - 2) -> $pos {
      if ( @numbers[$pos] == 1 && @numbers[$pos + 1] == 1 ) {
	 $have_neighbouring = True ;
	 last ;
      }
   }
   if $have_neighbouring {
      say "false" ;
   }
   else {
#create an array of alternating 1 and 0 as long as the initial array! Depending 
#on whether we do have a 1 in the initial array at all or where we find the first
#1 we "cycle" either 0 1 or 1 0 as often as the initial array is long.
#Afterwards, we zip the initial array with the new array and count the number 
#of times an initial 0 was flipped to 1. It has to be greater than or equal to
#the variable $n!
      my @comparison ;
      my @initial ;
      if ( 1 (elem) @numbers ) {
	 my $pos = 0 ;
	 while ( @numbers[$pos] != 1 ) {
	    $pos++ ;
	 }
	 if ( $pos %% 2 ) {
	    @initial = (1 , 0) ;
	 }
	 else {
	    @initial = (0 , 1) ;
	 }
      } 
      else {
	 @initial = (0 , 1) ;
      }
      @comparison = cycle_take( @initial , $len ) ;
      my @zipped = @numbers Z, @comparison ;
      my @flipped = @zipped.grep( {$_[0] == 0 && $_[1] == 1} ) ;
      say @flipped.elems >= $n ;
   }
}
