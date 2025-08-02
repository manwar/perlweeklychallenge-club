use v6 ;

say "Enter a word!" ;
my $firstWord = $*IN.get ;
say "Enter a second word with possible typing errors!" ;
my $secondWord = $*IN.get ;
#the idea is : is the set of characters in the first word the same one 
#as in the second word ? if this is so and the second word is longer than
#the first one we output true else false
my $firstSet = $firstWord.comb.Set ;
my $secondSet = $secondWord.comb.Set ;
say ( $firstSet == $secondSet && $firstWord.chars != $secondWord.chars ) ;
