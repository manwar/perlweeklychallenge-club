use v6 ;
#given a certain permutation , we add numbers of the permutation to a 
#current set as long as their absolute difference to the first element is
#1
sub createSublists( $permu ) {
   my @allLists ;
   my @currentList ;
   @currentList.push( $permu[0] ) ;
   my $len = $permu.elems ;
   for (1..$len - 1) -> $pos {
      if ( (@currentList[0] - $permu[$pos]).abs == 1 ) {
	 @currentList.push( $permu[$pos] ) ;
      }
      else {
	 @allLists.push( [ |@currentList] ) ;
	 @currentList = ( ) ;
	 @currentList.push( $permu[$pos] ) ;
      }
   }
   if ( @currentList.elems > 0 ) {
      @allLists.push( [ |@currentList ] ) ;
   }
   return @allLists ;
}

sub findSum( @allLists ) {
   my $sum = 0 ;
   for @allLists -> $subArray {
      $sum += $subArray[0] ;
   }
   return $sum ;
}
#the basic idea is : create all permutations and split every permutation
#in such a way that all integers in every sublist have a difference of 1
#to the first element
say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @allSums ;
my @allPermus = @numbers.permutations ;
for @allPermus -> $permu {
   my @sublists = createSublists( $permu ) ;
   my $sum = findSum( @sublists ) ;
   @allSums.push( $sum ) ;
}
say @allSums.max ;
