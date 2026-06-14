use v6 ;

say "Enter some words separated by blanks!" ;
my $line = $*IN.get ;
my @allWords = $line.words ;
my $len = @allWords.elems ;
my $result = 0 ;
for (0..$len - 2) -> $i {
   for ( $i + 1 .. $len - 1 ) -> $j {
      my $first = @allWords[$i] ;
      my $second = @allWords[$j] ;
      if ( $second ~~ /^$first/ && $second ~~ /$first$/ ) {
         $result++ ;
      }
   }
}
$result.say ;
