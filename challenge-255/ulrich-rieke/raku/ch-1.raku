use v6 ;

say "Enter a word!" ;
my $firstWord = $*IN.get ;
say "Enter a second word as a permutation of the first + 1 letter!" ;
my $secondWord = $*IN.get ;
my %firstFreq ;
my %secondFreq ;
for $firstWord.comb -> $letter {
   %firstFreq{ $letter }++ ;
}
for $secondWord.comb -> $letter {
   %secondFreq{ $letter }++ ;
}
say %secondFreq.keys.grep( { (not %firstFreq{$_}:exists) || %secondFreq{$_} != 
      %firstFreq{$_} } )[0] ;
