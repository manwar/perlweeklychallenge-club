use v6 ;
#concatenate by gluing the digits together to a string and by converting
#them to an int afterwards
sub concatenate( $aSequence ) {
   my $total ;
   my $len = $aSequence.elems ;
   for (0..$len - 1 ) -> $num {
      $total ~= $aSequence[ $num ].Str ;
   }
   return $total.Int ;
}

say "Enter some integers greater than 0 , separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @permuted ; #for the concatenated permutations
my @permutations = @numbers.permutations( ) ;
for @permutations -> $permu {
   @permuted.push( concatenate( $permu ) ) ;
}
my @selected = @permuted.grep( { $_ %% 3 } ) ;
if ( @selected.elems > 0 ) {
   @selected .= sort ; #sort in ascending order
   say @selected[*-1] ; #and select the largest one
}
else {#create combinations of decreasing length and permutate each 
#combination. Stop when a number divisible by 3 has been found
   my $len = @numbers.elems ;
   my $i = $len ;
   @permuted = ( ) ;#clear the array we've used before
   while ( $i != 1 ) {
      my @combinations = @numbers.combinations( $i ) ;
      for @combinations -> $combi {
	 my @permu = $combi.permutations( ) ;
	 for @permu -> $aPermu {
	    my $concat = concatenate( $aPermu ) ;
	    @permuted.push( $concat ) ;
	 }
      }
      @selected = @permuted.grep( { $_ %% 3 } ) ;
      if ( @selected ) {
	 @selected .= sort ;
	 last ;
      }
      else {
	 $i-- ;
      }
   }
   if ( @selected ) {
      say @selected[*-1] ;
   }
   else {
      say "-1" ;
   }
}
