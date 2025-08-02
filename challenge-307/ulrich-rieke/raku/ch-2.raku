use v6 ;

sub find_anagrams( @array ) {
   my $len = @array.elems ;
   my $anagramcount = 0 ;
   for (0..$len - 2) -> $pos {
      if ( areAnagrams( @array[$pos] , @array[$pos + 1] )) {
	 $anagramcount++ ;
      }
   }
   return $anagramcount ;
}

sub areAnagrams( $word1 , $word2 ) {
   my @firstLetters = $word1.comb.sort ;
   my @secondLetters = $word2.comb.sort ;
   return ( @firstLetters == @secondLetters ) ;
}

say "Enter some words separated by whitespace!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my $anacount = find_anagrams( @words ) ;
say ( @words.elems - $anacount ) ;

