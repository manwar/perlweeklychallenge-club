use v6 ;

sub isNeighbouring( @firstIndices , @secondIndices ) {
   my $firstSet = @firstIndices.Set ;
   my $secondSet = @secondIndices.Set ;
   my $common = $firstSet (&) $secondSet ;
   return $common.elems > 0 ;
}

sub contains( @array , $element ) {
   for ( @array ) -> $elt {
      if ( $elt == $element ) {
	 return True ;
      }
   }
   return False ;
}

say "Enter some positive integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
if ( @numbers[0] == 0 ) { #we can't jump anywhere
   say -1 ;
}
elsif ( @numbers[0] >= $len - 1 ) {
   say 1 ; #we jump only once!
}
else {
#for every index , we create an array of indices starting from the present
#index to the indices you can go to
#they are neighbouring if the array sets have an intersection and if none 
#of the arrays has only 1 element, which means it is 0
   my @indexList ; # list of all indices that can be reached from every posit.
   my @currentIndex ; #list of indices reachable from a given index
   for (0..$len - 2) -> $i {
      if ( @numbers[ $i ] == 0 ) {
	 @currentIndex.push( $i ) ;
      }
      else {
	 for (0..@numbers[$i]) -> $p {
	    @currentIndex.push( $i + $p ) ;
	 }
      }
      my @tempArray = @currentIndex ;
      @indexList.push( @tempArray ) ;
      @currentIndex = ( ) ;
   }
   my @neighbours ; #all neighbouring index lists in the sense of the function
#above !
   @neighbours.push( @indexList[0] ) ;
   for (1..$len - 2 ) -> $pos {
      if ( @indexList[$pos].elems > 1 && isNeighbouring( @neighbours[*-1] , 
	       @indexList[$pos] ) ) {
	 if ( contains( @neighbours[*-1] , $len - 1 ) ) {
	    last ;
	 }
	 @neighbours.push( @indexList[ $pos ] ) ;
      }
   }
   if ( not contains( @@neighbours[*-1] , $len - 1 ) ) {
      say -1 ;
   }
   else {
      say @neighbours.elems ;
   }
}
