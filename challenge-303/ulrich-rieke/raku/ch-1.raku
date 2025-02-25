use v6 ;

sub to_number( @array ) {
   my $total = 0 ;
   my $multBy = 100 ;
   for @array -> $n {
      $total += $n * $multBy ;
      $multBy div= 10 ;
   }
   return $total ;
}

say "Enter at least 3 single-digit positive numbers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @allSums ;
for @numbers.permutations -> $permu {
   my @currentArray ;
   for (0..2) -> $i {
      @currentArray.push( $permu[$i] ) ;
   }
   if ( @currentArray[0] != 0 ) {
      my $sum = to_number( @currentArray ) ;
      if ( $sum %% 2 ) {
	 @allSums.push( $sum ) ;
      }
   }
}
my %uniques ;
@allSums.map( {%uniques{$_}++} ) ;
say '(' ~ join( ',' , %uniques.keys.sort) ~ ')' ;
