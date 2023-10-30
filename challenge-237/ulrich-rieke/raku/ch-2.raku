use v6 ;

say "Enter some integers, separated by spaces!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my $max_greatness = 0 ;
my @allPermus = @numbers.permutations ;
for @allPermus -> $permu {
   my $current_greatness = 0 ;
   for (0..$len - 1) -> $pos {
      if ( $permu[ $pos ] > @numbers[ $pos ] ) {
	 $current_greatness++ ;
      }
   }
   if ( $current_greatness > $max_greatness ) {
      $max_greatness = $current_greatness ;
   }
}
say $max_greatness ;
