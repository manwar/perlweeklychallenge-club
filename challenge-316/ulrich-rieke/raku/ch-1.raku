use v6 ;

say "Enter some words separated by blanks!" ;
my $line = $*IN.get ;
my @allWords = $line.words ;
my $len = @allWords.elems ;
my $result = True ;
for (0..$len - 2 ) -> $i {
   if ( @allWords[$i].substr( @allWords[$i].chars - 1 , 1) ne
	 @allWords[$i + 1].substr( 0 , 1 )) {
      $result = False ;
      last ;
   }
}
say $result ;
