use v6 ;

say "Enter a word consisting of lowercase English letters only!" ;
my $word = $*IN.get ;
my %frequencies ;
my $result = ' ' ;
for $word.comb -> $letter {
   %frequencies{$letter}++ ;
   if (%frequencies{$letter} == 2) {
      $result = $letter ;
      last ;
   }
}
say $result ;
